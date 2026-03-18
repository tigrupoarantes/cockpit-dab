$conn = New-Object System.Data.SqlClient.SqlConnection
$conn.ConnectionString = "Server=192.168.1.10;Database=GA_DATALAKE;User Id=datalake_consulta;Password=Chok@2026;TrustServerCertificate=True"
$conn.Open()

$tables = @(
    "bronze.acao_nao_venda_chokdistribuidora",
    "bronze.check_in_out_vend_chokdistribuidora",
    "bronze.venda_chokdistribuidora",
    "bronze.pedido_venda_chokdistribuidora"
)

foreach ($tbl in $tables) {
    Write-Host "UPDATE STATISTICS $tbl ..."
    $sw = [System.Diagnostics.Stopwatch]::StartNew()
    $cmd = $conn.CreateCommand()
    $cmd.CommandText = "UPDATE STATISTICS $tbl WITH FULLSCAN"
    $cmd.CommandTimeout = 300
    try {
        $cmd.ExecuteNonQuery() | Out-Null
        $sw.Stop()
        Write-Host "  OK em $($sw.ElapsedMilliseconds)ms"
    } catch {
        $sw.Stop()
        Write-Host "  ERRO: $_"
    }
}

$conn.Close()
Write-Host "`nEstatisticas atualizadas. SQL Server deve escolher plano correto agora."
