# _update_stats_verbas.ps1
# Atualiza estatísticas das tabelas-fonte do endpoint /api/verbas
# Resolve lentidão causada por planos de execução desatualizados (mesmo padrão do chokdist)
#
# Executar após carga de dados no datalake ou quando verbas estiver lento.

$conn = New-Object System.Data.SqlClient.SqlConnection
$conn.ConnectionString = "Server=192.168.1.10;Database=GA_DATALAKE;User Id=datalake_consulta;Password=Chok@2026;TrustServerCertificate=True"
$conn.Open()

$tables = @(
    "silver.fact_pagamento_verba_sankhya",
    "silver.dim_calendario",
    "silver.dim_funcionario",
    "silver.dim_evento",
    "silver.dim_empresa"
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

Write-Host ""
Write-Host "Limpando cache de planos de execução..."
$cmd = $conn.CreateCommand()
$cmd.CommandText = "DBCC FREEPROCCACHE"
$cmd.CommandTimeout = 60
try {
    $cmd.ExecuteNonQuery() | Out-Null
    Write-Host "  DBCC FREEPROCCACHE OK"
} catch {
    Write-Host "  ERRO no FREEPROCCACHE: $_"
}

$conn.Close()
Write-Host ""
Write-Host "Estatísticas verbas atualizadas. SQL Server deve escolher plano correto agora."
Write-Host "Próximo passo: testar com scripts\_test_verbas.ps1"
