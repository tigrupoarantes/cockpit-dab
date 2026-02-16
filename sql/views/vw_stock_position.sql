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
  CAST(p.cod_empresa AS int)                AS tenant_id,
  CAST(p.cod_produto AS varchar(50))        AS id_sku,
  CAST(p.descricao AS varchar(200))         AS nm_sku,
  CAST(p.qtde_estoque AS decimal(18,3))     AS qt_estoque
FROM dbo.dim_produto p
WHERE p.cod_empresa IS NOT NULL;
GO

