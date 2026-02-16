param(
  [int]$Port = 5000,
  [string]$RepoRoot,
  [string]$ConfigPath,
  [string]$DabExePath,
  [string]$ConnectionString,
  [string]$LogPath,

  # Opcional: montar DAB_CONNECTION_STRING a partir de parametros MSSQL_*
  [string]$MssqlServer,
  [string]$MssqlDatabase,
  [ValidateSet('Windows','Sql')][string]$Auth = 'Windows',
  [string]$Username,
  [string]$Password,
  [string]$TrustServerCertificate = 'True'
)

$ErrorActionPreference = 'Stop'

function Write-Info([string]$Message) { Write-Output "[INFO] $Message" }
function Write-Warn([string]$Message) { Write-Output "[WARN] $Message" }

function Get-RepoRoot {
  param([string]$ExplicitRepoRoot)

  if ($ExplicitRepoRoot) {
    return (Resolve-Path -LiteralPath $ExplicitRepoRoot -ErrorAction Stop).Path
  }

  # Preferencia: pasta do script (quando executado via -File)
  if ($PSScriptRoot) {
    try {
      return (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
    } catch { }
  }

  # Fallback: diretório atual (útil quando o usuário copiou/colou trechos no console)
  return (Get-Location).Path
}

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
      if ([string]::IsNullOrEmpty($value) -and -not [string]::IsNullOrEmpty($existing)) { continue }
      Set-Item -Path ("Env:$name") -Value $value
    }
  }
}

function New-DbConnectionString {
  param(
    [Parameter(Mandatory = $true)][string]$Server,
    [Parameter(Mandatory = $true)][string]$Database,
    [ValidateSet('Windows','Sql')][string]$Auth = 'Windows',
    [string]$Username,
    [string]$Password,
    [string]$TrustServerCertificate = 'True'
  )

  $base = "Server=$Server;Database=$Database;Encrypt=True;TrustServerCertificate=$TrustServerCertificate;"
  if ($Auth -eq 'Sql') {
    if (-not $Username) { throw 'Username obrigatorio para Auth=Sql.' }
    if (-not $Password) { throw 'Password obrigatorio para Auth=Sql.' }
    return $base + "User ID=$Username;Password=$Password;"
  }
  return $base + 'Integrated Security=True;'
}

function Test-TcpPort {
  param([int]$Port)
  try {
    $r = Test-NetConnection -ComputerName localhost -Port $Port -WarningAction SilentlyContinue
    return [bool]$r.TcpTestSucceeded
  } catch {
    return $false
  }
}

function Find-DabExe {
  param([string]$RepoRoot, [string]$DabExePath)

  function Test-DabExe([string]$Path) {
    if (-not $Path -or -not (Test-Path -LiteralPath $Path)) { return $false }
    try {
      & $Path --version *> $null
      return ($LASTEXITCODE -eq 0)
    } catch {
      return $false
    }
  }

  if ($DabExePath) {
    $p = $DabExePath
    if (-not [System.IO.Path]::IsPathRooted($p)) {
      $p = Join-Path $RepoRoot $p
    }
    $resolved = (Resolve-Path -LiteralPath $p -ErrorAction Stop).Path
    if (-not (Test-Path -LiteralPath $resolved)) { throw "dab.exe não encontrado: $resolved" }
    if (-not (Test-DabExe -Path $resolved)) {
      Write-Warn "dab.exe inválido em DabExePath (falhou ao executar --version): $resolved. Vou tentar localizar outro dab.exe."
    } else {
      return $resolved
    }
  }

  $candidates = @(
    (Join-Path $RepoRoot 'tools\\dab\\dab.exe'),
    (Join-Path $env:USERPROFILE '.dotnet\\tools\\dab.exe')
  )

  foreach ($c in $candidates) {
    if ($c -and (Test-Path -LiteralPath $c) -and (Test-DabExe -Path $c)) { return $c }
  }

  $cmd = Get-Command dab -ErrorAction SilentlyContinue
  if ($cmd -and $cmd.Source -and (Test-DabExe -Path $cmd.Source)) { return $cmd.Source }

  return $null
}

