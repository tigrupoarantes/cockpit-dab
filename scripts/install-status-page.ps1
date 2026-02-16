param(
  [Parameter(Mandatory = $false)]
  [string]$RepoRoot = 'C:\Github\cockpit-dab',

  [Parameter(Mandatory = $false)]
  [string[]]$IisStatusDirs = @(
    'C:\inetpub\api.grupoarantes.emp.br\status',
    'C:\inetpub\wwwroot\status'
  )
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$src = Join-Path $RepoRoot 'iis\status\index.html'
if (-not (Test-Path -LiteralPath $src)) {
  throw "Arquivo não encontrado: $src"
}

foreach ($dir in $IisStatusDirs) {
  if (-not (Test-Path -LiteralPath $dir)) {
    New-Item -ItemType Directory -Force -Path $dir | Out-Null
  }

  Copy-Item -LiteralPath $src -Destination (Join-Path $dir 'index.html') -Force

  # Create placeholder status.json if it doesn't exist
  $statusPath = Join-Path $dir 'status.json'
  if (-not (Test-Path -LiteralPath $statusPath)) {
    $init = @{ timestamp = (Get-Date).ToString('s'); ensure = @{ ok = $false; error = 'Aguardando watchdog...' } }
    ($init | ConvertTo-Json -Depth 5) | Set-Content -LiteralPath $statusPath -Encoding UTF8
  }

  Write-Host "OK: Painel instalado em $dir\index.html"
}