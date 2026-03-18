-- =============================================================================
-- vw_verbas_long_api.sql
-- View em formato LONG para integração GA360 (endpoint verbas-ga360)
--
-- Fonte DIRETA: silver.fact_pagamento_verba_sankhya (254k+ registros)
-- JOINs com dimensões silver:
--   dim_calendario   → ano, mes, competencia
--   dim_empresa      → cnpj, razao_social (P5)
--   dim_funcionario  → cpf, nome_funcionario
--   dim_evento       → cod_evento, nome_evento
--
-- NOTA: a view gold.vw_pagamento_verba_sankhya tem apenas ~10 registros
--       (filtro restritivo ou quebrada). Por isso lemos da fact diretamente.
--
-- Resolve: P1 (performance), P2 (filtro ano), P5 (cnpj_empresa),
--          P6 (tipo_verba), P7 (nomes padronizados)
-- =============================================================================

CREATE OR ALTER VIEW dbo.vw_verbas_long_api
AS
SELECT
  -- PK determinística para DAB (hash de cnpj|cpf|ano|mes|cod_evento)
  CONVERT(varchar(64), HASHBYTES('SHA2_256', CONCAT(
    ISNULL(CAST(e.cnpj AS nvarchar(14)), N''), N'|',
    ISNULL(CAST(f.cpf AS nvarchar(11)), N''), N'|',
    ISNULL(CAST(cal.ano AS nvarchar(4)), N''), N'|',
    ISNULL(CAST(cal.mes AS nvarchar(2)), N''), N'|',
    ISNULL(CAST(ev.cod_evento AS nvarchar(10)), N'')
  )), 2) AS id_verba_long,

  -- Campos obrigatórios (PRD seção 5)
  f.cpf,
  f.nome_funcionario,
  e.cnpj                                    AS cnpj_empresa,
  e.razao_social,
  UPPER(REPLACE(e.razao_social, ' ', '_'))  AS tenant_id,
  cal.ano,
  cal.mes,
  ev.cod_evento,
  ev.nome_evento,
  fact.valor,

  -- tipo_verba mapeado por cod_evento (PRD seção 3.5 — resolve P6)
  CASE
    WHEN ev.cod_evento IN (1, 7, 23, 51, 61, 87, 91,
                           540, 541, 10001, 10027, 10035,
                           10063, 10088, 10095, 10102)
         THEN 'SALDO_SALARIO'
    WHEN ev.cod_evento IN (30, 10044)
         THEN 'COMISSAO_DSR'
    WHEN ev.cod_evento = 31
         THEN 'BONUS'
    WHEN ev.cod_evento IN (10087, 10114)
         THEN 'PREMIO'
    WHEN ev.cod_evento = 10000
         THEN 'VERBA_INDENIZATORIA'
    WHEN ev.cod_evento = 10054
         THEN 'ADIANTAMENTO_VERBA_IDENIZATORIA'
    WHEN ev.cod_evento IN (10008, 10009)
         THEN 'DESC_PLANO_SAUDE'
    WHEN ev.cod_evento = 10098
         THEN 'PLANO_SAUDE_EMPRESA'
    WHEN ev.cod_evento IN (995, 996)
         THEN 'FGTS'
    ELSE 'OUTROS'
  END AS tipo_verba,

  -- competencia derivada (formato YYYY-MM)
  CONCAT(
    CAST(cal.ano AS varchar(4)), '-',
    RIGHT('0' + CAST(cal.mes AS varchar(2)), 2)
  ) AS competencia

FROM silver.fact_pagamento_verba_sankhya AS fact
INNER JOIN silver.dim_calendario AS cal
  ON cal.sk_calendario = fact.sk_calendario
INNER JOIN silver.dim_empresa AS e
  ON e.sk_empresa = fact.sk_empresa
INNER JOIN silver.dim_evento AS ev
  ON ev.sk_evento = fact.sk_evento
LEFT JOIN silver.dim_funcionario AS f
  ON f.sk_funcionario = fact.sk_funcionario;
GO