function Ensure-DabDownloaded {
  param([string]$RepoRoot)

  $toolsDir = Join-Path $RepoRoot 'tools\\dab'
  $dabExe = Join-Path $toolsDir 'dab.exe'
  if (Test-Path -LiteralPath $dabExe) {
    try {
      & $dabExe --version *> $null
      if ($LASTEXITCODE -eq 0) { return $dabExe }
    } catch { }

    try { Remove-Item -LiteralPath $dabExe -Force -ErrorAction SilentlyContinue } catch { }
  }

  New-Item -ItemType Directory -Force -Path $toolsDir | Out-Null

  $manifestUrl = 'https://github.com/Azure/data-api-builder/releases/latest/download/dab-manifest.json'
  Write-Info "Baixando DAB (manifest): $manifestUrl"

  $manifest = Invoke-RestMethod -Uri $manifestUrl -Method Get -TimeoutSec 30 -ErrorAction Stop

  if (-not $manifest) {
    throw 'Manifest do DAB vazio.'
  }

  $assetUrl = $null
  $assetName = $null

  # Formato atual (2026): array com objetos contendo files.win-x64.url
  $entry = $manifest
  if ($manifest -is [System.Array]) {
    $entry = $manifest | Where-Object { $_.version -eq 'latest' } | Select-Object -First 1
    if (-not $entry) { $entry = $manifest | Select-Object -First 1 }
  }

  if ($entry -and ($entry.PSObject.Properties.Name -contains 'files') -and $entry.files) {
    try {
      $win = $entry.files.'win-x64'
      if ($win -and $win.url) {
        $assetUrl = [string]$win.url
        $assetName = [System.IO.Path]::GetFileName($assetUrl)
      }
    } catch { }
  }

  # Compat: formato antigo (assets: [{name,url},...])
  if (-not $assetUrl -and $entry -and ($entry.PSObject.Properties.Name -contains 'assets') -and $entry.assets) {
    $asset = $entry.assets |
      Where-Object { $_.name -match 'win-x64' -and $_.name -match 'net8\\.0' -and $_.name -match '\\.(zip)$' } |
      Select-Object -First 1
    if ($asset -and $asset.url) {
      $assetUrl = [string]$asset.url
      $assetName = [string]$asset.name
    }
  }

  if (-not $assetUrl -or -not $assetName) {
    throw 'Não consegui localizar o asset win-x64 no dab-manifest.json.'
  }

  $zipPath = Join-Path $toolsDir $assetName
  Write-Info "Baixando DAB: $assetUrl"

  $iwrParams = @{ Uri = $assetUrl; OutFile = $zipPath; ErrorAction = 'Stop' }
  if ((Get-Command Invoke-WebRequest).Parameters.ContainsKey('UseBasicParsing')) {
    $iwrParams.UseBasicParsing = $true
  }
  if ((Get-Command Invoke-WebRequest).Parameters.ContainsKey('TimeoutSec')) {
    $iwrParams.TimeoutSec = 120
  }
  Invoke-WebRequest @iwrParams

  Write-Info 'Extraindo...'
  Expand-Archive -LiteralPath $zipPath -DestinationPath $toolsDir -Force

  function Test-DabLikeExe([string]$Path) {
    if (-not $Path -or -not (Test-Path -LiteralPath $Path)) { return $false }
    try {
      & $Path --version *> $null
      return ($LASTEXITCODE -eq 0)
    } catch {
      return $false
    }
  }

  # Pacote net8.0_win-x64 hoje costuma extrair Microsoft.DataApiBuilder.exe (não dab.exe).
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
    if ($found -and (Test-DabLikeExe -Path $found.FullName)) {
      $foundPath = $found.FullName
    }
  }

  if (-not $foundPath) { throw 'Nenhum executável válido do DAB foi encontrado após extração.' }

  if ($foundPath -ne $dabExe) {
    Copy-Item -LiteralPath $foundPath -Destination $dabExe -Force
  }

  return $dabExe
}

function Resolve-ConfigPath {
  param([string]$RepoRoot, [string]$ConfigPath)

  if ($ConfigPath) {
    $p = $ConfigPath
    if (-not [System.IO.Path]::IsPathRooted($p)) { $p = Join-Path $RepoRoot $p }
    return (Resolve-Path -LiteralPath $p -ErrorAction Stop).Path
  }

  $default = Join-Path $RepoRoot 'dab\\dab-config.json'
  if (Test-Path -LiteralPath $default) { return (Resolve-Path -LiteralPath $default).Path }

  throw 'ConfigPath não informado e dab\\dab-config.json não encontrado.'
}

function Get-ConnStr {
  param([string]$ConnectionString)

  if ($ConnectionString) { return $ConnectionString }
  if ($env:DAB_CONNECTION_STRING) { return $env:DAB_CONNECTION_STRING }

  # tenta pegar de variável de máquina (comum em servidores)
  try {
    $machine = [Environment]::GetEnvironmentVariable('DAB_CONNECTION_STRING', 'Machine')
    if ($machine) { return $machine }
  } catch { }

  return $null
}

$repoRoot = Get-RepoRoot -ExplicitRepoRoot $RepoRoot

# Carrega variáveis do .env/.env.local, se existirem (útil para rodar em server)
try {
  Import-DotEnvFile -Path (Join-Path $repoRoot '.env')
  Import-DotEnvFile -Path (Join-Path $repoRoot '.env.local')
} catch { }

