CREATE OR ALTER VIEW dbo.vw_coverage_city
AS
/*
  MVP: Cobertura/positivação por cidade/região.

  Requisitos:
  - tenant_id
  - dt_ref (quando aplicável)
  - cidade/região
  - métricas (clientes ativos/positivados etc.)

  TODO: ajustar FROM/JOIN conforme tabelas fato/dim reais do datalake.
*/
WITH base_clientes AS (
  SELECT
    c.cod_empresa                AS tenant_id,
    CAST(c.cidade AS varchar(120)) AS ds_cidade,
    CAST(c.uf AS varchar(120))     AS ds_regiao,
    COUNT(DISTINCT c.cod_cliente)  AS qt_clientes
  FROM dbo.dim_cliente c
  WHERE c.cod_empresa IS NOT NULL
  GROUP BY
    c.cod_empresa,
    c.cidade,
    c.uf
), positivacao AS (
  SELECT
    v.tenant_id                   AS tenant_id,
    v.dt_ref                      AS dt_ref,
    CAST(v.cidade_cliente AS varchar(120)) AS ds_cidade,
    CAST(v.uf_cliente AS varchar(120))     AS ds_regiao,
    COUNT(DISTINCT v.cod_cliente)          AS qt_positivados
  FROM dbo.vw_sales_product_detail v
  GROUP BY
    v.tenant_id,
    v.dt_ref,
    v.cidade_cliente,
    v.uf_cliente
)
SELECT
  p.tenant_id,
  p.dt_ref,
  p.ds_cidade,
  p.ds_regiao,
  b.qt_clientes,
  p.qt_positivados
FROM positivacao p
LEFT JOIN base_clientes b
  ON b.tenant_id = p.tenant_id
 AND b.ds_cidade = p.ds_cidade
 AND b.ds_regiao = p.ds_regiao;
GO

