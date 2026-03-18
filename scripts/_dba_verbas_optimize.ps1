# _dba_verbas_optimize.ps1
# Aplica índices + atualiza estatísticas das tabelas-fonte de verbas
# Requer conta com permissão ALTER TABLE nos schemas silver.* e DBCC FREEPROCCACHE
#
# Uso:
#   .\scripts\_dba_verbas_optimize.ps1
#   .\scripts\_dba_verbas_optimize.ps1 -SaPassword "minhasenha"

param(
    [string]$Server   = "192.168.1.10",
    [string]$Database = "GA_DATALAKE",
    [string]$Username = "sa",
    [string]$SaPassword = ""
)

if (-not $SaPassword) {
    $secPwd    = Read-Host "Senha do usuário '$Username'" -AsSecureString
    $SaPassword = [Runtime.InteropServices.Marshal]::PtrToStringAuto(
                    [Runtime.InteropServices.Marshal]::SecureStringToBSTR($secPwd))
}

$connStr = "Server=$Server;Database=$Database;User Id=$Username;Password=$SaPassword;TrustServerCertificate=True;Connection Timeout=30"

function Invoke-Sql {
    param([string]$Label, [string]$Sql, [int]$TimeoutSec = 300)

    Write-Host "$Label ..."
    $sw = [System.Diagnostics.Stopwatch]::StartNew()
    $conn = New-Object System.Data.SqlClient.SqlConnection($connStr)
    try {
        $conn.Open()
        $cmd = $conn.CreateCommand()
        $cmd.CommandText    = $Sql
        $cmd.CommandTimeout = $TimeoutSec
        $cmd.ExecuteNonQuery() | Out-Null
        $sw.Stop()
        Write-Host "  OK em $($sw.ElapsedMilliseconds)ms" -ForegroundColor Green
    } catch {
        $sw.Stop()
        Write-Host "  ERRO após $($sw.ElapsedMilliseconds)ms: $_" -ForegroundColor Red
    } finally {
        $conn.Close()
    }
}

Write-Host ""
Write-Host "=== FASE 1: Criando índices na camada silver ===" -ForegroundColor Cyan

Invoke-Sql "idx_fact_verba_empresa_cal" @"
IF NOT EXISTS (
    SELECT 1 FROM sys.indexes
    WHERE name = 'idx_fact_verba_empresa_cal'
      AND object_id = OBJECT_ID('silver.fact_pagamento_verba_sankhya')
)
    CREATE INDEX idx_fact_verba_empresa_cal
        ON silver.fact_pagamento_verba_sankhya (sk_empresa, sk_calendario)
        INCLUDE (sk_funcionario, sk_evento, valor);
"@

Invoke-Sql "idx_dim_calendario_ano_mes" @"
IF NOT EXISTS (
    SELECT 1 FROM sys.indexes
    WHERE name = 'idx_dim_calendario_ano_mes'
      AND object_id = OBJECT_ID('silver.dim_calendario')
)
    CREATE INDEX idx_dim_calendario_ano_mes
        ON silver.dim_calendario (ano, mes)
        INCLUDE (sk_calendario, nome_mes);
"@

Invoke-Sql "idx_dim_funcionario_empresa" @"
IF NOT EXISTS (
    SELECT 1 FROM sys.indexes
    WHERE name = 'idx_dim_funcionario_empresa'
      AND object_id = OBJECT_ID('silver.dim_funcionario')
)
    CREATE INDEX idx_dim_funcionario_empresa
        ON silver.dim_funcionario (sk_empresa)
        INCLUDE (sk_funcionario, nome_funcionario, cpf);
"@

Write-Host ""
Write-Host "=== FASE 2: Atualizando estatísticas ===" -ForegroundColor Cyan

foreach ($tbl in @(
    "silver.fact_pagamento_verba_sankhya",
    "silver.dim_calendario",
    "silver.dim_funcionario",
    "silver.dim_evento",
    "silver.dim_empresa"
)) {
    Invoke-Sql "UPDATE STATISTICS $tbl" "UPDATE STATISTICS $tbl WITH FULLSCAN"
}

Write-Host ""
Write-Host "=== FASE 3: Limpando cache de planos ===" -ForegroundColor Cyan
Invoke-Sql "DBCC FREEPROCCACHE" "DBCC FREEPROCCACHE"

Write-Host ""
Write-Host "=== Concluído. Próximo passo: .\scripts\_test_verbas.ps1 ===" -ForegroundColor Cyan
