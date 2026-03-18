-- =============================================================================
-- idx_verbas_performance.sql
-- Índices de performance para o endpoint /api/verbas (vw_verbas_api)
--
-- Cadeia: dbo.vw_verbas_api
--           → gold.vw_pagamento_verba_pivot_mensal
--             → gold.vw_pagamento_verba_sankhya
--               → silver.fact_pagamento_verba_sankhya  ← aqui estão os gargalos
--
-- Executar com permissão ALTER TABLE nas tabelas silver.*
-- Recomendado: executar em horário de baixo tráfego (cada índice pode demorar 1-5 min)
-- =============================================================================

-- 1. Fact table: índice coberto para os JOINs do pivot mensal
--    (sk_empresa + sk_calendario são as colunas mais filtradas no pivot GROUP BY)
IF NOT EXISTS (
    SELECT 1 FROM sys.indexes
    WHERE name = 'idx_fact_verba_empresa_cal'
      AND object_id = OBJECT_ID('silver.fact_pagamento_verba_sankhya')
)
BEGIN
    CREATE INDEX idx_fact_verba_empresa_cal
        ON silver.fact_pagamento_verba_sankhya (sk_empresa, sk_calendario)
        INCLUDE (sk_funcionario, sk_evento, valor);
    PRINT 'Índice idx_fact_verba_empresa_cal criado com sucesso.';
END
ELSE
    PRINT 'Índice idx_fact_verba_empresa_cal já existe — ignorado.';
GO

-- 2. dim_calendario: índice por ano/mês para pushdown do filtro $filter=ano eq 2025
--    OData → WHERE ano = 2025 será resolvido via este índice ao invés de full scan
IF NOT EXISTS (
    SELECT 1 FROM sys.indexes
    WHERE name = 'idx_dim_calendario_ano_mes'
      AND object_id = OBJECT_ID('silver.dim_calendario')
)
BEGIN
    CREATE INDEX idx_dim_calendario_ano_mes
        ON silver.dim_calendario (ano, mes)
        INCLUDE (sk_calendario, nome_mes);
    PRINT 'Índice idx_dim_calendario_ano_mes criado com sucesso.';
END
ELSE
    PRINT 'Índice idx_dim_calendario_ano_mes já existe — ignorado.';
GO

-- 3. dim_funcionario: índice por empresa para lookup em JOINs da view
IF NOT EXISTS (
    SELECT 1 FROM sys.indexes
    WHERE name = 'idx_dim_funcionario_empresa'
      AND object_id = OBJECT_ID('silver.dim_funcionario')
)
BEGIN
    CREATE INDEX idx_dim_funcionario_empresa
        ON silver.dim_funcionario (sk_empresa)
        INCLUDE (sk_funcionario, nome_funcionario, cpf);
    PRINT 'Índice idx_dim_funcionario_empresa criado com sucesso.';
END
ELSE
    PRINT 'Índice idx_dim_funcionario_empresa já existe — ignorado.';
GO

PRINT '=== idx_verbas_performance.sql concluído ===';
GO
