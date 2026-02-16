param(
  [int]$Port = 5000,
  [string]$ConfigPath,
  [string]$ServerInstance,
  [string]$Database,
  [ValidateSet('Windows','Sql')][string]$Auth,
  [string]$Username
)

$ErrorActionPreference = 'Stop'

# Evita acentos quebrados em alguns consoles/hosts
try {
  [Console]::OutputEncoding = [System.Text.UTF8Encoding]::new($false)
  $OutputEncoding = [System.Text.UTF8Encoding]::new($false)
} catch { }

function Import-DotEnvFile {
  param([Parameter(Mandatory = $true)][string]$Path)
  if (-not (Test-Path -LiteralPath $Path)) { return }

  $lines = Get-Content -LiteralPath $Path -ErrorAction Stop
  foreach ($line in $lines) {
    $trimmed = $line.Trim()
    if (-not $trimmed) { continue }
    if ($trimmed.StartsWith('#')) { continue }

    $eqIndex = $trimmed.IndexOf('=')
    if ($eqIndex -lt 1) { continue }

    $name = $trimmed.Substring(0, $eqIndex).Trim()
    $value = $trimmed.Substring($eqIndex + 1).Trim()

    if (($value.StartsWith('"') -and $value.EndsWith('"')) -or ($value.StartsWith("'") -and $value.EndsWith("'"))) {
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

function Get-RequiredViewObjectsFromDabConfig {
  param([Parameter(Mandatory = $true)][string]$ConfigPath)

  if (-not (Test-Path -LiteralPath $ConfigPath)) {
    throw "Config do DAB nao encontrado: $ConfigPath"
  }

  $cfgObj = Get-Content -LiteralPath $ConfigPath -Raw | ConvertFrom-Json
  if (-not $cfgObj.entities) { return @() }

  $objects = @()
  foreach ($p in $cfgObj.entities.PSObject.Properties) {
    $e = $p.Value
    if (-not $e.source) { continue }
    if ($e.source.type -ne 'view') { continue }
    if ($e.source.object) { $objects += [string]$e.source.object }
  }

  $objects |
    Where-Object { $_ -and $_.Trim() } |
    ForEach-Object { $_.Trim() } |
    Sort-Object -Unique
}

function Get-LocalSqlServerInstanceCandidate {
  # Tenta achar instancias locais instaladas via servicos do Windows.
  # Retorna string no formato: localhost ou localhost\NOME
  try {
    $services = Get-Service -Name 'MSSQLSERVER','MSSQL$*' -ErrorAction SilentlyContinue
  } catch {
    return $null
  }

  if ($services | Where-Object { $_.Name -eq 'MSSQLSERVER' -and $_.Status -eq 'Running' }) {
    return 'localhost'
  }

  $named = $services |
    Where-Object { $_.Name -like 'MSSQL$*' -and $_.Status -eq 'Running' } |
    Select-Object -First 1

  if ($named) {
    $instanceName = ($named.Name -split '\$', 2)[1]
    if ($instanceName) {
      return "localhost\\$instanceName"
    }
  }

  return $null
}

function New-DbConnectionString {
  param(
    [Parameter(Mandatory = $true)][string]$Server,
    [string]$Database,
    [ValidateSet('Windows','Sql')][string]$Auth = 'Windows',
    [string]$Username,
    [string]$Password,
    [string]$TrustServerCertificate = 'True'
  )

  $base = "Server=$Server;Encrypt=True;TrustServerCertificate=$TrustServerCertificate;"
  if ($Database) { $base += "Database=$Database;" }

  if ($Auth -eq 'Sql') {
    if (-not $Username) { throw 'Username obrigatorio para Auth=Sql.' }
    if (-not $Password) { throw 'Password obrigatorio para Auth=Sql.' }
    return $base + "User ID=$Username;Password=$Password;"
  }

  return $base + 'Integrated Security=True;'
}

function Invoke-DbScalar {
  param(
    [Parameter(Mandatory = $true)][string]$ConnectionString,
    [Parameter(Mandatory = $true)][string]$Query
  )

  $conn = $null
  try {
    $conn = [System.Data.SqlClient.SqlConnection]::new($ConnectionString)
    $conn.Open()
    $cmd = $conn.CreateCommand()
    $cmd.CommandTimeout = 15
    $cmd.CommandText = $Query
    return $cmd.ExecuteScalar()
  } finally {
    if ($conn) { $conn.Dispose() }
  }
}

function Get-DbNames {
  param([Parameter(Mandatory = $true)][string]$ConnectionString)

  $conn = $null
  $names = @()
  try {
    $conn = [System.Data.SqlClient.SqlConnection]::new($ConnectionString)
    $conn.Open()
    $cmd = $conn.CreateCommand()
    $cmd.CommandTimeout = 30
    $cmd.CommandText = 'SELECT name FROM sys.databases WHERE state_desc = ''ONLINE'' ORDER BY name'
    $r = $cmd.ExecuteReader()
    while ($r.Read()) {
      $names += [string]$r.GetValue(0)
    }
    $r.Close()
    return $names
  } finally {
    if ($conn) { $conn.Dispose() }
  }
}

function Test-ViewExists {
  param(
    [Parameter(Mandatory = $true)][string]$ConnectionString,
    [Parameter(Mandatory = $true)][string]$DbName,
    [Parameter(Mandatory = $true)][string]$Schema,
    [Parameter(Mandatory = $true)][string]$ViewName
  )

  $escapedDb = $DbName.Replace(']', ']]')
  $escapedSchema = $Schema.Replace("'", "''")
  $escapedView = $ViewName.Replace("'", "''")

  $q = "USE [$escapedDb]; SELECT IIF(EXISTS(SELECT 1 FROM sys.views v JOIN sys.schemas s ON s.schema_id=v.schema_id WHERE s.name='$escapedSchema' AND v.name='$escapedView'), 1, 0);"
  $result = Invoke-DbScalar -ConnectionString $ConnectionString -Query $q
  return [int]$result -eq 1
}

function Find-DatabaseWithRequiredViews {
  param(
    [Parameter(Mandatory = $true)][string]$ConnectionStringNoDb,
    [Parameter(Mandatory = $true)][string[]]$RequiredObjects
  )

  if (-not $RequiredObjects -or $RequiredObjects.Count -eq 0) {
    return $null
  }

  $requiredParsed = foreach ($o in $RequiredObjects) {
    $parts = $o -split '\.', 2
    if ($parts.Count -eq 2) {
      [PSCustomObject]@{ Schema = $parts[0]; Name = $parts[1] }
    } else {
      [PSCustomObject]@{ Schema = 'dbo'; Name = $o }
    }
  }

  $dbs = Get-DbNames -ConnectionString $ConnectionStringNoDb
  foreach ($db in $dbs) {
    $allOk = $true
    foreach ($req in $requiredParsed) {
      if (-not (Test-ViewExists -ConnectionString $ConnectionStringNoDb -DbName $db -Schema $req.Schema -ViewName $req.Name)) {
        $allOk = $false
        break
      }
    }
    if ($allOk) { return $db }
  }

  return $null
}

function Ensure-EnvLocal {
  param(
    [Parameter(Mandatory = $true)][string]$RepoRoot,
    [string]$ServerInstance,
    [string]$Database,
    [string]$Auth,
    [string]$Username
  )

  $envLocal = Join-Path $RepoRoot '.env.local'
  if (Test-Path -LiteralPath $envLocal) { return }

  $example = Join-Path $RepoRoot '.env.example'
  if (-not (Test-Path -LiteralPath $example)) { return }

  Copy-Item -LiteralPath $example -Destination $envLocal -Force

  $lines = Get-Content -LiteralPath $envLocal -ErrorAction Stop
  $out = foreach ($l in $lines) {
    if ($ServerInstance -and $l -match '^\s*MSSQL_SERVER\s*=') { "MSSQL_SERVER=$ServerInstance"; continue }
    if ($Database -and $l -match '^\s*MSSQL_DATABASE\s*=') { "MSSQL_DATABASE=$Database"; continue }
    if ($Auth -and $l -match '^\s*MSSQL_AUTH\s*=') { "MSSQL_AUTH=$Auth"; continue }
    if ($Username -and $l -match '^\s*MSSQL_USERNAME\s*=') { "MSSQL_USERNAME=$Username"; continue }
    $l
  }

  Set-Content -LiteralPath $envLocal -Value $out -Encoding UTF8
}

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
Import-DotEnvFile -Path (Join-Path $repoRoot '.env')
Import-DotEnvFile -Path (Join-Path $repoRoot '.env.local')

$trust = 'True'
if ($env:MSSQL_TRUST_SERVER_CERTIFICATE) { $trust = $env:MSSQL_TRUST_SERVER_CERTIFICATE }

$cfg = $null
if ($ConfigPath) {
  $candidate = $ConfigPath
  if (-not [System.IO.Path]::IsPathRooted($candidate)) {
    $candidate = Join-Path $repoRoot $candidate
  }
  $cfg = (Resolve-Path -LiteralPath $candidate).Path
} else {
  $cfg = Join-Path $repoRoot 'dab/dab-config.json'
}

# Defaults: parametros > env
if (-not $ServerInstance) { $ServerInstance = $env:MSSQL_SERVER }
if (-not $Database) { $Database = $env:MSSQL_DATABASE }
if (-not $Auth) { $Auth = $(if ($env:MSSQL_AUTH) { $env:MSSQL_AUTH } else { 'Windows' }) }
if (-not $Username) { $Username = $env:MSSQL_USERNAME }

if (-not $ServerInstance) {
  $ServerInstance = Get-LocalSqlServerInstanceCandidate
}

if (-not $ServerInstance) {
  $ServerInstance = Read-Host "MSSQL_SERVER nao definido. Informe o servidor/instancia (ex: localhost ou SERVIDOR\\INSTANCIA)"
}

if (-not $ServerInstance) {
  throw @"
MSSQL_SERVER nao definido.
Preencha .env.local (copie de .env.example) ou rode:
  .\scripts\run-local.ps1 -ServerInstance 'SERVIDOR\INSTANCIA' -Database 'SEU_BANCO'
Docs: docs/mssql.md
"@
}

$requiredObjects = Get-RequiredViewObjectsFromDabConfig -ConfigPath $cfg

if (-not $Database) {
  # Tenta descobrir o database que contem as views exigidas pelo dab-config.json.
  $pwPlain = $null
  if ($Auth -eq 'Sql') {
    if (-not $Username) { throw 'Auth=Sql requer -Username (ou MSSQL_USERNAME).' }
    if (-not $env:MSSQL_PASSWORD) {
      $pw = Read-Host 'Senha do SQL (não será exibida)' -AsSecureString
      $pwPlain = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($pw))
    } else {
      $pwPlain = $env:MSSQL_PASSWORD
    }
  }

  $csNoDb = New-DbConnectionString -Server $ServerInstance -Auth $Auth -Username $Username -Password $pwPlain -TrustServerCertificate $trust
  try {
    $Database = Find-DatabaseWithRequiredViews -ConnectionStringNoDb $csNoDb -RequiredObjects $requiredObjects
  } catch {
    # Ignora aqui e cai na mensagem guiada abaixo
  }
}

if (-not $Database) {
  $Database = Read-Host "MSSQL_DATABASE nao definido. Informe o banco onde as views dbo.vw_* existem (ex: datalake)"
}

if (-not $Database) {
  throw @"
MSSQL_DATABASE nao definido.
Informe o banco onde as views do DAB existem (ex.: datalake).
Exemplo:
  .\scripts\run-local.ps1 -ServerInstance '$ServerInstance' -Database 'SEU_BANCO'
Se as views nao existirem, rode:
  .\scripts\apply-views.ps1
"@
}

Ensure-EnvLocal -RepoRoot $repoRoot -ServerInstance $ServerInstance -Database $Database -Auth $Auth -Username $Username

# Normalizacao: IP\MSSQLSERVER -> IP
$server = $ServerInstance.Trim().Trim('"').Trim("'")
if ($server -match '^\d{1,3}(?:\.\d{1,3}){3}\\MSSQLSERVER$') {
  $server = ($server -split '\\', 2)[0]
}

# Monta uma unica connection string para o DAB
if ($Auth -eq 'Sql') {
  if (-not $Username) { throw 'MSSQL_USERNAME nao definido (Auth=Sql). Defina MSSQL_USERNAME ou passe -Username.' }
  if (-not $env:MSSQL_PASSWORD) {
    $pw = Read-Host 'Senha do SQL (não será exibida)' -AsSecureString
    $env:MSSQL_PASSWORD = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($pw))
  }

  $env:DAB_CONNECTION_STRING = "Server=$server;Database=$Database;User ID=$Username;Password=$($env:MSSQL_PASSWORD);Encrypt=True;TrustServerCertificate=$trust;"
} else {
  $env:DAB_CONNECTION_STRING = "Server=$server;Database=$Database;Integrated Security=True;Encrypt=True;TrustServerCertificate=$trust;"
}

# Garante DAB (preferindo binário baixado, pois pode não haver .NET SDK)
$dabCmd = Get-Command dab -ErrorAction SilentlyContinue
$dabExe = $null

if ($dabCmd) {
  $dabExe = $dabCmd.Source
} else {
  $globalToolsDab = Join-Path $env:USERPROFILE '.dotnet\\tools\\dab.exe'
  if (Test-Path -LiteralPath $globalToolsDab) {
    $dabExe = $globalToolsDab
  } else {
  $toolsDir = Join-Path $repoRoot 'tools\\dab'
  $dabExe = Join-Path $toolsDir 'dab.exe'

  if (-not (Test-Path -LiteralPath $dabExe)) {
    New-Item -ItemType Directory -Force -Path $toolsDir | Out-Null

    $manifestUrl = 'https://github.com/Azure/data-api-builder/releases/latest/download/dab-manifest.json'
    Write-Output "Baixando DAB (manifest): $manifestUrl"
    try {
      $manifest = Invoke-RestMethod -Uri $manifestUrl -Method Get -ErrorAction Stop
    } catch {
      throw (
        "Não consegui baixar o DAB do GitHub (sem acesso à internet/proxy).\n" +
        "Opções:\n" +
        "1) Instalar o DAB manualmente e deixar o executável em tools/dab/dab.exe\n" +
        "2) Liberar acesso a https://github.com/Azure/data-api-builder/releases/latest/download/\n" +
        "3) Instalar o .NET SDK e disponibilizar o comando 'dab' no PATH.\n" +
        "Erro original: $($_.Exception.Message)"
      )
    }

    $assetUrl = $null
    $assetName = $null

    $entry = $manifest
    if ($manifest -is [System.Array]) {
      $entry = $manifest | Where-Object { $_.version -eq 'latest' } | Select-Object -First 1
      if (-not $entry) { $entry = $manifest | Select-Object -First 1 }
    }

    if ($entry -and $entry.files -and $entry.files.'win-x64' -and $entry.files.'win-x64'.url) {
      $assetUrl = [string]$entry.files.'win-x64'.url
      $assetName = [System.IO.Path]::GetFileName($assetUrl)
    } elseif ($entry -and $entry.assets) {
      $asset = $entry.assets |
        Where-Object { $_.name -match 'win-x64' -and $_.name -match 'net8\.0' -and $_.name -match '\\.zip$' } |
        Select-Object -First 1
      if ($asset -and $asset.url) {
        $assetUrl = [string]$asset.url
        $assetName = [string]$asset.name
      }
    }

    if (-not $assetUrl -or -not $assetName) {
      throw 'Não consegui localizar o asset win-x64 no dab-manifest.json. Verifique acesso à internet/GitHub.'
    }

    $zipPath = Join-Path $toolsDir $assetName
    Write-Output "Baixando DAB: $assetUrl"
    $iwrParams = @{ Uri = $assetUrl; OutFile = $zipPath; ErrorAction = 'Stop' }
    if ((Get-Command Invoke-WebRequest).Parameters.ContainsKey('UseBasicParsing')) {
      $iwrParams.UseBasicParsing = $true
    }
    Invoke-WebRequest @iwrParams

    Write-Output 'Extraindo...'
    Expand-Archive -LiteralPath $zipPath -DestinationPath $toolsDir -Force

    function Test-DabLikeExe([string]$Path) {
      if (-not $Path -or -not (Test-Path -LiteralPath $Path)) { return $false }
      try {
        & $Path --version *> $null
        return ($LASTEXITCODE -eq 0)
      } catch { return $false }
    }

    $preferred = @(
      (Join-Path $toolsDir 'dab.exe'),
      (Join-Path $toolsDir 'Microsoft.DataApiBuilder.exe'),
      (Join-Path $toolsDir 'Azure.DataApiBuilder.Service.exe')
    )

    $foundPath = $null
    foreach ($p in $preferred) {
      if (Test-DabLikeExe -Path $p) { $foundPath = $p; break }
    }

    if (-not $foundPath) {
      $found = Get-ChildItem -LiteralPath $toolsDir -Recurse -File |
        Where-Object { $_.Name -in @('dab.exe','Microsoft.DataApiBuilder.exe','Azure.DataApiBuilder.Service.exe') } |
        Where-Object { $_.FullName -notmatch '\\\.store\\' } |
        Select-Object -First 1
      if ($found -and (Test-DabLikeExe -Path $found.FullName)) { $foundPath = $found.FullName }
    }

    if (-not $foundPath) { throw 'Nenhum executável válido do DAB foi encontrado após extração.' }

    if ($foundPath -ne $dabExe) {
      Copy-Item -LiteralPath $foundPath -Destination $dabExe -Force
    }
  }
  }
}
Write-Output "Iniciando DAB em http://localhost:$Port (REST em /api)"
Write-Output "Config: $cfg"
Write-Output 'Se alguma entidade falhar, verifique se as views foram criadas no banco.'

$env:ASPNETCORE_URLS = "http://localhost:$Port"
& $dabExe start --config $cfg --no-https-redirect
