-- =============================================================================
-- Correção do plano de execução: vw_venda_diaria_chokdist
-- Problema: SQL Server escolhe nested loop ao consultar a view, causando timeout.
--           Com HASH JOIN a query retorna em ~29s. Sem o hint, nunca termina.
-- Causa: estatísticas desatualizadas nas tabelas dos CTEs (criadas ANTES dos índices).
-- Executor: DBA com permissão ALTER em GA_DATALAKE
-- =============================================================================

USE GA_DATALAKE;
GO

-- PASSO 1: Atualizar estatísticas com varredura completa
-- Isso faz o otimizador "ver" a cardinalidade real e escolher hash join sozinho.
-- Estimativa de tempo: 5-15 min cada (tabelas grandes)

PRINT 'Atualizando estatísticas — acao_nao_venda (39.8M linhas)...';
UPDATE STATISTICS bronze.acao_nao_venda_chokdistribuidora WITH FULLSCAN;
PRINT '  OK';

PRINT 'Atualizando estatísticas — check_in_out (27.7M linhas)...';
UPDATE STATISTICS bronze.check_in_out_vend_chokdistribuidora WITH FULLSCAN;
PRINT '  OK';

PRINT 'Atualizando estatísticas — venda (343K linhas)...';
UPDATE STATISTICS bronze.venda_chokdistribuidora WITH FULLSCAN;
PRINT '  OK';

PRINT 'Atualizando estatísticas — pedido_venda (linhas menores)...';
UPDATE STATISTICS bronze.pedido_venda_chokdistribuidora WITH FULLSCAN;
PRINT '  OK';
GO

-- PASSO 2: Limpar o plano em cache para forçar recompilação
DBCC FREEPROCCACHE;
GO

-- PASSO 3: Teste de validação — deve retornar em < 60s
PRINT 'Teste de validação: TOP 100 fev/2026...';
DECLARE @t0 DATETIME2 = SYSDATETIME();

SELECT TOP 100
    data, numero_pedido, sku, descricao_produto,
    qtde_vendida, preco_unitario_prod,
    nome_vendedor, municipio
FROM gold.vw_venda_diaria_chokdist
WHERE data >= CAST('2026-02-01' AS date)
  AND data <= CAST('2026-02-28' AS date)
ORDER BY data, numero_pedido;

PRINT CONCAT('Tempo: ', DATEDIFF(MILLISECOND, @t0, SYSDATETIME()), 'ms');
GO

-- =============================================================================
-- SE O PASSO 1 NÃO RESOLVER: criar plan guide para forçar hash join permanentemente
-- =============================================================================

-- Plan guide força HASH JOIN + RECOMPILE em toda query nesta view
-- Executar somente se UPDATE STATISTICS não resolver:

/*
EXEC sp_create_plan_guide
    @name = N'PG_venda_diaria_chokdist_hash',
    @stmt = N'SELECT TOP (100) [data],[numero_pedido],[sku],[descricao_produto],[qtde_vendida],[preco_unitario_prod],[nome_vendedor],[municipio],[categoria],[familia],[fabricante]
FROM [gold].[vw_venda_diaria_chokdist]
WHERE [data]>=@p1 AND [data]<=@p2
ORDER BY [data],[numero_pedido]',
    @type = N'SQL',
    @module_or_batch = NULL,
    @params = N'@p1 date, @p2 date',
    @hints = N'OPTION (HASH JOIN, RECOMPILE)';
GO
*/
-- =============================================================================
