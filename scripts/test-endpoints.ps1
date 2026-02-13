param(
  [string]$BaseUrl = 'http://localhost:5000',
  [string]$DataVenda
)

$ErrorActionPreference = 'Stop'

if (-not $DataVenda) {
  $DataVenda = (Get-Date).AddDays(-1).ToString('yyyy-MM-dd')
}

$vendaProdUrl = ($BaseUrl + "/api/venda_prod?`$first=10")

$endpoints = @(
  "$BaseUrl/api/health",
  "$BaseUrl/api/produtos",
  "$BaseUrl/api/sales_daily",
  "$BaseUrl/api/sales_by_sku",
  "$BaseUrl/api/coverage_city",
  "$BaseUrl/api/stock_position",
  $vendaProdUrl
)

foreach ($url in $endpoints) {
  Write-Output "GET $url"
  try {
    $resp = Invoke-RestMethod -Method Get -Uri $url -TimeoutSec 15
    $json = $resp | ConvertTo-Json -Depth 6
    $json
  } catch {
    Write-Output "FALHOU: $($_.Exception.Message)"
  }

  Write-Output '---'
}
