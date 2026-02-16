param(
  [Parameter(Mandatory = $false)]
  [string]$RepoRoot = 'C:\Github\cockpit-dab',

  [Parameter(Mandatory = $false)]
  [int]$Port = 5000,

  [Parameter(Mandatory = $false)]
  [string]$ConfigPath = (Join-Path 'C:\Github\cockpit-dab' 'dab\dab-config.json'),

  [Parameter(Mandatory = $false)]
  [string]$IisWebConfigPath = 'C:\inetpub\api.grupoarantes.emp.br\web.config',

  [Parameter(Mandatory = $false)]
  [string[]]$StatusDirs = @(
    'C:\inetpub\api.grupoarantes.emp.br\status',
    'C:\inetpub\wwwroot\status'
  ),

  [Parameter(Mandatory = $false)]
  [switch]$Loop,

  [Parameter(Mandatory = $false)]
  [int]$IntervalSec = 30
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

if ($StatusDirs -and $StatusDirs.Count -eq 1 -and ($StatusDirs[0] -is [string]) -and $StatusDirs[0].Contains(',')) {
  $StatusDirs = $StatusDirs[0].Split(',') | ForEach-Object { $_.Trim() } | Where-Object { $_ }
}

function Get-DerivedApiKeyFromWebConfig {
  param(
    [Parameter(Mandatory = $true)]
    [string]$WebConfigPath
  )

  if (-not (Test-Path -LiteralPath $WebConfigPath)) {
    return $null
  }

  try {
    [xml]$x = Get-Content -LiteralPath $WebConfigPath
    $rules = $x.configuration.'system.webServer'.rewrite.rules.rule
    $require = $rules | Where-Object { $_.name -eq 'RequireApiKey' }
    if (-not $require) {
      return $null
    }

    $cond = @($require.conditions.add) | Where-Object { $_.input -eq '{HTTP_X_API_KEY}' } | Select-Object -First 1
    if (-not $cond) {
      return $null
    }

    $pattern = [string]$cond.pattern
    if (-not $pattern) {
      return $null
    }

    # Best-effort: if the pattern looks like a literal (no regex meta), treat it as the API key.
    $patternNoAnchors = $pattern -replace '^\^', '' -replace '\$$', ''
    $patternNoFlags = $patternNoAnchors -replace '\(\?i\)', '' -replace '^\(\?i\)', ''

    $hasRegexMeta = ($patternNoFlags -match '[\[\]\(\)\|\.\+\*\?\{\}]')
    if ($hasRegexMeta) {
      return $null
    }

    return $patternNoFlags
  } catch {
    return $null
  }
}

function Get-HttpStatusCode {
  param(
    [Parameter(Mandatory = $true)]
    [string]$Url,

    [Parameter(Mandatory = $false)]
    [hashtable]$Headers = $null,

    [Parameter(Mandatory = $false)]
    [int]$TimeoutSec = 10
  )

  try {
    $resp = Invoke-WebRequest -Uri $Url -Headers $Headers -UseBasicParsing -TimeoutSec $TimeoutSec
    return [int]$resp.StatusCode
  } catch {
    $r = $_.Exception.Response
    if ($r -and $r.StatusCode) {
      try { return [int]$r.StatusCode.Value__ } catch { }
    }
    return $null
  }
}

function Test-TcpPort {
  param(
    [Parameter(Mandatory = $true)]
    [int]$Port
  )

  try {
    $client = New-Object System.Net.Sockets.TcpClient
    $async = $client.BeginConnect('127.0.0.1', $Port, $null, $null)
    $ok = $async.AsyncWaitHandle.WaitOne(500)
    if ($ok -and $client.Connected) {
      $client.Close()
      return $true
    }
    $client.Close()
    return $false
  } catch {
    return $false
  }
}

function Read-DotEnvFile {
  param(
    [Parameter(Mandatory = $true)]
    [string]$Path
  )

  $map = @{}
  if (-not (Test-Path -LiteralPath $Path)) { return $map }

  foreach ($line in (Get-Content -LiteralPath $Path -ErrorAction SilentlyContinue)) {
    if (-not $line) { continue }
    $t = $line.Trim()
    if (-not $t -or $t.StartsWith('#')) { continue }

    $idx = $t.IndexOf('=')
    if ($idx -lt 1) { continue }

    $k = $t.Substring(0, $idx).Trim()
    $v = $t.Substring($idx + 1).Trim()
    if ($v.StartsWith('"') -and $v.EndsWith('"') -and $v.Length -ge 2) {
      $v = $v.Substring(1, $v.Length - 2)
    }
    if ($v.StartsWith("'") -and $v.EndsWith("'") -and $v.Length -ge 2) {
      $v = $v.Substring(1, $v.Length - 2)
    }
    if ($k) { $map[$k] = $v }
  }

  return $map
}

function Get-ConnectionStringFromEnvOrDotEnv {
  param(
    [Parameter(Mandatory = $true)]
    [string]$RepoRoot
  )

  function Get-EnvAnyScope([string]$Name) {
    try {
      $item = Get-Item -Path ("Env:" + $Name) -ErrorAction SilentlyContinue
      if ($item -and $item.Value) { return $item.Value }
    } catch { }
    try {
      $v = [Environment]::GetEnvironmentVariable($Name, 'Process')
      if ($v) { return $v }
    } catch { }
    try {
      $v = [Environment]::GetEnvironmentVariable($Name, 'User')
      if ($v) { return $v }
    } catch { }
    try {
      $v = [Environment]::GetEnvironmentVariable($Name, 'Machine')
      if ($v) { return $v }
    } catch { }
    return $null
  }

  $dabCs = Get-EnvAnyScope 'DAB_CONNECTION_STRING'
  if ($dabCs) { return $dabCs }

  $dotenv = @{}
  foreach ($p in @((Join-Path $RepoRoot '.env'), (Join-Path $RepoRoot '.env.local'))) {
    $m = Read-DotEnvFile -Path $p
    foreach ($k in $m.Keys) { $dotenv[$k] = $m[$k] }
  }

  $server = $(if ($dotenv['MSSQL_SERVER']) { $dotenv['MSSQL_SERVER'] } else { (Get-EnvAnyScope 'MSSQL_SERVER') })
  $db = $(if ($dotenv['MSSQL_DATABASE']) { $dotenv['MSSQL_DATABASE'] } else { (Get-EnvAnyScope 'MSSQL_DATABASE') })
  $auth = $(if ($dotenv['MSSQL_AUTH']) { $dotenv['MSSQL_AUTH'] } else { (Get-EnvAnyScope 'MSSQL_AUTH') })
  $user = $(if ($dotenv['MSSQL_USERNAME']) { $dotenv['MSSQL_USERNAME'] } else { (Get-EnvAnyScope 'MSSQL_USERNAME') })
  $pass = $(if ($dotenv['MSSQL_PASSWORD']) { $dotenv['MSSQL_PASSWORD'] } else { (Get-EnvAnyScope 'MSSQL_PASSWORD') })

  if (-not $server -or -not $db) {
    return $null
  }

  # Normalize server if it contains instance name like IP\MSSQLSERVER
  if ($server -match '^(\d+\.\d+\.\d+\.\d+)\\') {
    $server = $Matches[1]
  }

  $base = "Server=$server;Database=$db;Encrypt=True;TrustServerCertificate=True;"
  if ($auth -and $auth.ToLowerInvariant() -eq 'sql') {
    if (-not $user -or -not $pass) { return $null }
    return $base + "User ID=$user;Password=$pass;"
  }

  return $base + 'Integrated Security=True;'
}

function Get-SqlViewsCatalog {
  param(
    [Parameter(Mandatory = $true)]
    [string]$ConnectionString
  )

  $rows = @()
  $cn = New-Object System.Data.SqlClient.SqlConnection($ConnectionString)
  try {
    $cn.Open()
    $cmd = $cn.CreateCommand()
    $cmd.CommandTimeout = 15
    $cmd.CommandText = @"
SELECT
  s.name AS schema_name,
  v.name AS view_name,
  v.create_date,
  v.modify_date
FROM sys.views v
JOIN sys.schemas s ON s.schema_id = v.schema_id
WHERE s.name = 'dbo'
ORDER BY v.name;
"@
    $r = $cmd.ExecuteReader()
    while ($r.Read()) {
      $rows += [pscustomobject]@{
        schema = [string]$r['schema_name']
        name = [string]$r['view_name']
        create_date = ([datetime]$r['create_date']).ToString('s')
        modify_date = ([datetime]$r['modify_date']).ToString('s')
      }
    }
    $r.Close()
  } finally {
    try { $cn.Close() } catch { }
  }

  return $rows
}

function Get-DabEntitiesCatalog {
  param(
    [Parameter(Mandatory = $true)]
    [string]$ConfigPath
  )

  if (-not (Test-Path -LiteralPath $ConfigPath)) {
    return @()
  }

  $json = Get-Content -LiteralPath $ConfigPath -Raw | ConvertFrom-Json
  $out = @()
  $entities = $json.entities
  if (-not $entities) { return @() }

  foreach ($p in $entities.PSObject.Properties) {
    $ename = $p.Name
    $e = $p.Value
    $srcObj = $null
    $srcSch = $null
    try { $srcObj = $e.source.object } catch { }
    try { $srcSch = $e.source.schema } catch { }
    $out += [pscustomobject]@{
      entity = $ename
      source_schema = $srcSch
      source_object = $srcObj
      source_full = $(if ($srcSch -and $srcObj) { "$srcSch.$srcObj" } elseif ($srcObj) { $srcObj } else { $null })
    }
  }

  return $out
}

function Write-StatusJson {
  param(
    [Parameter(Mandatory = $true)]
    [string]$Dir,

    [Parameter(Mandatory = $true)]
    [hashtable]$Status
  )

  if (-not (Test-Path -LiteralPath $Dir)) {
    New-Item -ItemType Directory -Force -Path $Dir | Out-Null
  }

  $path = Join-Path $Dir 'status.json'
  ($Status | ConvertTo-Json -Depth 6) | Set-Content -LiteralPath $path -Encoding UTF8
}

function Invoke-WatchdogOnce {
  param(
    [Parameter(Mandatory = $true)]
    [string]$RepoRoot,

    [Parameter(Mandatory = $true)]
    [int]$Port,

    [Parameter(Mandatory = $true)]
    [string]$ConfigPath,

    [Parameter(Mandatory = $true)]
    [string]$IisWebConfigPath,

    [Parameter(Mandatory = $true)]
    [string[]]$StatusDirs
  )

  # Ensure DAB is running (and starts if needed)
  $ensureScript = Join-Path $RepoRoot 'scripts\ensure-dab-running.ps1'
  $preferredDabExe = Join-Path $RepoRoot 'tools\dab\dab.exe'
  $watchdogLog = Join-Path $RepoRoot 'logs\dab-watchdog.log'
  if (-not (Test-Path -LiteralPath (Split-Path -Parent $watchdogLog))) {
    New-Item -ItemType Directory -Force -Path (Split-Path -Parent $watchdogLog) | Out-Null
  }

  $ensureOk = $false
  $ensureError = $null

  try {
    if (-not (Test-Path -LiteralPath $ensureScript)) {
      throw "Script não encontrado: $ensureScript"
    }

    $usePreferred = $false
    if (Test-Path -LiteralPath $preferredDabExe) {
      try {
        & $preferredDabExe --version *> $null
        $usePreferred = ($LASTEXITCODE -eq 0)
      } catch {
        $usePreferred = $false
      }
    }

    if ($usePreferred) {
      & $ensureScript -RepoRoot $RepoRoot -Port $Port -ConfigPath $ConfigPath -DabExePath $preferredDabExe | Out-Null
    } else {
      & $ensureScript -RepoRoot $RepoRoot -Port $Port -ConfigPath $ConfigPath | Out-Null
    }
    $ensureOk = $true
  } catch {
    $ensureOk = $false
    $ensureError = $_.Exception.Message
    ("[{0}] ensure-dab-running FAILED: {1}" -f (Get-Date).ToString('s'), $ensureError) | Add-Content -LiteralPath $watchdogLog -Encoding UTF8
  }

  # Collect status for the panel
  $dabProc = Get-Process dab -ErrorAction SilentlyContinue | Select-Object -First 1
  $portOpen = Test-TcpPort -Port $Port

  $localHealthUrl = "http://localhost:$Port/api/health"
  $publicHealthUrl = 'https://api.grupoarantes.emp.br/v1/health'

  $localHealth = Get-HttpStatusCode -Url $localHealthUrl -TimeoutSec 10
  $publicHealthNoKey = Get-HttpStatusCode -Url $publicHealthUrl -TimeoutSec 15

  $derivedKey = Get-DerivedApiKeyFromWebConfig -WebConfigPath $IisWebConfigPath
  $publicHealthWithKey = $null
  if ($derivedKey) {
    $headers = @{ 'X-API-Key' = $derivedKey; 'Accept' = 'application/json' }
    $publicHealthWithKey = Get-HttpStatusCode -Url $publicHealthUrl -Headers $headers -TimeoutSec 15
  }

  $status = @{
    timestamp = (Get-Date).ToString('s')
    ensure = @{
      ok = $ensureOk
      error = $ensureError
    }
    dab = @{
      processRunning = [bool]$dabProc
      pid = $(if ($dabProc) { [int]$dabProc.Id } else { $null })
      port = $Port
      portOpen = $portOpen
    }
    health = @{
      localUrl = $localHealthUrl
      localStatus = $localHealth
      publicUrl = $publicHealthUrl
      publicStatusNoKey = $publicHealthNoKey
      publicStatusWithKey = $publicHealthWithKey
    }
  }

  # Catalog for humans: SQL views x DAB entities
  $catalog = @{
    timestamp = (Get-Date).ToString('s')
    sql = @{
      ok = $false
      error = $null
      views = @()
    }
    dab = @{
      configPath = $ConfigPath
      entities = @()
    }
    diff = @{
      viewsNotExposed = @()
    }
  }

  try {
    $catalog.dab.entities = @(Get-DabEntitiesCatalog -ConfigPath $ConfigPath)
  } catch {
    # don't fail watchdog because of catalog
  }

  try {
    $cs = Get-ConnectionStringFromEnvOrDotEnv -RepoRoot $RepoRoot
    if (-not $cs) { throw 'Não consegui obter connection string (DAB_CONNECTION_STRING ou MSSQL_* em .env/.env.local).' }
    $catalog.sql.views = @(Get-SqlViewsCatalog -ConnectionString $cs)
    $catalog.sql.ok = $true
  } catch {
    $catalog.sql.ok = $false
    $catalog.sql.error = $_.Exception.Message
  }

  try {
    $sqlViewNames = @()
    foreach ($v in @($catalog.sql.views)) { $sqlViewNames += [string]$v.name }
    $dabObjects = @()
    foreach ($e in @($catalog.dab.entities)) {
      if ($e.source_object) { $dabObjects += [string]$e.source_object }
    }
    $dabViewNames = @(
      $dabObjects | ForEach-Object {
        $s = [string]$_
        if ($s -match '\.') { return ($s.Split('.') | Select-Object -Last 1) }
        return $s
      }
    )
    $catalog.diff.viewsNotExposed = @($sqlViewNames | Where-Object { $_ -and ($_ -notin $dabViewNames) })
  } catch {
  }

  $writeResults = @()

  foreach ($dir in $StatusDirs) {
    $entry = @{ dir = $dir; ok = $false; error = $null }
    try {
      Write-StatusJson -Dir $dir -Status $status
      $entry.ok = $true
    } catch {
      $entry.error = $_.Exception.Message
      try {
        ("[{0}] FAILED writing status.json to {1}: {2}" -f (Get-Date).ToString('s'), $dir, $_.Exception.Message) | Add-Content -LiteralPath $watchdogLog -Encoding UTF8
      } catch { }
    }
    $writeResults += $entry
  }

  $status.write = $writeResults

  foreach ($dir in $StatusDirs) {
    try {
      Write-StatusJson -Dir $dir -Status $status
    } catch {
      try {
        ("[{0}] FAILED writing status.json (final) to {1}: {2}" -f (Get-Date).ToString('s'), $dir, $_.Exception.Message) | Add-Content -LiteralPath $watchdogLog -Encoding UTF8
      } catch { }
    }
  }

  foreach ($dir in $StatusDirs) {
    try {
      if (-not (Test-Path -LiteralPath $dir)) {
        New-Item -ItemType Directory -Force -Path $dir | Out-Null
      }
      $catalogPath = Join-Path $dir 'catalog.json'
      ($catalog | ConvertTo-Json -Depth 7) | Set-Content -LiteralPath $catalogPath -Encoding UTF8
    } catch {
      try {
        ("[{0}] FAILED writing catalog.json to {1}: {2}" -f (Get-Date).ToString('s'), $dir, $_.Exception.Message) | Add-Content -LiteralPath $watchdogLog -Encoding UTF8
      } catch { }
    }
  }
}

if ($Loop) {
  while ($true) {
    Invoke-WatchdogOnce -RepoRoot $RepoRoot -Port $Port -ConfigPath $ConfigPath -IisWebConfigPath $IisWebConfigPath -StatusDirs $StatusDirs
    Start-Sleep -Seconds $IntervalSec
  }
} else {
  Invoke-WatchdogOnce -RepoRoot $RepoRoot -Port $Port -ConfigPath $ConfigPath -IisWebConfigPath $IisWebConfigPath -StatusDirs $StatusDirs
}
