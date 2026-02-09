param(
  [string]$ServerInstance,
  [string]$Database,
  [ValidateSet('Windows','Sql')][string]$Auth,
  [string]$Username
)

$ErrorActionPreference = 'Stop'

# Reutiliza o mesmo padrão de env do resto do repo
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
if (-not $Database) { throw 'Defina MSSQL_DATABASE no .env/.env.local ou passe -Database.' }

$ServerInstance = $ServerInstance.Trim()
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

$viewsDir = Join-Path $repoRoot 'sql/views'
$files = Get-ChildItem -LiteralPath $viewsDir -Filter '*.sql' | Sort-Object Name
if (-not $files) { throw "Nenhum arquivo .sql encontrado em $viewsDir" }

# As views do projeto são criadas no schema "dbo".
$schemaCheck = Invoke-Sqlcmd @invokeParams -Query "SELECT IIF(EXISTS(SELECT 1 FROM sys.schemas WHERE name='dbo'),1,0) AS has_dbo_schema, HAS_PERMS_BY_NAME('dbo','SCHEMA','ALTER') AS can_alter_dbo_schema;"
if ($schemaCheck.has_dbo_schema -ne 1 -or $schemaCheck.can_alter_dbo_schema -ne 1) {
  throw ("Você não tem permissão para criar/alterar views no schema 'dbo'.\n" +
         "Peça ao DBA: GRANT ALTER ON SCHEMA::dbo TO [datalake_consulta];")
}

foreach ($f in $files) {
  Write-Output "Aplicando view: $($f.Name)"
  $sql = Get-Content -LiteralPath $f.FullName -Raw
  Invoke-Sqlcmd @invokeParams -Query $sql | Out-Null
}

Write-Output 'OK: views aplicadas.'
