param(
  [Parameter(Mandatory = $true)]
  [string]$ViewName,

  [Parameter(Mandatory = $true)]
  [string[]]$KeyFields,

  [Parameter(Mandatory = $false)]
  [string]$EntityName,

  [Parameter(Mandatory = $false)]
  [string]$RepoRoot = 'C:\Github\cockpit-dab',

  [Parameter(Mandatory = $false)]
  [string]$ConfigPath = (Join-Path 'C:\Github\cockpit-dab' 'dab\dab-config.json'),

  [Parameter(Mandatory = $false)]
  [switch]$RestartDab,

  [Parameter(Mandatory = $false)]
  [int]$Port = 5000
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Resolve-PathIfRelative {
  param([string]$Root, [string]$Path)
  if (-not $Path) { return $null }
  if ([System.IO.Path]::IsPathRooted($Path)) { return $Path }
  return (Join-Path $Root $Path)
}

$cfgPath = Resolve-PathIfRelative -Root $RepoRoot -Path $ConfigPath
$cfgPath = (Resolve-Path -LiteralPath $cfgPath -ErrorAction Stop).Path

if (-not $EntityName) {
  $EntityName = $ViewName
  if ($EntityName -match '^(dbo\.)') { $EntityName = $EntityName.Substring(4) }
  if ($EntityName -match '^(vw_)') { $EntityName = $EntityName.Substring(3) }
}

# Source object normalization: always store as dbo.<view>
$viewOnly = $ViewName
if ($viewOnly -match '^(dbo\.)') { $viewOnly = $viewOnly.Substring(4) }
$sourceObject = "dbo.$viewOnly"

$cfg = Get-Content -LiteralPath $cfgPath -Raw | ConvertFrom-Json
if (-not $cfg.entities) {
  $cfg | Add-Member -MemberType NoteProperty -Name entities -Value (New-Object PSCustomObject)
}

# Prevent overwrite
$existing = $cfg.entities.PSObject.Properties.Name
if ($existing -contains $EntityName) {
  throw "Entity já existe no config: $EntityName"
}

$entity = [pscustomobject]@{
  source = [pscustomobject]@{
    object = $sourceObject
    type = 'view'
    'key-fields' = @($KeyFields)
  }
  graphql = [pscustomobject]@{
    enabled = $true
    type = [pscustomobject]@{
      singular = $EntityName
      plural = ($EntityName + 's')
    }
  }
  rest = [pscustomobject]@{
    enabled = $true
  }
  permissions = @(
    [pscustomobject]@{
      role = 'anonymous'
      actions = @(
        [pscustomobject]@{ action = 'read' }
      )
    }
  )
}

# Add entity
$cfg.entities | Add-Member -MemberType NoteProperty -Name $EntityName -Value $entity

# Write back
$jsonOut = $cfg | ConvertTo-Json -Depth 30
Set-Content -LiteralPath $cfgPath -Encoding UTF8 -Value $jsonOut

Write-Host "OK: Entity adicionada: $EntityName -> $sourceObject"

if ($RestartDab) {
  $ensure = Resolve-PathIfRelative -Root $RepoRoot -Path 'scripts\ensure-dab-running.ps1'
  & $ensure -RepoRoot $RepoRoot -Port $Port -ConfigPath $cfgPath | Out-Null
  Write-Host "OK: DAB verificado/reiniciado (porta $Port)"
}
