param(
  [string]$ServerInstance,
  [string]$Database,
  [ValidateSet('Windows','Sql')][string]$Auth,
  [string]$Username,
  [string]$Password,
  [string]$ViewsPath = 'sql/views'
)

$ErrorActionPreference = 'Stop'

function Import-DotEnvFile {
  param(
    [Parameter(Mandatory = $true)][string]$Path
  )

  if (-not (Test-Path -LiteralPath $Path)) { return }

  foreach ($line in Get-Content -LiteralPath $Path -ErrorAction Stop) {
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

function Resolve-LocalViewObject {
  param(
    [Parameter(Mandatory = $true)][string]$Path
  )

  $preview = (Get-Content -LiteralPath $Path -TotalCount 8 -ErrorAction Stop) -join "`n"
  $match = [regex]::Match($preview, '(?is)CREATE\s+OR\s+ALTER\s+VIEW\s+(?:(?<schema>\w+)\.)?(?<name>\w+)')

  if (-not $match.Success) {
    $match = [regex]::Match($preview, '(?m)^--\s*(?<schema>\w+)\.(?<name>vw_\w+)')
  }

  $schema = if ($match.Success -and $match.Groups['schema'].Value) { $match.Groups['schema'].Value } else { 'dbo' }
  $name = if ($match.Success -and $match.Groups['name'].Value) { $match.Groups['name'].Value } else { [IO.Path]::GetFileNameWithoutExtension($Path) }

  [pscustomobject]@{
    file_name = [IO.Path]::GetFileName($Path)
    object_name = "$schema.$name"
  }
}

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
Import-DotEnvFile -Path (Join-Path $repoRoot '.env')
Import-DotEnvFile -Path (Join-Path $repoRoot '.env.local')

if (-not $ServerInstance) { $ServerInstance = $env:MSSQL_SERVER }
if (-not $Database) { $Database = $env:MSSQL_DATABASE }
if (-not $Auth) { $Auth = $(if ($env:MSSQL_AUTH) { $env:MSSQL_AUTH } else { 'Windows' }) }
if (-not $Username) { $Username = $env:MSSQL_USERNAME }
if (-not $Password) { $Password = $env:MSSQL_PASSWORD }

if (-not $ServerInstance) {
  throw 'Defina MSSQL_SERVER ou passe -ServerInstance.'
}

if ($ServerInstance -match '^\d{1,3}(?:\.\d{1,3}){3}\\MSSQLSERVER$') {
  $ServerInstance = ($ServerInstance -split '\\', 2)[0]
}

$viewsFullPath = Join-Path $repoRoot $ViewsPath
if (-not (Test-Path -LiteralPath $viewsFullPath)) {
  throw "Pasta de views nao encontrada: $viewsFullPath"
}

$localViewRows = Get-ChildItem -LiteralPath $viewsFullPath -Filter *.sql -File |
  ForEach-Object { Resolve-LocalViewObject -Path $_.FullName }

$localViews = $localViewRows | Group-Object object_name | ForEach-Object {
  [pscustomobject]@{
    object_name = $_.Name
    files = ($_.Group.file_name | Sort-Object)
    duplicate_files = $_.Count -gt 1
  }
} | Sort-Object object_name

$builder = New-Object System.Data.SqlClient.SqlConnectionStringBuilder
$builder['Data Source'] = $ServerInstance
$builder['Initial Catalog'] = $Database
$builder['Encrypt'] = $true
$builder['TrustServerCertificate'] = $true

if ($Auth -eq 'Sql') {
  if (-not $Username) { throw 'Para Auth=Sql, defina MSSQL_USERNAME ou passe -Username.' }
  if (-not $Password) { throw 'Para Auth=Sql, defina MSSQL_PASSWORD ou passe -Password.' }
  $builder['User ID'] = $Username
  $builder['Password'] = $Password
} else {
  $builder['Integrated Security'] = $true
}

$query = @"
SELECT s.name AS schema_name, v.name AS view_name
FROM sys.views v
JOIN sys.schemas s ON s.schema_id = v.schema_id
ORDER BY s.name, v.name;

SELECT COUNT(*) AS total_funcionarios
FROM gold.vw_funcionario;
"@

$dbViews = @()
$totalFuncionarios = $null

$connection = New-Object System.Data.SqlClient.SqlConnection $builder.ConnectionString
$connection.Open()
try {
  $command = $connection.CreateCommand()
  $command.CommandText = $query
  $reader = $command.ExecuteReader()

  while ($reader.Read()) {
    $dbViews += '{0}.{1}' -f $reader.GetString(0), $reader.GetString(1)
  }

  if ($reader.NextResult() -and $reader.Read()) {
    $totalFuncionarios = $reader.GetInt32(0)
  }

  $reader.Close()
} finally {
  $connection.Close()
}

$dbViews = $dbViews | Sort-Object -Unique
$localNames = $localViews.object_name

$both = @($localViews | Where-Object { $dbViews -contains $_.object_name })
$localOnly = @($localViews | Where-Object { $dbViews -notcontains $_.object_name })
$dbOnly = @($dbViews | Where-Object { $localNames -notcontains $_ } | ForEach-Object {
  [pscustomobject]@{ object_name = $_ }
})

[pscustomobject]@{
  generated_at = (Get-Date).ToString('yyyy-MM-dd HH:mm:ss')
  database = $Database
  total_local_views = $localViews.Count
  total_db_views = $dbViews.Count
  total_funcionarios = $totalFuncionarios
  both = $both
  local_only = $localOnly
  db_only = $dbOnly
} | ConvertTo-Json -Depth 6
