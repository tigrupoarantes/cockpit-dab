param(
  [string]$ServerInstance,
  [string]$Database,
  [ValidateSet('Windows','Sql')][string]$Auth,
  [string]$Username,
  [string[]]$ExcludeViewFiles
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
      $existing = $null
      try { $existing = (Get-Item -Path ("Env:$name") -ErrorAction SilentlyContinue).Value } catch { }
      if ([string]::IsNullOrEmpty($value) -and -not [string]::IsNullOrEmpty($existing)) {
        continue
      }
      Set-Item -Path ("Env:$name") -Value $value
    }
  }
}

function Invoke-DbNonQuery {
  param(
    [Parameter(Mandatory = $true)][string]$ConnectionString,
    [Parameter(Mandatory = $true)][string]$Sql
  )

  $conn = $null
  try {
    $conn = [System.Data.SqlClient.SqlConnection]::new($ConnectionString)
    $conn.Open()

    # SqlCommand não entende "GO". Split em batches por linha "GO".
    $batches = @()
    $current = New-Object System.Text.StringBuilder
    foreach ($line in ($Sql -split "`r?`n")) {
      if ($line.Trim().ToUpperInvariant() -eq 'GO') {
        $text = $current.ToString().Trim()
        if ($text) { $batches += $text }
        $null = $current.Clear()
        continue
      }
      $null = $current.AppendLine($line)
    }

    $tail = $current.ToString().Trim()
    if ($tail) { $batches += $tail }

    foreach ($batch in $batches) {
      $cmd = $conn.CreateCommand()
      $cmd.CommandTimeout = 120
      $cmd.CommandText = $batch
      $null = $cmd.ExecuteNonQuery()
    }
  }
  finally {
    if ($conn) { $conn.Dispose() }
  }
}

function Invoke-DbScalar {
  param(
    [Parameter(Mandatory = $true)][string]$ConnectionString,
    [Parameter(Mandatory = $true)][string]$Sql
  )

  $conn = $null
  try {
    $conn = [System.Data.SqlClient.SqlConnection]::new($ConnectionString)
    $conn.Open()
    $cmd = $conn.CreateCommand()
    $cmd.CommandTimeout = 60
    $cmd.CommandText = $Sql
    return $cmd.ExecuteScalar()
  } finally {
    if ($conn) { $conn.Dispose() }
  }
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

$serverForConn = $ServerInstance
$trustText = if ($trust) { 'True' } else { 'False' }
$connectionString = $null
if ($Auth -eq 'Sql') {
  if (-not $Username) { throw 'Para Auth=Sql, defina MSSQL_USERNAME ou passe -Username.' }
  if (-not $env:MSSQL_PASSWORD) {
    $pw = Read-Host 'Senha do SQL (não será exibida)' -AsSecureString
    $env:MSSQL_PASSWORD = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($pw))
  }
  $connectionString = "Server=$serverForConn;Database=$Database;User ID=$Username;Password=$($env:MSSQL_PASSWORD);Encrypt=True;TrustServerCertificate=$trustText;"
} else {
  $connectionString = "Server=$serverForConn;Database=$Database;Integrated Security=True;Encrypt=True;TrustServerCertificate=$trustText;"
}

$viewsDir = Join-Path $repoRoot 'sql/views'
$files = Get-ChildItem -LiteralPath $viewsDir -Filter '*.sql' |
  Where-Object { $_.Name -notmatch '\.original\.sql$' } |
  Sort-Object Name
if (-not $files) { throw "Nenhum arquivo .sql encontrado em $viewsDir" }

# Dependências: vw_empresa_dim é base para outras views (ex.: vw_companies e *_api).
# Aplique ela primeiro para evitar falha por objeto inexistente.
$empresaDim = $files | Where-Object { $_.Name -ieq 'vw_empresa_dim.sql' } | Select-Object -First 1
if ($empresaDim) {
  $files = @($empresaDim) + @($files | Where-Object { $_.FullName -ne $empresaDim.FullName })
}

# As views do projeto são criadas no schema "dbo".
$schemaCheckSql = "SELECT IIF(EXISTS(SELECT 1 FROM sys.schemas WHERE name='dbo'),1,0) AS has_dbo_schema, HAS_PERMS_BY_NAME('dbo','SCHEMA','ALTER') AS can_alter_dbo_schema;"
$schemaHasDbo = [int](Invoke-DbScalar -ConnectionString $connectionString -Sql "SELECT IIF(EXISTS(SELECT 1 FROM sys.schemas WHERE name='dbo'),1,0);")
$schemaCanAlter = [int](Invoke-DbScalar -ConnectionString $connectionString -Sql "SELECT HAS_PERMS_BY_NAME('dbo','SCHEMA','ALTER');")

$schemaCheck = [PSCustomObject]@{ has_dbo_schema = $schemaHasDbo; can_alter_dbo_schema = $schemaCanAlter }
if ($schemaCheck.has_dbo_schema -ne 1 -or $schemaCheck.can_alter_dbo_schema -ne 1) {
  throw ("Você não tem permissão para criar/alterar views no schema 'dbo'.\n" +
         "Peça ao DBA: GRANT ALTER ON SCHEMA::dbo TO [datalake_consulta];")
}

if ($ExcludeViewFiles) {
  $excludeSet = @{}
  foreach ($x in $ExcludeViewFiles) {
    if ($x) { $excludeSet[[string]$x.ToLowerInvariant()] = $true }
  }
  $files = $files | Where-Object { -not $excludeSet.ContainsKey($_.Name.ToLowerInvariant()) }
}

foreach ($f in $files) {
  Write-Output "Aplicando view: $($f.Name)"
  $sql = Get-Content -LiteralPath $f.FullName -Raw
  Invoke-DbNonQuery -ConnectionString $connectionString -Sql $sql
}

Write-Output 'OK: views aplicadas.'
