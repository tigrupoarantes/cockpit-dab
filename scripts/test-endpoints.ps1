param(
  [string]$BaseUrl = 'http://localhost:5000/api',
  [string]$ApiKey,
  [int]$First = 10,
  [string]$DataVenda
)

$ErrorActionPreference = 'Stop'

if (-not $DataVenda) {
  $DataVenda = (Get-Date).AddDays(-1).ToString('yyyy-MM-dd')
}

$base = $BaseUrl.TrimEnd('/')

$headers = @{ 'Accept' = 'application/json' }
if ($ApiKey) {
  $headers['X-API-Key'] = $ApiKey
}

$vendaProdUrl = ($base + "/venda_prod?`$first=$First")

$endpoints = @(
  "$base/health",
  "$base/companies",
  "$base/funcionarios?`$first=$First",
  "$base/produtos",
  "$base/sales_daily",
  "$base/sales_by_sku",
  "$base/coverage_city",
  "$base/stock_position",
  "$base/sales_product_detail?`$first=$First",
  $vendaProdUrl
)

foreach ($url in $endpoints) {
  Write-Output "GET $url"
  try {
    $resp = Invoke-RestMethod -Method Get -Uri $url -TimeoutSec 15 -Headers $headers
    $json = $resp | ConvertTo-Json -Depth 6
    $json
  } catch {
    Write-Output "FALHOU: $($_.Exception.Message)"
  }

  Write-Output '---'
}
