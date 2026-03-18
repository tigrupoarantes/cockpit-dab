# _test_verbas.ps1
# Testa performance do endpoint /api/verbas em 3 cenarios
# Uso: .\scripts\_test_verbas.ps1

$base    = "http://localhost:5000/api"
$entity  = "verbas"
$timeout = 60000

function Invoke-DabRequest {
    param([string]$Url, [string]$Descricao)

    Write-Host ""
    Write-Host "=== $Descricao ==="
    Write-Host "URL: $Url"
    $sw = [System.Diagnostics.Stopwatch]::StartNew()

    try {
        $wr = [System.Net.WebRequest]::Create($Url)
        $wr.Timeout = $timeout
        $resp   = $wr.GetResponse()
        $stream = $resp.GetResponseStream()
        $reader = New-Object System.IO.StreamReader($stream)
        $body   = $reader.ReadToEnd()
        $sw.Stop()

        $json    = $body | ConvertFrom-Json
        $elapsed = [math]::Round($sw.Elapsed.TotalSeconds, 2)

        Write-Host "STATUS   : $($resp.StatusCode.value__) OK"
        Write-Host "Tempo    : $($sw.ElapsedMilliseconds)ms (${elapsed}s)"
        Write-Host "Registros: $($json.value.Count)"
        if ($json.nextLink) { Write-Host "nextLink : SIM" } else { Write-Host "nextLink : NAO" }

        if ($json.value.Count -gt 0) {
            $json.value | Select-Object -First 3 | Format-Table tenant_id, razao_social, ano, tipo_verba -AutoSize
        }

    } catch [System.Net.WebException] {
        $sw.Stop()
        $elapsed = [math]::Round($sw.Elapsed.TotalSeconds, 2)
        $resp2   = $_.Exception.Response
        if ($resp2) {
            $stream2 = $resp2.GetResponseStream()
            $reader2 = New-Object System.IO.StreamReader($stream2)
            $body2   = $reader2.ReadToEnd()
            Write-Host "ERRO $($resp2.StatusCode.value__) apos ${elapsed}s"
            Write-Host $body2
        } else {
            Write-Host "TIMEOUT/SEM RESPOSTA apos ${elapsed}s"
        }
    }
}

# Cenario 1: Full scan sem filtro (baseline)
$url1 = "${base}/${entity}?`$first=10"
Invoke-DabRequest -Url $url1 -Descricao "CENARIO 1: Full scan sem filtro (baseline)"

# Cenario 2: Filtro por ano
$anoAtual = (Get-Date).Year
$filter2  = [uri]::EscapeDataString("ano eq $anoAtual")
$url2     = "${base}/${entity}?`$filter=${filter2}&`$first=100"
Invoke-DabRequest -Url $url2 -Descricao "CENARIO 2: Filtro por ano ($anoAtual) - meta abaixo de 5s"

# Cenario 3: Filtro por ano + tenant_id
$tenantId = "CHOK_DISTRIBUIDORA_DE_ALIMENTOS_LTDA"
$filter3  = [uri]::EscapeDataString("ano eq $anoAtual and tenant_id eq '$tenantId'")
$url3     = "${base}/${entity}?`$filter=${filter3}&`$first=1000"
Invoke-DabRequest -Url $url3 -Descricao "CENARIO 3: Filtro ano + tenant_id ($tenantId) - meta abaixo de 3s"

Write-Host ""
Write-Host "=== RESUMO ==="
Write-Host "Meta pos-otimizacao:"
Write-Host "  Cenario 1 (full scan)  : abaixo de 20s"
Write-Host "  Cenario 2 (filtro ano) : abaixo de 5s"
Write-Host "  Cenario 3 (ano+tenant) : abaixo de 3s"
Write-Host ""
Write-Host "Se ainda lento: executar scripts\_update_stats_verbas.ps1 e testar novamente."
