param(
  [int]$Port = 5000,
  [int]$Top = 10,
  [string]$ConfigPath
)

$ErrorActionPreference = 'Stop'

function Import-DotEnvFile {
  param([Parameter(Mandatory = $true)][string]$Path)
  if (-not (Test-Path -LiteralPath $Path)) { return }

  foreach ($line in (Get-Content -LiteralPath $Path -ErrorAction Stop)) {
    $trimmed = $line.Trim()
    if (-not $trimmed) { continue }
    if ($trimmed.StartsWith('#')) { continue }

    $eqIndex = $trimmed.IndexOf('=')
    if ($eqIndex -lt 1) { continue }

    $name = $trimmed.Substring(0, $eqIndex).Trim()
    $value = $trimmed.Substring($eqIndex + 1).Trim()

    if ((($value.StartsWith('"') -and $value.EndsWith('"')) -or ($value.StartsWith("'") -and $value.EndsWith("'"))) -and $value.Length -ge 2) {
      $value = $value.Substring(1, $value.Length - 2)
    }

    if ($name) {
      $existing = $null
      try { $existing = (Get-Item -Path ("Env:$name") -ErrorAction SilentlyContinue).Value } catch { }
      if ([string]::IsNullOrEmpty($value) -and -not [string]::IsNullOrEmpty($existing)) {
        continue
      }
      Set-Item -Path ("Env:$name") -Value $value
    }
  }
}

function Ensure-DabExe {
  param([Parameter(Mandatory = $true)][string]$RepoRoot)

  $dabCmd = Get-Command dab -ErrorAction SilentlyContinue
  if ($dabCmd) { return $dabCmd.Source }

  $globalToolsDab = Join-Path $env:USERPROFILE '.dotnet\tools\dab.exe'
  if (Test-Path -LiteralPath $globalToolsDab) { return $globalToolsDab }

  $toolsDir = Join-Path $RepoRoot 'tools\dab'
  $dabExe = Join-Path $toolsDir 'dab.exe'
  if (Test-Path -LiteralPath $dabExe) { return $dabExe }

  New-Item -ItemType Directory -Force -Path $toolsDir | Out-Null

  $manifestUrl = 'https://github.com/Azure/data-api-builder/releases/latest/download/dab-manifest.json'
  Write-Output "Baixando DAB manifest: $manifestUrl"
  $manifest = Invoke-RestMethod -Uri $manifestUrl -Method Get -ErrorAction Stop

  $asset = $null
  if ($manifest.assets) {
    $asset = $manifest.assets |
      Where-Object { $_.name -match 'win-x64' -and $_.name -match 'net8\.0' -and $_.name -match '\\.zip$' } |
      Select-Object -First 1
  }

  if (-not $asset -or -not $asset.url) {
    throw 'Nao consegui localizar o asset win-x64 no dab-manifest.json.'
  }

  $zipPath = Join-Path $toolsDir $asset.name
  Write-Output "Baixando DAB: $($asset.url)"
  $iwrParams = @{ Uri = $asset.url; OutFile = $zipPath; ErrorAction = 'Stop' }
  if ((Get-Command Invoke-WebRequest).Parameters.ContainsKey('UseBasicParsing')) {
    $iwrParams.UseBasicParsing = $true
  }
  Invoke-WebRequest @iwrParams

  Write-Output 'Extraindo DAB...'
  Expand-Archive -LiteralPath $zipPath -DestinationPath $toolsDir -Force

  $found = Get-ChildItem -LiteralPath $toolsDir -Recurse -Filter 'dab.exe' | Select-Object -First 1
  if (-not $found) { throw 'dab.exe nao encontrado apos extracao.' }

  if ($found.FullName -ne $dabExe) {
    Copy-Item -LiteralPath $found.FullName -Destination $dabExe -Force
  }

  return $dabExe
}

