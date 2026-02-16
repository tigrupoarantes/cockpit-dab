CREATE OR ALTER VIEW dbo.vw_coverage_city_api
AS
/*
  Cobertura por cidade "API-ready".
  - Derivado de dbo.vw_coverage_city
  - Inclui cnpj_empresa_origem via dbo.vw_empresa_dim (quando houver fonte)
*/
SELECT
  e.cnpj_empresa_origem,
  v.tenant_id,
  v.dt_ref,
  v.ds_cidade,
  v.ds_regiao,
  v.qt_clientes,
  v.qt_positivados
FROM dbo.vw_coverage_city v
LEFT JOIN dbo.vw_empresa_dim e
  ON e.cod_empresa = v.tenant_id;
GO
