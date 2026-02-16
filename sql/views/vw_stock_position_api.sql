CREATE OR ALTER VIEW dbo.vw_stock_position_api
AS
/*
  Estoque por SKU "API-ready".
  - Derivado de dbo.vw_stock_position
  - Inclui cnpj_empresa_origem via dbo.vw_empresa_dim (quando houver fonte)
*/
SELECT
  e.cnpj_empresa_origem,
  v.tenant_id,
  v.id_sku,
  v.nm_sku,
  v.qt_estoque
FROM dbo.vw_stock_position v
LEFT JOIN dbo.vw_empresa_dim e
  ON e.cod_empresa = v.tenant_id;
GO
