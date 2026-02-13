param(
  [string]$ServerInstance,
  [string]$Database,
  [ValidateSet('Windows','Sql')][string]$Auth,
  [string]$Username,
  [string]$Query = 'SELECT @@SERVERNAME AS ServerName, DB_NAME() AS DbName, SUSER_SNAME() AS LoginName',
  [switch]$ListDatabases,
  [switch]$ListSchemas,
  [switch]$ListTables,
  [string]$Schema,
  [int]$Top = 200
)

$ErrorActionPreference = 'Stop'

function Import-DotEnvFile {
  param(
    [Parameter(Mandatory = $true)][string]$Path
  )

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

# Carrega variáveis do .env/.env.local automaticamente (se existirem)
$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
Import-DotEnvFile -Path (Join-Path $repoRoot '.env')
Import-DotEnvFile -Path (Join-Path $repoRoot '.env.local')

# Defaults (após carregar .env)
if (-not $ServerInstance) { $ServerInstance = $env:MSSQL_SERVER }
if (-not $Database) { $Database = $env:MSSQL_DATABASE }
if (-not $Auth) { $Auth = $(if ($env:MSSQL_AUTH) { $env:MSSQL_AUTH } else { 'Windows' }) }
if (-not $Username) { $Username = $env:MSSQL_USERNAME }

if (-not (Get-Command Invoke-Sqlcmd -ErrorAction SilentlyContinue)) {
  throw 'Invoke-Sqlcmd não encontrado. Instale o módulo SqlServer: Install-Module SqlServer -Scope CurrentUser'
}

$trust = $true
if ($env:MSSQL_TRUST_SERVER_CERTIFICATE) {
  $trust = @('1','true','yes','y','sim') -contains $env:MSSQL_TRUST_SERVER_CERTIFICATE.ToLowerInvariant()
}

if (-not $ServerInstance) {
  throw 'Defina MSSQL_SERVER (ex: "SERVER\\INSTANCIA" ou "localhost") ou passe -ServerInstance.'
}

$ServerInstance = $ServerInstance.Trim()

# Caso comum: IP + instância default (MSSQLSERVER). Em muitos ambientes, usar "IP\MSSQLSERVER" falha.
# Para instância default, prefira só o host/IP (ou tcp:IP,1433).
if ($ServerInstance -match '^\d{1,3}(?:\.\d{1,3}){3}\\MSSQLSERVER$') {
  $ServerInstance = ($ServerInstance -split '\\', 2)[0]
}

$invokeParams = @{ ServerInstance = $ServerInstance; ErrorAction = 'Stop' }
if ($trust) { $invokeParams.TrustServerCertificate = $true }
if ($Database) { $invokeParams.Database = $Database }

if ($Auth -eq 'Sql') {
  if (-not $Username) { throw 'Para Auth=Sql, defina MSSQL_USERNAME ou passe -Username.' }

  $securePassword = $null
  $passwordCameFromEnv = $false
  if ($env:MSSQL_PASSWORD) {
    $securePassword = ConvertTo-SecureString $env:MSSQL_PASSWORD -AsPlainText -Force
    $passwordCameFromEnv = $true
  } else {
    $securePassword = Read-Host 'Senha do SQL (não será exibida)' -AsSecureString
  }

  $credential = [PSCredential]::new($Username, $securePassword)
  $invokeParams.Credential = $credential
}

if ($ListDatabases) {
  Invoke-Sqlcmd @invokeParams -Query 'SELECT name FROM sys.databases ORDER BY name' | Format-Table -AutoSize
  exit 0
}

if ($ListSchemas) {
  Invoke-Sqlcmd @invokeParams -Query 'SELECT name FROM sys.schemas ORDER BY name' | Format-Table -AutoSize
  exit 0
}

if ($ListTables) {
  $topN = if ($Top -gt 0) { $Top } else { 200 }
  $schemaFilter = ''
  if ($Schema) {
    $escaped = $Schema.Replace("'", "''")
    $schemaFilter = "WHERE s.name = '$escaped'"
  }

  $q = @"
SELECT TOP ($topN)
  s.name AS [schema],
  t.name AS [table]
FROM sys.tables t
JOIN sys.schemas s ON s.schema_id = t.schema_id
$schemaFilter
ORDER BY s.name, t.name;
"@

  Invoke-Sqlcmd @invokeParams -Query $q | Format-Table -AutoSize
  exit 0
}

try {
  Invoke-Sqlcmd @invokeParams -Query $Query | Format-Table -AutoSize
} catch {
  $sqlErrorSummary = $null
  $sqlFirstErrorState = $null
  if ($_.Exception -and $_.Exception.GetType().FullName -eq 'Microsoft.Data.SqlClient.SqlException') {
    $first = $_.Exception.Errors | Select-Object -First 1
    if ($first) {
      $sqlFirstErrorState = $first.State
    }
    $sqlErrorSummary = ($_.Exception.Errors | Select-Object Number, State, Class, Message | Format-Table -AutoSize | Out-String).Trim()
  }

  if ($sqlErrorSummary) {
    Write-Output 'Detalhes do erro SQL (Number/State):'
    Write-Output $sqlErrorSummary
  }

  if ($Auth -eq 'Sql' -and $_.Exception.Message -match "Login failed for user" -and $sqlFirstErrorState -eq 38) {
    Write-Output 'Login falhou por database padrão inacessível (State 38). Tentando conectar usando database master...'
    $invokeParams.Database = 'master'
    Invoke-Sqlcmd @invokeParams -Query $Query | Format-Table -AutoSize
    exit 0
  }

  if ($Auth -eq 'Sql' -and $_.Exception.Message -match "Login failed for user" -and $passwordCameFromEnv) {
    Write-Output 'Login falhou com a senha do .env. Digite a senha novamente para testar (não será exibida).'
    $retryPassword = Read-Host 'Senha do SQL (retry)' -AsSecureString
    $invokeParams.Credential = [PSCredential]::new($Username, $retryPassword)
    Invoke-Sqlcmd @invokeParams -Query $Query | Format-Table -AutoSize
    exit 0
  }

  if ($_.Exception.Message -match 'Connection string is not valid') {
    $diag = @(
      'Falha: string de conexão inválida.',
      ("ServerInstance=" + $ServerInstance),
      ("Database=" + $(if ($Database) { $Database } else { '<default>' })),
      ("Auth=" + $Auth),
      ("Username=" + $(if ($Username) { $Username } else { '<n/a>' })),
      ("Dica: se a instância for default (MSSQLSERVER) e você está usando IP, use só o IP (ex: 192.168.1.10) ou tcp:192.168.1.10,1433.")
    ) -join "`n"
    throw $diag
  }
  throw
}
