-- =============================================================
-- PRÉ-REQUISITOS DBA — Onboarding vw_venda_diaria_chokdist
-- Executar no GA_DATALAKE antes do onboarding no DAB
-- Autor: Gerado por cockpit-dab — 2026-03-13
-- =============================================================

USE GA_DATALAKE;
GO

-- -------------------------------------------------------
-- PASSO 1: Verificar existência da view em gold
-- -------------------------------------------------------
SELECT name, SCHEMA_NAME(schema_id) AS schema_name
FROM sys.views
WHERE name = 'vw_venda_diaria_chokdist';
-- Esperado: 1 linha com schema_name = 'gold'
GO

-- -------------------------------------------------------
-- PASSO 2: Criar sinônimo dbo → gold (se não existir)
-- -------------------------------------------------------
IF NOT EXISTS (
    SELECT 1 FROM sys.synonyms
    WHERE name = 'vw_venda_diaria_chokdist'
      AND SCHEMA_NAME(schema_id) = 'dbo'
)
BEGIN
    CREATE SYNONYM dbo.vw_venda_diaria_chokdist
        FOR gold.vw_venda_diaria_chokdist;
    PRINT 'Sinônimo criado: dbo.vw_venda_diaria_chokdist → gold.vw_venda_diaria_chokdist';
END
ELSE
BEGIN
    PRINT 'Sinônimo já existe — nenhuma ação necessária.';
END
GO

-- Verificar
SELECT name, base_object_name FROM sys.synonyms
WHERE name = 'vw_venda_diaria_chokdist';
-- Esperado: base_object_name = '[GA_DATALAKE].[gold].[vw_venda_diaria_chokdist]'
GO

-- -------------------------------------------------------
-- PASSO 3: Validar unicidade numero_pedido + sku
-- -------------------------------------------------------
-- Deve retornar 0 linhas. Se retornar linhas, a chave composta
-- não é única e o onboarding deve ser bloqueado até resolução.
SELECT numero_pedido, sku, COUNT(*) AS ocorrencias
FROM dbo.vw_venda_diaria_chokdist
WHERE data >= CAST(GETDATE()-7 AS DATE)
GROUP BY numero_pedido, sku
HAVING COUNT(*) > 1;
-- Esperado: 0 linhas
GO

-- -------------------------------------------------------
-- PASSO 4: Conceder SELECT ao usuário DAB
-- -------------------------------------------------------
-- !! Substituir <dab_user> pelo usuário real da DAB_CONNECTION_STRING
-- Para descobrir o usuário: consultar variável de ambiente DAB_CONNECTION_STRING no servidor DAB
--
-- GRANT SELECT ON dbo.vw_venda_diaria_chokdist TO <dab_user>;
-- GO

-- Verificar permissão (executar como o usuário DAB ou via HAS_PERMS_BY_NAME)
SELECT HAS_PERMS_BY_NAME('dbo.vw_venda_diaria_chokdist', 'OBJECT', 'SELECT') AS tem_select;
-- Esperado: 1
GO

-- -------------------------------------------------------
-- PASSO 5: Validar performance
-- -------------------------------------------------------
SET STATISTICS TIME ON;
SELECT TOP 500 *
FROM dbo.vw_venda_diaria_chokdist
WHERE data = CAST(GETDATE() AS DATE);
SET STATISTICS TIME OFF;
-- Meta: CPU + Elapsed < 3000ms
-- Se > 3s: avaliar índice em bronze.venda_chokdistribuidora(dt_ped)
--          e em pedido_venda_chokdistribuidora(nu_ped)
GO
