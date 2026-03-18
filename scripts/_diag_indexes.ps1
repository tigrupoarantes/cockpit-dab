$conn = New-Object System.Data.SqlClient.SqlConnection
$conn.ConnectionString = "Server=192.168.1.10;Database=GA_DATALAKE;User Id=datalake_consulta;Password=Chok@2026;TrustServerCertificate=True"
$conn.Open()

# 1) Verificar indices nas tabelas dos CTEs
$cmd = $conn.CreateCommand()
$cmd.CommandText = "
SELECT t.name AS tabela, i.name AS indice, i.type_desc
FROM sys.indexes i
JOIN sys.tables t ON t.object_id = i.object_id
JOIN sys.schemas s ON s.schema_id = t.schema_id
WHERE s.name = 'bronze'
  AND t.name IN (
    'acao_nao_venda_chokdistribuidora',
    'check_in_out_vend_chokdistribuidora',
    'evento_liberacao_venda_chokdistribuidora',
    'nota_fiscal_chokdistribuidora'
  )
  AND i.type > 0
ORDER BY t.name, i.name"
$cmd.CommandTimeout = 10
Write-Host "=== Indices nas tabelas CTE ==="
$r = $cmd.ExecuteReader()
$found = $false
while ($r.Read()) {
    Write-Host "$($r['tabela']) | $($r['indice'])"
    $found = $true
}
if (-not $found) { Write-Host "NENHUM indice encontrado - indices ainda nao foram criados!" }
$r.Close()

# 2) Testar cada CTE isolado com timeout curto para identificar gargalo
$ctes = @{
    "evento_lib (2.9M, GROUP BY)" = "SELECT COUNT(*) FROM (SELECT nu_ped, cd_clien, MAX(CASE WHEN cd_fila='SEPA' THEN dt_encer END) AS s, MAX(CASE WHEN cd_fila='ENTR' THEN dt_encer END) AS e FROM bronze.evento_liberacao_venda_chokdistribuidora WHERE cd_fila IN ('SEPA','ENTR') GROUP BY nu_ped, cd_clien) x"
    "nf (357K, GROUP BY)"        = "SELECT COUNT(*) FROM (SELECT nu_ped, MAX(nu_nf_emp_fat) AS nf FROM bronze.nota_fiscal_chokdistribuidora GROUP BY nu_ped) x"
    "acao_nv (39.8M, ROW_NUMBER)" = "SELECT COUNT(*) FROM (SELECT cd_clien, cd_vend, ROW_NUMBER() OVER (PARTITION BY cd_clien, cd_vend ORDER BY data DESC) AS rn FROM bronze.acao_nao_venda_chokdistribuidora) x WHERE rn = 1"
    "checkin (27.7M, ROW_NUMBER)" = "SELECT COUNT(*) FROM (SELECT CodigoVendedor, CodigoCliente, ROW_NUMBER() OVER (PARTITION BY CodigoVendedor, CodigoCliente ORDER BY Data DESC) AS rn FROM bronze.check_in_out_vend_chokdistribuidora) x WHERE rn = 1"
}

Write-Host "`n=== Tempo de cada CTE isolado (timeout 60s cada) ==="
foreach ($label in $ctes.Keys) {
    $sw = [System.Diagnostics.Stopwatch]::StartNew()
    $cmd2 = $conn.CreateCommand()
    $cmd2.CommandText = $ctes[$label]
    $cmd2.CommandTimeout = 60
    try {
        $count = $cmd2.ExecuteScalar()
        $sw.Stop()
        Write-Host "OK  $label : $count linhas em $($sw.ElapsedMilliseconds)ms"
    } catch {
        $sw.Stop()
        Write-Host "TIMEOUT $label : $($sw.ElapsedMilliseconds)ms"
    }
}

$conn.Close()
