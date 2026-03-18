$conn = New-Object System.Data.SqlClient.SqlConnection
$conn.ConnectionString = "Server=192.168.1.10;Database=GA_DATALAKE;User Id=datalake_consulta;Password=Chok@2026;TrustServerCertificate=True"
$conn.Open()

# Verifica se a view lite existe
$cmd0 = $conn.CreateCommand()
$cmd0.CommandText = "SELECT OBJECT_ID('gold.vw_venda_diaria_chokdist_lite')"
$cmd0.CommandTimeout = 5
$exists = $cmd0.ExecuteScalar()
if ($exists -eq [System.DBNull]::Value -or $null -eq $exists) {
    Write-Host "View gold.vw_venda_diaria_chokdist_lite NAO existe ainda. DBA precisa criá-la."
    $conn.Close()
    exit
}

Write-Host "View lite existe. Testando performance..."
$sw = [System.Diagnostics.Stopwatch]::StartNew()
$cmd = $conn.CreateCommand()
$cmd.CommandText = "SELECT TOP 100 data, numero_pedido, sku, descricao_produto, qtde_vendida, preco_unitario_prod, nome_vendedor, municipio, categoria FROM gold.vw_venda_diaria_chokdist_lite WHERE data >= CAST('2026-02-01' AS date) AND data <= CAST('2026-02-28' AS date) ORDER BY data, numero_pedido"
$cmd.CommandTimeout = 60
try {
    $r = $cmd.ExecuteReader()
    $count = 0
    while ($r.Read()) { $count++ }
    $r.Close()
    $sw.Stop()
    $secs = [math]::Round($sw.Elapsed.TotalSeconds, 1)
    Write-Host "SUCESSO - $count registros em $($sw.ElapsedMilliseconds)ms (${secs}s)"
} catch {
    $sw.Stop()
    $secs = [math]::Round($sw.Elapsed.TotalSeconds, 1)
    Write-Host "ERRO apos ${secs}s: $_"
}
$conn.Close()
