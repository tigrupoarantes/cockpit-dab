# _dba_verbas_long_optimize.ps1
# Aplica índices adicionais para o endpoint verbas-ga360 (formato LONG)
# + atualiza estatísticas + limpa cache de planos
#
# COMPLEMENTAR a _dba_verbas_optimize.ps1 (que cria índices do endpoint PIVOT)
# Executar AMBOS os scripts para performance ótima.
#
# Uso:
#   .\scripts\_dba_verbas_long_optimize.ps1
#   .\scripts\_dba_verbas_long_optimize.ps1 -SaPassword "minhasenha"

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
Write-Host "=== FASE 1: Criando índices para view LONG (verbas-ga360) ===" -ForegroundColor Cyan

Invoke-Sql "idx_dim_funcionario_cod (cod_funcionario + sk_empresa → cpf)" @"
IF NOT EXISTS (
    SELECT 1 FROM sys.indexes
    WHERE name = 'idx_dim_funcionario_cod'
      AND object_id = OBJECT_ID('silver.dim_funcionario')
)
    CREATE INDEX idx_dim_funcionario_cod
        ON silver.dim_funcionario (cod_funcionario, sk_empresa)
        INCLUDE (cpf, nome_funcionario);
"@

Invoke-Sql "idx_dim_empresa_cod (cod_empresa → cnpj)" @"
IF NOT EXISTS (
    SELECT 1 FROM sys.indexes
    WHERE name = 'idx_dim_empresa_cod'
      AND object_id = OBJECT_ID('silver.dim_empresa')
)
    CREATE INDEX idx_dim_empresa_cod
        ON silver.dim_empresa (cod_empresa)
        INCLUDE (sk_empresa, cnpj, razao_social);
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
Write-Host "=== Concluído ===" -ForegroundColor Cyan
Write-Host "Próximo passo: .\scripts\_test_verbas_ga360.ps1"
Write-Host "Para índices do endpoint PIVOT (legado): .\scripts\_dba_verbas_optimize.ps1"
