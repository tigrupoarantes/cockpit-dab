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
  CAST(NULL AS int)           AS tenant_id,
  CAST(NULL AS date)          AS dt_ref,
  CAST(NULL AS varchar(50))   AS id_sku,
  CAST(NULL AS varchar(200))  AS nm_sku,
  CAST(NULL AS decimal(18,2)) AS vl_venda,
  CAST(NULL AS decimal(18,3)) AS qt_venda
WHERE 1 = 0;
GO