function New-DbConnectionString {
  param(
    [Parameter(Mandatory = $true)][string]$Server,
    [Parameter(Mandatory = $true)][string]$Database,
    [ValidateSet('Windows','Sql')][string]$Auth = 'Windows',
    [string]$Username,
    [string]$Password,
    [bool]$TrustServerCertificate = $true
  )

  $trust = if ($TrustServerCertificate) { 'True' } else { 'False' }

  if ($Auth -eq 'Sql') {
    if (-not $Username) { throw 'MSSQL_USERNAME nao definido (Auth=Sql).' }
    if (-not $Password) { throw 'MSSQL_PASSWORD nao definido (Auth=Sql).' }
    return "Server=$Server;Database=$Database;User ID=$Username;Password=$Password;Encrypt=True;TrustServerCertificate=$trust;Connection Timeout=10;"
  }

  return "Server=$Server;Database=$Database;Integrated Security=True;Encrypt=True;TrustServerCertificate=$trust;Connection Timeout=10;"
}

function Invoke-DbScalar {
  param(
    [Parameter(Mandatory = $true)][string]$ConnectionString,
    [Parameter(Mandatory = $true)][string]$Query
  )

  $conn = $null
  try {
    $conn = New-Object System.Data.SqlClient.SqlConnection($ConnectionString)
    $conn.Open()
    $cmd = $conn.CreateCommand()
    $cmd.CommandTimeout = 60
    $cmd.CommandText = $Query
    return $cmd.ExecuteScalar()
  }
  finally {
    if ($conn) { $conn.Close(); $conn.Dispose() }
  }
}

function Wait-HttpOk {
  param(
    [Parameter(Mandatory = $true)][string]$Url,
    [int]$TimeoutSec = 30
  )

  $deadline = (Get-Date).AddSeconds($TimeoutSec)
  while ((Get-Date) -lt $deadline) {
    try {
      Invoke-RestMethod -Method Get -Uri $Url -TimeoutSec 5 | Out-Null
      return $true
    }
    catch {
      Start-Sleep -Milliseconds 500
    }
  }

  return $false
}

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
Import-DotEnvFile -Path (Join-Path $repoRoot '.env')
Import-DotEnvFile -Path (Join-Path $repoRoot '.env.local')

if (-not $env:MSSQL_SERVER) { throw 'MSSQL_SERVER nao definido em .env/.env.local' }
if (-not $env:MSSQL_DATABASE) { throw 'MSSQL_DATABASE nao definido em .env/.env.local' }

$trust = $true
if ($env:MSSQL_TRUST_SERVER_CERTIFICATE) {
  $trust = @('1','true','yes','y','sim') -contains $env:MSSQL_TRUST_SERVER_CERTIFICATE.ToLowerInvariant()
}

$server = $env:MSSQL_SERVER.Trim().Trim('"').Trim("'")
if ($server -match '^\d{1,3}(?:\.\d{1,3}){3}\\MSSQLSERVER$') {
  $server = ($server -split '\\', 2)[0]
}

$auth = if ($env:MSSQL_AUTH) { $env:MSSQL_AUTH } else { 'Windows' }
$db = $env:MSSQL_DATABASE

$cs = New-DbConnectionString -Server $server -Database $db -Auth $auth -Username $env:MSSQL_USERNAME -Password $env:MSSQL_PASSWORD -TrustServerCertificate $trust

# Connection string para o DAB (usa o mesmo server/db, mas o DAB le via @env('DAB_CONNECTION_STRING'))
$trustText = if ($trust) { 'True' } else { 'False' }
if ($auth -eq 'Sql') {
  $env:DAB_CONNECTION_STRING = "Server=$server;Database=$db;User ID=$($env:MSSQL_USERNAME);Password=$($env:MSSQL_PASSWORD);Encrypt=True;TrustServerCertificate=$trustText;"
} else {
  $env:DAB_CONNECTION_STRING = "Server=$server;Database=$db;Integrated Security=True;Encrypt=True;TrustServerCertificate=$trustText;"
}

