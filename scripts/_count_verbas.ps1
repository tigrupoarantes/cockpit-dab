$url = "http://localhost:5000/api/verbas?`$filter=ano%20eq%202026&`$first=100000"
$r = Invoke-WebRequest -Uri $url -UseBasicParsing -TimeoutSec 60
$j = $r.Content | ConvertFrom-Json
$total = $j.value.Count
$cpfsDistintos = ($j.value | Where-Object { $_.cpf } | Select-Object -ExpandProperty cpf | Sort-Object -Unique).Count
$semCpf = ($j.value | Where-Object { -not $_.cpf }).Count
Write-Host "Total registros  : $total"
Write-Host "CPFs distintos   : $cpfsDistintos"
Write-Host "Sem CPF (nulo)   : $semCpf"
