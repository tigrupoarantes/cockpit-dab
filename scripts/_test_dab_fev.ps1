$base = "http://localhost:5000/api"
$entity = "venda_diaria_chokdist"
$filter = [uri]::EscapeDataString("data ge 2026-02-01T00:00:00Z and data le 2026-02-28T23:59:59Z")
$select = "data,numero_pedido,sku,descricao_produto,qtde_vendida,preco_unitario_prod,nome_vendedor,municipio,categoria"
$url = "${base}/${entity}?`$filter=${filter}&`$first=100&`$select=${select}"

Write-Host "=== DAB: venda_diaria_chokdist — fev/2026 TOP 100 ==="
Write-Host "URL: $url"
$sw = [System.Diagnostics.Stopwatch]::StartNew()

try {
    $wr = [System.Net.WebRequest]::Create($url)
    $wr.Timeout = 90000
    $resp = $wr.GetResponse()
    $stream = $resp.GetResponseStream()
    $reader = New-Object System.IO.StreamReader($stream)
    $body = $reader.ReadToEnd()
    $sw.Stop()

    $json = $body | ConvertFrom-Json
    $elapsed = [math]::Round($sw.Elapsed.TotalSeconds, 1)
    Write-Host "STATUS: $($resp.StatusCode.value__) OK"
    Write-Host "Tempo: $($sw.ElapsedMilliseconds)ms (${elapsed}s)"
    Write-Host "Registros: $($json.value.Count)"
    if ($json.nextLink) { Write-Host "nextLink: SIM" } else { Write-Host "nextLink: nao" }
    $json.value | Select-Object -First 5 | Format-Table data, numero_pedido, sku, qtde_vendida, nome_vendedor, municipio -AutoSize

} catch [System.Net.WebException] {
    $sw.Stop()
    $elapsed = [math]::Round($sw.Elapsed.TotalSeconds, 1)
    $resp2 = $_.Exception.Response
    if ($resp2) {
        $stream2 = $resp2.GetResponseStream()
        $reader2 = New-Object System.IO.StreamReader($stream2)
        $body2 = $reader2.ReadToEnd()
        Write-Host "ERRO $($resp2.StatusCode.value__) apos ${elapsed}s"
        Write-Host $body2
    } else {
        Write-Host "TIMEOUT/SEM RESPOSTA apos ${elapsed}s"
    }
}
