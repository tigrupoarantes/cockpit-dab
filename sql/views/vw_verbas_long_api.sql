-- =============================================================================
-- vw_verbas_long_api.sql
-- View em formato LONG para integração GA360 (endpoint verbas-ga360)
--
-- Fonte: gold.vw_pagamento_verba_sankhya (já formato LONG: 1 linha por
--        funcionário × mês × evento)
-- JOINs:
--   silver.dim_empresa   → cnpj (P5)
--   silver.dim_funcionario → cpf
--
-- Resolve: P1 (performance), P2 (filtro ano), P5 (cnpj_empresa),
--          P6 (tipo_verba), P7 (nomes padronizados)
--
-- Cadeia:
--   dbo.vw_verbas_long_api
--     → gold.vw_pagamento_verba_sankhya
--       → silver.fact_pagamento_verba_sankhya + dims
--     → silver.dim_empresa (cnpj)
--     → silver.dim_funcionario (cpf)
-- =============================================================================

CREATE OR ALTER VIEW dbo.vw_verbas_long_api
AS
SELECT
  -- PK determinística para DAB (hash de cnpj|cpf|ano|mes|cod_evento)
  CONVERT(varchar(64), HASHBYTES('SHA2_256', CONCAT(
    ISNULL(CAST(e.cnpj AS nvarchar(14)), N''), N'|',
    ISNULL(CAST(f.cpf AS nvarchar(11)), N''), N'|',
    ISNULL(CAST(src.ano AS nvarchar(4)), N''), N'|',
    ISNULL(CAST(src.mes AS nvarchar(2)), N''), N'|',
    ISNULL(CAST(src.cod_evento AS nvarchar(10)), N'')
  )), 2) AS id_verba_long,

  -- Campos obrigatórios (PRD seção 5)
  f.cpf,
  src.nome_funcionario,
  e.cnpj                              AS cnpj_empresa,
  src.razao_social,
  UPPER(REPLACE(src.razao_social, ' ', '_')) AS tenant_id,
  src.ano,
  src.mes,
  src.cod_evento,
  src.nome_evento,
  src.valor,

  -- tipo_verba mapeado por cod_evento (PRD seção 3.5 — resolve P6)
  CASE
    WHEN src.cod_evento IN (1, 7, 23, 51, 61, 87, 91,
                            540, 541, 10001, 10027, 10035,
                            10063, 10088, 10095, 10102)
         THEN 'SALDO_SALARIO'
    WHEN src.cod_evento IN (30, 10044)
         THEN 'COMISSAO_DSR'
    WHEN src.cod_evento = 31
         THEN 'BONUS'
    WHEN src.cod_evento IN (10087, 10114)
         THEN 'PREMIO'
    WHEN src.cod_evento = 10000
         THEN 'VERBA_INDENIZATORIA'
    WHEN src.cod_evento = 10054
         THEN 'ADIANTAMENTO_VERBA_IDENIZATORIA'
    WHEN src.cod_evento IN (10008, 10009)
         THEN 'DESC_PLANO_SAUDE'
    WHEN src.cod_evento = 10098
         THEN 'PLANO_SAUDE_EMPRESA'
    WHEN src.cod_evento IN (995, 996)
         THEN 'FGTS'
    ELSE 'OUTROS'
  END AS tipo_verba,

  -- competencia derivada (formato YYYY-MM)
  CONCAT(
    CAST(src.ano AS varchar(4)), '-',
    RIGHT('0' + CAST(src.mes AS varchar(2)), 2)
  ) AS competencia

FROM gold.vw_pagamento_verba_sankhya AS src
INNER JOIN silver.dim_empresa AS e
  ON e.cod_empresa = src.cod_empresa
LEFT JOIN silver.dim_funcionario AS f
  ON f.cod_funcionario = src.cod_funcionario
  AND f.sk_empresa = e.sk_empresa;
GO
