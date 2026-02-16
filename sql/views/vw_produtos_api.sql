CREATE OR ALTER VIEW dbo.vw_produtos_api
AS
/*
  Cadastro de produtos "API-ready".
  - Derivado de dbo.vw_produtos
  - Inclui cnpj_empresa_origem via dbo.vw_empresa_dim (quando houver fonte)
*/
SELECT
  e.cnpj_empresa_origem,
  p.id_dim_prod,
  p.cod_produto,
  p.descricao,
  p.ean,
  p.categoria,
  p.grupo,
  p.familia,
  p.fornecedor,
  p.peso_liq,
  p.peso_bruto,
  p.tipo_custo,
  p.custo_unid_produto,
  p.qtde_estoque,
  p.unid_compra,
  p.unid_estoque,
  p.fator,
  p.cod_empresa
FROM dbo.vw_produtos p
LEFT JOIN dbo.vw_empresa_dim e
  ON e.cod_empresa = p.cod_empresa;
GO
