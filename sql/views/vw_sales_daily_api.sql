CREATE OR ALTER VIEW dbo.vw_sales_daily_api
AS
/*
  Agregado diário "API-ready".
  - Derivado de dbo.vw_sales_daily
  - Inclui cnpj_empresa_origem via dbo.vw_empresa_dim (quando houver fonte)
*/
SELECT
  e.cnpj_empresa_origem,
  v.tenant_id,
  v.dt_ref,
  v.vl_venda,
  v.qt_pedidos
FROM dbo.vw_sales_daily v
LEFT JOIN dbo.vw_empresa_dim e
  ON e.cod_empresa = v.tenant_id;
GO
