# _test_verbas_ga360.ps1
# Testa performance e contrato do endpoint /api/verbas-ga360 (formato LONG)
# Valida campos obrigatorios do PRD GA360 e formato nextLink
# Uso: .\scripts\_test_verbas_ga360.ps1

$base    = "http://localhost:5000/api"
$entity  = "verbas-ga360"
$timeout = 60000

# Campos obrigatorios do PRD secao 5
$camposObrigatorios = @("cpf", "nome_funcionario", "cnpj_empresa", "ano", "mes", "cod_evento", "valor", "tipo_verba", "competencia", "id_verba_long", "tenant_id", "razao_social")

function Invoke-DabRequest {
    param(
        [string]$Url,
        [string]$Descricao,
        [switch]$ValidarCampos,
        [switch]$ValidarNextLink
    )

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

        # Validar nextLink
        if ($json.nextLink) {
            Write-Host "nextLink : SIM"
            if ($ValidarNextLink) {
                if ($json.nextLink -match "^https?://") {
                    Write-Host "  [OK] nextLink e ABSOLUTO: $($json.nextLink.Substring(0, [math]::Min(80, $json.nextLink.Length)))..."
                } else {
                    Write-Host "  [FALHA] nextLink e RELATIVO (P3 nao resolvido): $($json.nextLink.Substring(0, [math]::Min(80, $json.nextLink.Length)))..."
                }
            }
        } else {
            Write-Host "nextLink : NAO"
        }

        # Validar campos obrigatorios
        if ($ValidarCampos -and $json.value.Count -gt 0) {
            $primeiro = $json.value[0]
            $props = $primeiro.PSObject.Properties.Name
            Write-Host ""
            Write-Host "--- Validacao de campos (PRD secao 5) ---"
            $ok = 0; $falha = 0
            foreach ($campo in $camposObrigatorios) {
                if ($campo -in $props) {
                    Write-Host "  [OK]    $campo"
                    $ok++
                } else {
                    Write-Host "  [FALHA] $campo - AUSENTE"
                    $falha++
                }
            }
            Write-Host "Resultado: $ok/$($camposObrigatorios.Count) campos presentes"
            if ($falha -gt 0) {
                Write-Host "  ** ATENCAO: $falha campo(s) obrigatorio(s) ausente(s) **"
            }
        }

        # Mostrar amostra
        if ($json.value.Count -gt 0) {
            Write-Host ""
            Write-Host "--- Amostra (3 primeiros registros) ---"
            $json.value | Select-Object -First 3 | Format-Table cpf, nome_funcionario, cnpj_empresa, ano, mes, cod_evento, tipo_verba, valor -AutoSize
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

Write-Host "=========================================="
Write-Host " TEST VERBAS-GA360 (formato LONG)"
Write-Host "=========================================="

# Cenario 1: Filtro por ano (padrao GA360) + validacao de campos
$anoAtual = (Get-Date).Year
$filter1  = [uri]::EscapeDataString("ano eq $anoAtual")
$url1     = "${base}/${entity}?`$filter=${filter1}&`$first=10"
Invoke-DabRequest -Url $url1 -Descricao "CENARIO 1: Filtro por ano ($anoAtual) + validacao de campos - meta < 5s" -ValidarCampos -ValidarNextLink

# Cenario 2: Filtro por ano + mes (sync parcial GA360)
$mesAtual = (Get-Date).Month
$filter2  = [uri]::EscapeDataString("ano eq $anoAtual and mes eq $mesAtual")
$url2     = "${base}/${entity}?`$filter=${filter2}&`$first=5000"
Invoke-DabRequest -Url $url2 -Descricao "CENARIO 2: Filtro ano + mes ($anoAtual-$mesAtual) - meta < 3s" -ValidarNextLink

# Cenario 3: Sync completo de ano (padrao GA360 com $first=5000)
$filter3  = [uri]::EscapeDataString("ano eq $anoAtual")
$url3     = "${base}/${entity}?`$filter=${filter3}&`$first=5000"
Invoke-DabRequest -Url $url3 -Descricao "CENARIO 3: Sync ano completo ($anoAtual) $first=5000 - meta < 15s" -ValidarNextLink

# Cenario 4: Filtro por ano + tenant_id (multi-tenant)
$tenantId = "CHOK_DISTRIBUIDORA_DE_ALIMENTOS_LTDA"
$filter4  = [uri]::EscapeDataString("ano eq $anoAtual and tenant_id eq '$tenantId'")
$url4     = "${base}/${entity}?`$filter=${filter4}&`$first=5000"
Invoke-DabRequest -Url $url4 -Descricao "CENARIO 4: Filtro ano + tenant_id ($tenantId) - meta < 5s"

Write-Host ""
Write-Host "=========================================="
Write-Host " RESUMO DE METAS"
Write-Host "=========================================="
Write-Host "  Cenario 1 (ano + campos)     : < 5s"
Write-Host "  Cenario 2 (ano + mes)        : < 3s"
Write-Host "  Cenario 3 (ano completo)     : < 15s"
Write-Host "  Cenario 4 (ano + tenant_id)  : < 5s"
Write-Host ""
Write-Host "Se lento: executar scripts\_dba_verbas_long_optimize.ps1 e testar novamente."
Write-Host "Endpoint antigo (PIVOT): testar com scripts\_test_verbas.ps1"
