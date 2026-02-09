CREATE OR ALTER VIEW dbo.vw_stock_position
AS
/*
  MVP: Posição de estoque por SKU.

  Requisitos:
  - tenant_id
  - id_sku/cd_sku
  - qt_estoque

  TODO: ajustar FROM/JOIN conforme tabelas fato/dim reais do datalake.
*/
SELECT
  CAST(NULL AS int)          AS tenant_id,
  CAST(NULL AS varchar(50))  AS id_sku,
  CAST(NULL AS varchar(200)) AS nm_sku,
  CAST(NULL AS decimal(18,3)) AS qt_estoque
WHERE 1 = 0;
GO
