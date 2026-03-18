-- =============================================================================
-- idx_verbas_long_performance.sql
-- Índices de performance para o endpoint /api/verbas-ga360 (vw_verbas_long_api)
--
-- Cadeia: dbo.vw_verbas_long_api
--           → gold.vw_pagamento_verba_sankhya
--             → silver.fact_pagamento_verba_sankhya
--           → silver.dim_empresa         (JOIN para cnpj)
--           → silver.dim_funcionario     (JOIN para cpf)
--
-- Complementa idx_verbas_performance.sql (fact + dim_calendario + dim_func por empresa)
-- Executar com permissão ALTER TABLE nas tabelas silver.*
-- =============================================================================

-- 1. dim_funcionario: lookup por cod_funcionario + sk_empresa (JOIN da view LONG)
IF NOT EXISTS (
    SELECT 1 FROM sys.indexes
    WHERE name = 'idx_dim_funcionario_cod'
      AND object_id = OBJECT_ID('silver.dim_funcionario')
)
BEGIN
    CREATE INDEX idx_dim_funcionario_cod
        ON silver.dim_funcionario (cod_funcionario, sk_empresa)
        INCLUDE (cpf, nome_funcionario);
    PRINT 'Índice idx_dim_funcionario_cod criado com sucesso.';
END
ELSE
    PRINT 'Índice idx_dim_funcionario_cod já existe — ignorado.';
GO

-- 2. dim_empresa: lookup por cod_empresa (JOIN para CNPJ)
IF NOT EXISTS (
    SELECT 1 FROM sys.indexes
    WHERE name = 'idx_dim_empresa_cod'
      AND object_id = OBJECT_ID('silver.dim_empresa')
)
BEGIN
    CREATE INDEX idx_dim_empresa_cod
        ON silver.dim_empresa (cod_empresa)
        INCLUDE (sk_empresa, cnpj, razao_social);
    PRINT 'Índice idx_dim_empresa_cod criado com sucesso.';
END
ELSE
    PRINT 'Índice idx_dim_empresa_cod já existe — ignorado.';
GO

PRINT '=== idx_verbas_long_performance.sql concluído ===';
GO
