param(
  [string]$RepoRoot = 'C:\Github\cockpit-dab',
  [string]$IisSiteRoot = 'C:\inetpub\api.grupoarantes.emp.br'
)

$ErrorActionPreference = 'Continue'

function Write-Section([string]$Title) {
  Write-Output ''
  Write-Output ('=' * 80)
  Write-Output $Title
  Write-Output ('=' * 80)
}

function Mask-Value([string]$Name, [string]$Value) {
  if (-not $Value) { return $Value }
  $n = $Name.ToUpperInvariant()
  if ($n -match 'PASSWORD|PWD|CONNECTION_STRING') {
    return '<redacted>'
  }
  return $Value
}

function Show-EnvVar([string]$Name) {
  $p = (Get-Item -Path ("Env:$Name") -ErrorAction SilentlyContinue)
  $val = $null
  if ($p) { $val = [string]$p.Value }
  [PSCustomObject]@{
    Name = $Name
    Value = (Mask-Value -Name $Name -Value $val)
    IsSet = [bool]$val
  }
}

function Find-InDotEnv([string]$Path) {
  if (-not (Test-Path -LiteralPath $Path)) { return @() }
  $keys = @('MSSQL_SERVER','MSSQL_DATABASE','MSSQL_AUTH','MSSQL_USERNAME','MSSQL_PASSWORD','DAB_CONNECTION_STRING')
  $hits = @()
  foreach ($line in (Get-Content -LiteralPath $Path -ErrorAction SilentlyContinue)) {
    $t = $line.Trim()
    if (-not $t) { continue }
    if ($t.StartsWith('#')) { continue }
    foreach ($k in $keys) {
      if ($t -match ('^\s*' + [Regex]::Escape($k) + '\s*=')) {
        $v = $t.Substring($t.IndexOf('=') + 1).Trim().Trim('"').Trim("'")
        $hits += [PSCustomObject]@{ File = $Path; Key = $k; Value = (Mask-Value -Name $k -Value $v) }
      }
    }
  }
  return $hits
}

Write-Section 'Env vars (process)'
@(
  'MSSQL_SERVER','MSSQL_DATABASE','MSSQL_AUTH','MSSQL_USERNAME','MSSQL_PASSWORD','DAB_CONNECTION_STRING'
) | ForEach-Object { Show-EnvVar $_ } | Format-Table -AutoSize

Write-Section 'Env vars (Machine)'
foreach ($n in @('MSSQL_SERVER','MSSQL_DATABASE','MSSQL_AUTH','MSSQL_USERNAME','MSSQL_PASSWORD','DAB_CONNECTION_STRING')) {
  $v = $null
  try { $v = [Environment]::GetEnvironmentVariable($n, 'Machine') } catch { }
  [PSCustomObject]@{ Name = $n; Value = (Mask-Value -Name $n -Value $v); IsSet = [bool]$v } | Format-Table -AutoSize
}

Write-Section 'Dotenv files'
$dotenvPaths = @(
  (Join-Path $RepoRoot '.env'),
  (Join-Path $RepoRoot '.env.local'),
  (Join-Path $IisSiteRoot '.env'),
  (Join-Path $IisSiteRoot '.env.local')
)
foreach ($p in $dotenvPaths) {
  if (Test-Path -LiteralPath $p) {
    Write-Output "Found: $p"
    $hits = Find-InDotEnv -Path $p
    if ($hits.Count -eq 0) {
      Write-Output '  (no MSSQL_/DAB_ keys found)'
    } else {
      $hits | Format-Table -AutoSize
    }
  }
}

Write-Section 'Scheduled tasks mentioning dab'
try {
  $tasks = Get-ScheduledTask -ErrorAction SilentlyContinue
  foreach ($t in $tasks) {
    try {
      $actions = $t.Actions
      foreach ($a in $actions) {
        $cmd = [string]$a.Execute
        $args = [string]$a.Arguments
        $all = ($cmd + ' ' + $args)
        if ($all -match 'dab\.exe|data-api-builder|ensure-dab-running\.ps1|run-local\.ps1') {
          [PSCustomObject]@{ TaskName = $t.TaskName; Path = $t.TaskPath; Command = $cmd; Arguments = $args } | Format-List
        }
      }
    } catch { }
  }
} catch {
  Write-Output $_.Exception.Message
}

Write-Section 'Windows services mentioning dab'
try {
  $svcs = Get-CimInstance Win32_Service | Where-Object { $_.PathName -match 'dab\.exe|data-api-builder' }
  if (-not $svcs) {
    Write-Output 'No services referencing dab.exe found.'
  } else {
    $svcs | Select-Object Name, State, StartMode, PathName | Format-List
  }
} catch {
  Write-Output $_.Exception.Message
}
