CREATE OR ALTER VIEW dbo.vw_sales_by_sku
AS
/*
  MVP: Ranking/Resumo por SKU por período.

  Requisitos:
  - tenant_id
  - dt_ref (ou dt_venda) para filtro
  - id_sku/cd_sku + descrição
  - métricas (qt, vl)

  TODO: ajustar FROM/JOIN conforme tabelas fato/dim reais do datalake.
*/
SELECT
  v.tenant_id                                        AS tenant_id,
  v.dt_ref                                           AS dt_ref,
  CAST(v.id_sku AS varchar(50))                      AS id_sku,
  CAST(MAX(v.descricao_produto) AS varchar(200))     AS nm_sku,
  CAST(SUM(v.qt_vendida * v.vl_unit_venda) AS numeric(18,4)) AS vl_venda,
  CAST(SUM(v.qt_vendida) AS numeric(18,4))           AS qt_venda
FROM dbo.vw_sales_product_detail v
GROUP BY
  v.tenant_id,
  v.dt_ref,
  v.id_sku;
GO

