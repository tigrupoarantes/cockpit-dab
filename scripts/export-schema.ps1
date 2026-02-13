param(
  [string]$ServerInstance,
  [string]$Database,
  [ValidateSet('Windows','Sql')][string]$Auth,
  [string]$Username
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
      $existing = $null
      try { $existing = (Get-Item -Path ("Env:$name") -ErrorAction SilentlyContinue).Value } catch { }
      if ([string]::IsNullOrEmpty($value) -and -not [string]::IsNullOrEmpty($existing)) {
        continue
      }
      Set-Item -Path ("Env:$name") -Value $value
    }
  }
}

if (-not (Get-Command Invoke-Sqlcmd -ErrorAction SilentlyContinue)) {
  throw 'Invoke-Sqlcmd não encontrado. Instale o módulo SqlServer: Install-Module SqlServer -Scope CurrentUser'
}

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
Import-DotEnvFile -Path (Join-Path $repoRoot '.env')
Import-DotEnvFile -Path (Join-Path $repoRoot '.env.local')

if (-not $ServerInstance) { $ServerInstance = $env:MSSQL_SERVER }
if (-not $Database) { $Database = $env:MSSQL_DATABASE }
if (-not $Auth) { $Auth = $(if ($env:MSSQL_AUTH) { $env:MSSQL_AUTH } else { 'Windows' }) }
if (-not $Username) { $Username = $env:MSSQL_USERNAME }

if (-not $ServerInstance) { throw 'Defina MSSQL_SERVER no .env/.env.local ou passe -ServerInstance.' }
if (-not $Database) { throw 'Defina MSSQL_DATABASE no .env/.env.local (ex.: GA_DATALAKE) ou passe -Database.' }

$ServerInstance = $ServerInstance.Trim()

# Caso comum: IP + instância default (MSSQLSERVER). Em muitos ambientes, usar "IP\MSSQLSERVER" falha.
# Para instância default, prefira só o host/IP (ou tcp:IP,1433).
if ($ServerInstance -match '^\d{1,3}(?:\.\d{1,3}){3}\\MSSQLSERVER$') {
  $ServerInstance = ($ServerInstance -split '\\', 2)[0]
}

$trust = $true
if ($env:MSSQL_TRUST_SERVER_CERTIFICATE) {
  $trust = @('1','true','yes','y','sim') -contains $env:MSSQL_TRUST_SERVER_CERTIFICATE.ToLowerInvariant()
}

$invokeParams = @{ ServerInstance = $ServerInstance; Database = $Database; ErrorAction = 'Stop' }
if ($trust) { $invokeParams.TrustServerCertificate = $true }

if ($Auth -eq 'Sql') {
  if (-not $Username) { throw 'Para Auth=Sql, defina MSSQL_USERNAME ou passe -Username.' }

  $securePassword = $null
  if ($env:MSSQL_PASSWORD) {
    $securePassword = ConvertTo-SecureString $env:MSSQL_PASSWORD -AsPlainText -Force
  } else {
    $securePassword = Read-Host 'Senha do SQL (não será exibida)' -AsSecureString
  }

  $invokeParams.Credential = [PSCredential]::new($Username, $securePassword)
}

$columnsSqlPath = Join-Path $repoRoot 'sql/meta/columns.sql'
$fksSqlPath = Join-Path $repoRoot 'sql/meta/fks.sql'

$columnsQuery = Get-Content -LiteralPath $columnsSqlPath -Raw
$fksQuery = Get-Content -LiteralPath $fksSqlPath -Raw

$docsDir = Join-Path $repoRoot 'docs'
$columnsOut = Join-Path $docsDir 'schema_columns.csv'
$fksOut = Join-Path $docsDir 'schema_fks.csv'

Write-Output "Exportando colunas de $Database..."
$columns = Invoke-Sqlcmd @invokeParams -Query $columnsQuery
$columns | Export-Csv -LiteralPath $columnsOut -NoTypeInformation -Encoding UTF8
Write-Output "OK: $columnsOut"

Write-Output "Exportando FKs de $Database..."
$fks = Invoke-Sqlcmd @invokeParams -Query $fksQuery
$fks | Export-Csv -LiteralPath $fksOut -NoTypeInformation -Encoding UTF8
Write-Output "OK: $fksOut"
