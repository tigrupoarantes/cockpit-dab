param(
  [Parameter(Mandatory = $false)]
  [string]$RepoRoot = 'C:\Github\cockpit-dab',

  [Parameter(Mandatory = $false)]
  [string]$TaskName = 'Cockpit-DAB-Watchdog',

  [Parameter(Mandatory = $false)]
  [int]$Port = 5000,

  [Parameter(Mandatory = $false)]
  [string]$ConfigPath = (Join-Path 'C:\Github\cockpit-dab' 'dab\dab-config.json'),

  [Parameter(Mandatory = $false)]
  [string[]]$StatusDirs = @(
    'C:\inetpub\api.grupoarantes.emp.br\status',
    'C:\inetpub\wwwroot\status'
  )
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$watchdog = Join-Path $RepoRoot 'scripts\dab-watchdog.ps1'
if (-not (Test-Path -LiteralPath $watchdog)) {
  throw "Script watchdog não encontrado: $watchdog"
}

foreach ($dir in $StatusDirs) {
  if (-not (Test-Path -LiteralPath $dir)) {
    New-Item -ItemType Directory -Force -Path $dir | Out-Null
  }
}

$pwsh = (Get-Command powershell.exe).Source

$taskLog = Join-Path $RepoRoot 'logs\dab-watchdog-task.log'

$statusDirsList = ($StatusDirs | ForEach-Object { "'" + ($_.Replace("'","''")) + "'" }) -join ','
$command = "& '$watchdog' -RepoRoot '$RepoRoot' -Port $Port -ConfigPath '$ConfigPath' -StatusDirs @($statusDirsList) -Loop -IntervalSec 30 *>> '$taskLog'"

$arg = "-NoProfile -ExecutionPolicy Bypass -Command `"$command`""

$action = New-ScheduledTaskAction -Execute $pwsh -Argument $arg

# Triggers: at startup + repeat every minute forever
$startupTrigger = New-ScheduledTaskTrigger -AtStartup

# Repetition on startup trigger isn't supported in all PS versions; add a second trigger at logon as a fallback.
$logonTrigger = New-ScheduledTaskTrigger -AtLogOn

$principal = New-ScheduledTaskPrincipal -UserId 'NT AUTHORITY\SYSTEM' -LogonType ServiceAccount -RunLevel Highest

$settings = New-ScheduledTaskSettingsSet `
  -AllowStartIfOnBatteries `
  -DontStopIfGoingOnBatteries `
  -StartWhenAvailable `
  -MultipleInstances IgnoreNew `
  -ExecutionTimeLimit ([TimeSpan]::Zero) `
  -RestartCount 999 `
  -RestartInterval (New-TimeSpan -Minutes 1)

# Create/replace
try {
  Unregister-ScheduledTask -TaskName $TaskName -Confirm:$false -ErrorAction SilentlyContinue | Out-Null
} catch { }

Register-ScheduledTask -TaskName $TaskName -Action $action -Trigger @($startupTrigger, $logonTrigger) -Settings $settings -Principal $principal | Out-Null

Start-ScheduledTask -TaskName $TaskName

Write-Host "OK: Task instalada/iniciada: $TaskName"