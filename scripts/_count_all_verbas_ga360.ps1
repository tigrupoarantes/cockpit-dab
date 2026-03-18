# _count_all_verbas_ga360.ps1
# Simula o loop completo de paginação que o GA360 deve fazer
# Conta total de registros e CPFs distintos por ano
# Uso: .\scripts\_count_all_verbas_ga360.ps1 [-Ano 2025]

param(
    [int]$Ano = 2025,
    [int]$PageSize = 5000,
    [string]$Base = "http://localhost:5000"
)

$filter = [uri]::EscapeDataString("ano eq $Ano")
$url = "${Base}/api/verbas-ga360?`$filter=${filter}&`$first=${PageSize}"
$totalRecs = 0
$allCpfs = @{}
$allEmpresas = @{}
$page = 0
$sw = [System.Diagnostics.Stopwatch]::StartNew()

Write-Host "Sync completo: ano=$Ano, pageSize=$PageSize"
Write-Host "URL inicial: $url"
Write-Host ""

while ($url) {
    $page++
    $wr = [System.Net.WebRequest]::Create($url)
    $wr.Timeout = 120000
    $resp = $wr.GetResponse()
    $stream = $resp.GetResponseStream()
    $reader = New-Object System.IO.StreamReader($stream)
    $body = $reader.ReadToEnd()
    $json = $body | ConvertFrom-Json

    $count = $json.value.Count
    $totalRecs += $count
    foreach ($r in $json.value) {
        $allCpfs[$r.cpf] = 1
        $allEmpresas[$r.cnpj_empresa] = $r.razao_social
    }

    $elapsed = [math]::Round($sw.Elapsed.TotalSeconds, 1)
    Write-Host "  Pagina ${page}: ${count} registros | acumulado: ${totalRecs} recs, $($allCpfs.Count) CPFs | ${elapsed}s"

    if ($json.nextLink) {
        $url = "${Base}$($json.nextLink)"
    } else {
        $url = $null
    }
}

$sw.Stop()
Write-Host ""
Write-Host "=== RESULTADO FINAL (ano $Ano) ==="
Write-Host "  Paginas percorridas : $page"
Write-Host "  Total registros     : $totalRecs"
Write-Host "  CPFs distintos      : $($allCpfs.Count)"
Write-Host "  Empresas distintas  : $($allEmpresas.Count)"
Write-Host "  Tempo total         : $([math]::Round($sw.Elapsed.TotalSeconds, 1))s"
Write-Host ""
Write-Host "--- Empresas ---"
foreach ($kv in $allEmpresas.GetEnumerator()) {
    Write-Host "  $($kv.Key) - $($kv.Value)"
}
