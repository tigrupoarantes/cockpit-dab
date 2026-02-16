CREATE OR ALTER VIEW dbo.vw_sales_by_sku_api
AS
/*
  Resumo por SKU "API-ready".
  - Derivado de dbo.vw_sales_by_sku
  - Inclui cnpj_empresa_origem via dbo.vw_empresa_dim (quando houver fonte)
*/
SELECT
  e.cnpj_empresa_origem,
  v.tenant_id,
  v.dt_ref,
  v.id_sku,
  v.nm_sku,
  v.vl_venda,
  v.qt_venda
FROM dbo.vw_sales_by_sku v
LEFT JOIN dbo.vw_empresa_dim e
  ON e.cod_empresa = v.tenant_id;
GO
