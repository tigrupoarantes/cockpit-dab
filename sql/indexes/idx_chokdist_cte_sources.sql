-- =============================================================================
-- Índices de performance: tabelas-fonte dos CTEs de vw_venda_diaria_chokdist
-- Contexto: a view usa CTEs com ROW_NUMBER() em tabelas sem índice.
--           Mesmo com índice em bronze.venda_chokdistribuidora(dt_ped), o
--           timeout persiste porque os CTEs fazem full scan de:
--             - acao_nao_venda_chokdistribuidora : 39.8 M linhas
--             - check_in_out_vend_chokdistribuidora : 27.7 M linhas
--             - evento_liberacao_venda_chokdistribuidora : 2.9 M linhas
-- Executor: DBA com permissão de DDL no banco GA_DATALAKE
-- Impacto esperado: query com $filter=data passe de >120s para ~2-5s
-- =============================================================================

USE GA_DATALAKE;
GO

-- -----------------------------------------------------------------------------
-- 1) acao_nao_venda — 39.8M linhas
--
--    CTE usa: ROW_NUMBER() OVER (PARTITION BY cd_clien, cd_vend ORDER BY data DESC)
--    Índice permite que SQL Server leia uma linha por partição em ordem (índice seek),
--    eliminando 99%+ do trabalho de ordenação.
-- -----------------------------------------------------------------------------
IF NOT EXISTS (
    SELECT 1 FROM sys.indexes i
    JOIN sys.tables t ON t.object_id = i.object_id
    JOIN sys.schemas s ON s.schema_id = t.schema_id
    WHERE s.name = 'bronze'
      AND t.name = 'acao_nao_venda_chokdistribuidora'
      AND i.name = 'IX_acao_nao_venda_chokdist_clien_vend_data'
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_acao_nao_venda_chokdist_clien_vend_data
        ON bronze.acao_nao_venda_chokdistribuidora (cd_clien, cd_vend, data DESC)
        INCLUDE (desc_motivo, cd_motivo)
        WITH (FILLFACTOR = 85, ONLINE = ON);

    PRINT 'Índice IX_acao_nao_venda_chokdist_clien_vend_data criado.';
END
ELSE
    PRINT 'Índice IX_acao_nao_venda_chokdist_clien_vend_data já existe.';
GO

-- -----------------------------------------------------------------------------
-- 2) check_in_out — 27.7M linhas
--
--    CTE usa: ROW_NUMBER() OVER (PARTITION BY CodigoVendedor, CodigoCliente ORDER BY Data DESC)
--    Índice com Data DESC permite seek diretamente na última entrada por par vend/cliente.
-- -----------------------------------------------------------------------------
IF NOT EXISTS (
    SELECT 1 FROM sys.indexes i
    JOIN sys.tables t ON t.object_id = i.object_id
    JOIN sys.schemas s ON s.schema_id = t.schema_id
    WHERE s.name = 'bronze'
      AND t.name = 'check_in_out_vend_chokdistribuidora'
      AND i.name = 'IX_checkinout_chokdist_vend_cli_data'
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_checkinout_chokdist_vend_cli_data
        ON bronze.check_in_out_vend_chokdistribuidora (CodigoVendedor, CodigoCliente, Data DESC)
        INCLUDE (HoraInicio, HoraFim)
        WITH (FILLFACTOR = 85, ONLINE = ON);

    PRINT 'Índice IX_checkinout_chokdist_vend_cli_data criado.';
END
ELSE
    PRINT 'Índice IX_checkinout_chokdist_vend_cli_data já existe.';
GO

-- -----------------------------------------------------------------------------
-- 3) evento_liberacao — 2.9M linhas
--
--    CTE usa: GROUP BY nu_ped, cd_clien + MAX(dt_encer) por cd_fila
-- -----------------------------------------------------------------------------
IF NOT EXISTS (
    SELECT 1 FROM sys.indexes i
    JOIN sys.tables t ON t.object_id = i.object_id
    JOIN sys.schemas s ON s.schema_id = t.schema_id
    WHERE s.name = 'bronze'
      AND t.name = 'evento_liberacao_venda_chokdistribuidora'
      AND i.name = 'IX_evento_lib_chokdist_nuped_clien_fila'
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_evento_lib_chokdist_nuped_clien_fila
        ON bronze.evento_liberacao_venda_chokdistribuidora (nu_ped, cd_clien, cd_fila)
        INCLUDE (dt_encer)
        WITH (FILLFACTOR = 85, ONLINE = ON);

    PRINT 'Índice IX_evento_lib_chokdist_nuped_clien_fila criado.';
END
ELSE
    PRINT 'Índice IX_evento_lib_chokdist_nuped_clien_fila já existe.';
GO

-- -----------------------------------------------------------------------------
-- 4) nota_fiscal — 357K linhas (menor, mas JOIN frequente)
-- -----------------------------------------------------------------------------
IF NOT EXISTS (
    SELECT 1 FROM sys.indexes i
    JOIN sys.tables t ON t.object_id = i.object_id
    JOIN sys.schemas s ON s.schema_id = t.schema_id
    WHERE s.name = 'bronze'
      AND t.name = 'nota_fiscal_chokdistribuidora'
      AND i.name = 'IX_nf_chokdist_nuped'
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_nf_chokdist_nuped
        ON bronze.nota_fiscal_chokdistribuidora (nu_ped)
        INCLUDE (nu_nf_emp_fat)
        WITH (FILLFACTOR = 85, ONLINE = ON);

    PRINT 'Índice IX_nf_chokdist_nuped criado.';
END
ELSE
    PRINT 'Índice IX_nf_chokdist_nuped já existe.';
GO

-- -----------------------------------------------------------------------------
-- 5) Verificação pós-criação
-- -----------------------------------------------------------------------------
SELECT
    s.name AS schema_name,
    t.name AS tabela,
    i.name AS indice,
    (
        SELECT STRING_AGG(c2.name, ', ') WITHIN GROUP (ORDER BY ic2.key_ordinal)
        FROM sys.index_columns ic2
        JOIN sys.columns c2 ON c2.object_id = ic2.object_id AND c2.column_id = ic2.column_id
        WHERE ic2.object_id = i.object_id AND ic2.index_id = i.index_id
          AND ic2.is_included_column = 0
    ) AS key_cols
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
ORDER BY t.name, i.name;
GO

-- =============================================================================
-- OBSERVAÇÃO IMPORTANTE SOBRE O ÍNDICE EM acao_nao_venda (39.8M):
--
--   Criação estimada: 10-30 minutos (tabela grande, ONLINE = ON)
--   Durante a criação o sistema continua disponível (ONLINE = ON)
--   Monitorar com:
--     SELECT * FROM sys.dm_exec_requests WHERE command = 'CREATE INDEX'
--
-- OBSERVAÇÃO SOBRE O ÍNDICE EM check_in_out (27.7M):
--
--   Criação estimada: 8-20 minutos (ONLINE = ON)
-- =============================================================================