# Descobre a maior data existente na view (apenas para validar conectividade/diagnostico)
$schema = [string](Invoke-DbScalar -ConnectionString $cs -Query "SELECT TOP 1 s.name FROM sys.views v JOIN sys.schemas s ON s.schema_id=v.schema_id WHERE v.name='vw_venda_prod' ORDER BY s.name;")
if (-not $schema) { throw "vw_venda_prod nao encontrada no database '$db'" }
$maxData = [string](Invoke-DbScalar -ConnectionString $cs -Query ("SELECT CONVERT(varchar(10), MAX(DATA_VENDA), 23) FROM [{0}].vw_venda_prod;" -f $schema))
if (-not $maxData) { throw 'Nao consegui obter MAX(DATA_VENDA) (view sem dados?)' }

Write-Output ("SQL OK: view={0}.vw_venda_prod; maxData={1}" -f $schema, $maxData)

# Sobe o DAB
$dabExe = Ensure-DabExe -RepoRoot $repoRoot
$cfg = if ($ConfigPath) { $ConfigPath } else { (Join-Path $repoRoot 'dab/dab-config.venda-prod.json') }
if (-not (Test-Path -LiteralPath $cfg)) {
  throw "Config nao encontrado: $cfg"
}
$env:ASPNETCORE_URLS = "http://localhost:$Port"

Write-Output "Iniciando DAB: $dabExe (port $Port)"
$logsDir = Join-Path $repoRoot 'logs'
New-Item -ItemType Directory -Force -Path $logsDir | Out-Null
$dabStdout = Join-Path $logsDir ("dab-stdout-$Port.log")
$dabStderr = Join-Path $logsDir ("dab-stderr-$Port.log")

try {
  $dabProc = Start-Process -FilePath $dabExe -ArgumentList @('start','--config',$cfg,'--no-https-redirect') -PassThru -RedirectStandardOutput $dabStdout -RedirectStandardError $dabStderr
} catch {
  Write-Output ("ERRO ao iniciar o DAB: {0}" -f $_.Exception.Message)
  throw
}

try {
  $readyUrl = "http://localhost:$Port/api/venda_prod?`$first=1"
  if (-not (Wait-HttpOk -Url $readyUrl -TimeoutSec 45)) {
    Write-Output "DAB nao respondeu (rota venda_prod) em 45s. Ultimas linhas do stderr:" 
    if (Test-Path -LiteralPath $dabStderr) { Get-Content -LiteralPath $dabStderr -Tail 80 }
    Write-Output "Ultimas linhas do stdout:" 
    if (Test-Path -LiteralPath $dabStdout) { Get-Content -LiteralPath $dabStdout -Tail 80 }
    throw "DAB nao respondeu em 45s: $readyUrl"
  }

  $url = "http://localhost:$Port/api/venda_prod?`$first=$Top"
  Write-Output "GET $url"
  $resp = Invoke-RestMethod -Method Get -Uri $url -TimeoutSec 30

  # DAB normalmente retorna { value: [...] }
  $rows = $null
  if ($resp -and $resp.value) {
    $rows = @($resp.value)
  } else {
    $rows = @($resp)
  }

  if (-not $rows -or $rows.Count -eq 0) {
    throw 'Endpoint respondeu, mas veio vazio para a data maxima. Verifique filtro/coluna DATA_VENDA.'
  }

  Write-Output ("OK: retornou {0} linhas para DATA_VENDA={1}" -f $rows.Count, $maxData)
  Write-Output 'Amostra (primeira linha):'
  ($rows | Select-Object -First 1 | ConvertTo-Json -Depth 6)
}
finally {
  if ($dabProc -and -not $dabProc.HasExited) {
    Stop-Process -Id $dabProc.Id -Force -ErrorAction SilentlyContinue
  }
}
