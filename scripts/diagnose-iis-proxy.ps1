param(
  [string]$SiteName = 'api.grupoarantes.emp.br',
  [string]$PublicHealthUrl = 'https://api.grupoarantes.emp.br/v1/health',
  [string[]]$BackendHealthUrls = @(
    'http://localhost:5000/api/health',
    'http://127.0.0.1:5000/api/health'
  )
)

$ErrorActionPreference = 'Continue'

function Write-Section([string]$Title) {
  Write-Output ''
  Write-Output ('=' * 80)
  Write-Output $Title
  Write-Output ('=' * 80)
}

function Test-Http([string]$Url) {
  Write-Output "GET $Url"
  try {
    $resp = Invoke-WebRequest -Uri $Url -Method Get -TimeoutSec 15 -UseBasicParsing
    [PSCustomObject]@{ Url = $Url; Ok = $true; StatusCode = [int]$resp.StatusCode }
  } catch {
    $status = $null
    try {
      if ($_.Exception.Response -and $_.Exception.Response.StatusCode) {
        $status = [int]$_.Exception.Response.StatusCode
      }
    } catch { }
    [PSCustomObject]@{ Url = $Url; Ok = $false; StatusCode = $status; Error = $_.Exception.Message }
  }
}

function Get-PortFromUrl([string]$Url) {
  try {
    $u = [Uri]$Url
    if ($u.IsDefaultPort) {
      if ($u.Scheme -eq 'https') { return 443 }
      if ($u.Scheme -eq 'http') { return 80 }
    }
    return [int]$u.Port
  } catch {
    return $null
  }
}

Write-Section 'Public endpoint (IIS)'
Test-Http -Url $PublicHealthUrl | Format-List

Write-Section 'Backend endpoints (expected upstream for ARR/Rewrite)'
foreach ($u in $BackendHealthUrls) {
  $port = Get-PortFromUrl -Url $u
  if ($port) {
    Write-Output "Testing TCP localhost:$port"
    try { Test-NetConnection -ComputerName localhost -Port $port | Select-Object ComputerName,RemotePort,TcpTestSucceeded | Format-List } catch { Write-Output $_.Exception.Message }
  }
  Test-Http -Url $u | Format-List
}

Write-Section 'DAB process check'
try {
  $procs = Get-CimInstance Win32_Process | Where-Object { $_.Name -ieq 'dab.exe' }
  if (-not $procs) {
    Write-Output 'No dab.exe process found.'
  } else {
    $procs | Select-Object ProcessId, Name, CommandLine | Format-List
  }
} catch {
  Write-Output $_.Exception.Message
}

Write-Section 'IIS rewrite rules (if available)'
try {
  Import-Module WebAdministration -ErrorAction Stop
  if (-not (Test-Path "IIS:\\Sites\\$SiteName")) {
    Write-Output "Site not found in IIS:\\Sites: $SiteName"
  } else {
    $rules = Get-WebConfigurationProperty -PSPath "IIS:\\Sites\\$SiteName" -Filter 'system.webServer/rewrite/rules/rule' -Name '.'
    if (-not $rules) {
      Write-Output 'No URL Rewrite rules found.'
    } else {
      foreach ($r in $rules) {
        $name = $r.name
        $matchUrl = $r.match.url
        $actionType = $r.action.type
        $actionUrl = $r.action.url
        Write-Output "Rule: $name"
        Write-Output "  Match: $matchUrl"
        Write-Output "  Action: $actionType -> $actionUrl"
      }
    }
  }
} catch {
  Write-Output 'WebAdministration module not available or access denied.'
  Write-Output $_.Exception.Message
}
