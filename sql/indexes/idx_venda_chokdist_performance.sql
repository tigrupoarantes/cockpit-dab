-- =============================================================================
-- Índices de performance: bronze.venda_chokdistribuidora
-- Contexto: view gold.vw_venda_diaria_chokdist causa full-table scan (>30s)
--           quando consultada pelo DAB sem filtro de data.
--           343.632 linhas, ZERO índices nas tabelas base.
-- Executor: DBA com permissão de DDL no banco GA_DATALAKE
-- Impacto esperado: query com $filter=data eq 'YYYY-MM-DD' cai de >30s para <2s
-- =============================================================================

USE GA_DATALAKE;
GO

-- -----------------------------------------------------------------------------
-- 1) Índice principal: data do pedido (coluna de filtro obrigatório no DAB)
--
--    A view faz: silver.dim_calendario cal ON cal.data = venda.dt_ped
--    O OData $filter=data eq '2026-03-13' filtra cal.data, que retorna via dt_ped.
--    Este índice elimina o full-table scan em TODAS as queries com filtro de data.
-- -----------------------------------------------------------------------------
IF NOT EXISTS (
    SELECT 1 FROM sys.indexes i
    JOIN sys.tables t ON t.object_id = i.object_id
    JOIN sys.schemas s ON s.schema_id = t.schema_id
    WHERE s.name = 'bronze'
      AND t.name = 'venda_chokdistribuidora'
      AND i.name = 'IX_venda_chokdist_dt_ped'
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_venda_chokdist_dt_ped
        ON bronze.venda_chokdistribuidora (dt_ped)
        INCLUDE (nu_ped, cd_emp, cd_vend, cd_clien, cd_tabela, origem_pedido, tp_ped, prz_medio, dt_cad)
        WITH (FILLFACTOR = 85, ONLINE = ON);

    PRINT 'Índice IX_venda_chokdist_dt_ped criado com sucesso.';
END
ELSE
    PRINT 'Índice IX_venda_chokdist_dt_ped já existe — nenhuma ação necessária.';
GO

-- -----------------------------------------------------------------------------
-- 2) Índice de suporte ao JOIN com pedido_venda_chokdistribuidora
--
--    A view faz: INNER JOIN bronze.pedido_venda_chokdistribuidora pedido
--                ON pedido.nu_ped = venda.nu_ped AND pedido.cd_emp = venda.cd_emp
--    Se a tabela de pedidos também não tem índice em nu_ped, o nested loop
--    ainda será lento. Este índice cobre o lado "pedido" do JOIN.
-- -----------------------------------------------------------------------------
IF NOT EXISTS (
    SELECT 1 FROM sys.indexes i
    JOIN sys.tables t ON t.object_id = i.object_id
    JOIN sys.schemas s ON s.schema_id = t.schema_id
    WHERE s.name = 'bronze'
      AND t.name = 'pedido_venda_chokdistribuidora'
      AND i.name = 'IX_pedidovenda_chokdist_nuped_cdemp'
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_pedidovenda_chokdist_nuped_cdemp
        ON bronze.pedido_venda_chokdistribuidora (nu_ped, cd_emp)
        INCLUDE (cd_prod, qtde, preco_unit, preco_tabela, fator_est_vda, unid_vda, situacao, seq_kit)
        WITH (FILLFACTOR = 85, ONLINE = ON);

    PRINT 'Índice IX_pedidovenda_chokdist_nuped_cdemp criado com sucesso.';
END
ELSE
    PRINT 'Índice IX_pedidovenda_chokdist_nuped_cdemp já existe — nenhuma ação necessária.';
GO

-- -----------------------------------------------------------------------------
-- 3) Verificação pós-criação
-- -----------------------------------------------------------------------------
SELECT
    t.name AS tabela,
    i.name AS indice,
    i.type_desc,
    (
        SELECT STRING_AGG(c2.name, ', ') WITHIN GROUP (ORDER BY ic2.key_ordinal)
        FROM sys.index_columns ic2
        JOIN sys.columns c2
            ON c2.object_id = ic2.object_id AND c2.column_id = ic2.column_id
        WHERE ic2.object_id = i.object_id
          AND ic2.index_id = i.index_id
          AND ic2.is_included_column = 0
    ) AS key_cols,
    (
        SELECT STRING_AGG(c2.name, ', ') WITHIN GROUP (ORDER BY ic2.index_column_id)
        FROM sys.index_columns ic2
        JOIN sys.columns c2
            ON c2.object_id = ic2.object_id AND c2.column_id = ic2.column_id
        WHERE ic2.object_id = i.object_id
          AND ic2.index_id = i.index_id
          AND ic2.is_included_column = 1
    ) AS included_cols
FROM sys.indexes i
JOIN sys.tables t ON t.object_id = i.object_id
JOIN sys.schemas s ON s.schema_id = t.schema_id
WHERE s.name = 'bronze'
  AND t.name IN ('venda_chokdistribuidora', 'pedido_venda_chokdistribuidora')
  AND i.type > 0
ORDER BY t.name, i.name;
GO

-- =============================================================================
-- RESULTADO ESPERADO APÓS EXECUÇÃO:
--
-- tabela                              | indice                               | type_desc    | key_cols  | included_cols
-- venda_chokdistribuidora             | IX_venda_chokdist_dt_ped             | NONCLUSTERED | dt_ped    | nu_ped, cd_emp, ...
-- pedido_venda_chokdistribuidora      | IX_pedidovenda_chokdist_nuped_cdemp  | NONCLUSTERED | nu_ped, cd_emp | cd_prod, ...
--
-- GANHO ESPERADO:
-- - Query com $filter=data eq 'YYYY-MM-DD': de >30s para <2s
-- - Query com $filter=data ge '...' and data le '...': proporcional ao período
-- - NUNCA chamar o endpoint sem $filter=data (mesmo com índice, mês completo
--   pode demorar dependendo do volume)
-- =============================================================================
