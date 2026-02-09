param(
  [int]$Port = 5000
)

$ErrorActionPreference = 'Stop'

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
      Set-Item -Path ("Env:$name") -Value $value
    }
  }
}

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
Import-DotEnvFile -Path (Join-Path $repoRoot '.env')
Import-DotEnvFile -Path (Join-Path $repoRoot '.env.local')

if (-not $env:MSSQL_SERVER) { throw 'MSSQL_SERVER não definido no .env/.env.local' }
if (-not $env:MSSQL_DATABASE) { throw 'MSSQL_DATABASE não definido no .env/.env.local' }
if (-not $env:MSSQL_AUTH) { $env:MSSQL_AUTH = 'Windows' }

$trust = 'True'
if ($env:MSSQL_TRUST_SERVER_CERTIFICATE) { $trust = $env:MSSQL_TRUST_SERVER_CERTIFICATE }

# Normalização: IP\MSSQLSERVER -> IP
$server = $env:MSSQL_SERVER.Trim().Trim('"').Trim("'")
if ($server -match '^\d{1,3}(?:\.\d{1,3}){3}\\MSSQLSERVER$') {
  $server = ($server -split '\\', 2)[0]
}

# Monta uma única connection string para o DAB
if ($env:MSSQL_AUTH -eq 'Sql') {
  if (-not $env:MSSQL_USERNAME) { throw 'MSSQL_USERNAME não definido (Auth=Sql)' }
  if (-not $env:MSSQL_PASSWORD) {
    $pw = Read-Host 'Senha do SQL (não será exibida)' -AsSecureString
    $env:MSSQL_PASSWORD = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($pw))
  }

  $env:DAB_CONNECTION_STRING = "Server=$server;Database=$($env:MSSQL_DATABASE);User ID=$($env:MSSQL_USERNAME);Password=$($env:MSSQL_PASSWORD);Encrypt=True;TrustServerCertificate=$trust;"
} else {
  $env:DAB_CONNECTION_STRING = "Server=$server;Database=$($env:MSSQL_DATABASE);Integrated Security=True;Encrypt=True;TrustServerCertificate=$trust;"
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

    $asset = $null
    if ($manifest.assets) {
      $asset = $manifest.assets |
        Where-Object { $_.name -match 'win-x64' -and $_.name -match 'net8\.0' -and $_.name -match '\\.zip$' } |
        Select-Object -First 1
    }

    if (-not $asset -or -not $asset.url) {
      throw 'Não consegui localizar o asset win-x64 no dab-manifest.json. Verifique acesso à internet/GitHub.'
    }

    $zipPath = Join-Path $toolsDir $asset.name
    Write-Output "Baixando DAB: $($asset.url)"
    Invoke-WebRequest -Uri $asset.url -OutFile $zipPath -UseBasicParsing -ErrorAction Stop

    Write-Output 'Extraindo...'
    Expand-Archive -LiteralPath $zipPath -DestinationPath $toolsDir -Force

    # Procura dab.exe extraído
    $found = Get-ChildItem -LiteralPath $toolsDir -Recurse -Filter 'dab.exe' | Select-Object -First 1
    if (-not $found) {
      throw 'dab.exe não encontrado após extração.'
    }

    if ($found.FullName -ne $dabExe) {
      Copy-Item -LiteralPath $found.FullName -Destination $dabExe -Force
    }
  }
  }
}

$cfg = Join-Path $repoRoot 'dab/dab-config.json'
Write-Output "Iniciando DAB em http://localhost:$Port (REST em /api)"
Write-Output 'Se alguma entidade falhar, verifique se as views foram criadas no banco.'

$env:ASPNETCORE_URLS = "http://localhost:$Port"
& $dabExe start --config $cfg --no-https-redirect