# Se não veio por parâmetro, tenta pegar MSSQL_* do ambiente
if (-not $MssqlServer) { $MssqlServer = $env:MSSQL_SERVER }
if (-not $MssqlDatabase) { $MssqlDatabase = $env:MSSQL_DATABASE }
if (-not $Username) { $Username = $env:MSSQL_USERNAME }
if (-not $Password) { $Password = $env:MSSQL_PASSWORD }
if ($env:MSSQL_AUTH -and -not $PSBoundParameters.ContainsKey('Auth')) { $Auth = $env:MSSQL_AUTH }
if ($env:MSSQL_TRUST_SERVER_CERTIFICATE -and -not $PSBoundParameters.ContainsKey('TrustServerCertificate')) { $TrustServerCertificate = $env:MSSQL_TRUST_SERVER_CERTIFICATE }

# Normalizacao: IP\MSSQLSERVER -> IP (instancia default)
if ($MssqlServer) {
  $serverTrim = $MssqlServer.Trim().Trim('"').Trim("'")
  if ($serverTrim -match '^\d{1,3}(?:\.\d{1,3}){3}\\MSSQLSERVER$') {
    $serverTrim = ($serverTrim -split '\\', 2)[0]
  }
  $MssqlServer = $serverTrim
}
$cfg = Resolve-ConfigPath -RepoRoot $repoRoot -ConfigPath $ConfigPath

$cs = Get-ConnStr -ConnectionString $ConnectionString
if (-not $cs) {
  if ($MssqlServer -and $MssqlDatabase) {
    if ($Auth -eq 'Sql' -and -not $Password) {
      $pw = Read-Host 'Senha do SQL (não será exibida)' -AsSecureString
      $Password = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($pw))
    }
    $cs = New-DbConnectionString -Server $MssqlServer -Database $MssqlDatabase -Auth $Auth -Username $Username -Password $Password -TrustServerCertificate $TrustServerCertificate
    Write-Info 'DAB_CONNECTION_STRING montado a partir de MSSQL_SERVER/MSSQL_DATABASE.'
  } else {
    throw 'DAB_CONNECTION_STRING não definido. Defina a variável de ambiente DAB_CONNECTION_STRING (de máquina) ou passe -ConnectionString, ou informe -MssqlServer e -MssqlDatabase.'
  }
}

$dabExe = Find-DabExe -RepoRoot $repoRoot -DabExePath $DabExePath
if (-not $dabExe) {
  Write-Warn 'dab.exe não encontrado; vou tentar baixar para tools\\dab\\dab.exe (requer internet).'
  $dabExe = Ensure-DabDownloaded -RepoRoot $repoRoot
}

if (-not $LogPath) {
  $logsDir = Join-Path $repoRoot 'logs'
  if (-not (Test-Path -LiteralPath $logsDir)) { New-Item -ItemType Directory -Force -Path $logsDir | Out-Null }
  $LogPath = Join-Path $logsDir 'dab-runtime.log'
}

Write-Info "Config: $cfg"
Write-Info "DAB exe: $dabExe"
Write-Info "Porta esperada (IIS upstream): $Port"
Write-Info "Log: $LogPath"

if (Test-TcpPort -Port $Port) {
  Write-Info "Já existe algo ouvindo em localhost:$Port. Vou só testar /api/health."
} else {
  Write-Info "Iniciando DAB em http://localhost:$Port (REST em /api)"

  $env:ASPNETCORE_URLS = "http://localhost:$Port"
  $env:DAB_CONNECTION_STRING = $cs

  # Inicia em background com log
  $args = @('start','--config', $cfg, '--no-https-redirect')

  # PowerShell exige arquivos diferentes para stdout/stderr
  $stdoutPath = $LogPath
  $stderrPath = $null
  if ($stdoutPath -match '\.log$') {
    $stderrPath = ($stdoutPath -replace '\.log$', '.err.log')
  } else {
    $stderrPath = ($stdoutPath + '.err')
  }

  Start-Process -FilePath $dabExe -ArgumentList $args -NoNewWindow -RedirectStandardOutput $stdoutPath -RedirectStandardError $stderrPath | Out-Null

  Start-Sleep -Seconds 2

  if (-not (Test-TcpPort -Port $Port)) {
    throw "DAB não subiu na porta $Port. Veja logs: $stdoutPath e $stderrPath"
  }
}

# Teste do backend direto
$healthUrl = "http://localhost:$Port/api/health"
Write-Info "Testando backend: $healthUrl"
try {
  $resp = Invoke-WebRequest -Uri $healthUrl -TimeoutSec 15 -UseBasicParsing
  Write-Info "Backend OK (HTTP $([int]$resp.StatusCode))"
} catch {
  Write-Warn 'Backend não respondeu ao /api/health.'
  Write-Warn ("Veja o log do DAB (stdout): " + $LogPath)
  Write-Warn ("Veja o log do DAB (stderr): " + $(if ($LogPath -match '\.log$') { ($LogPath -replace '\.log$', '.err.log') } else { ($LogPath + '.err') }))
  throw
}

Write-Info 'Próximo passo: testar via IIS público em /v1/health (com X-API-Key).' 
