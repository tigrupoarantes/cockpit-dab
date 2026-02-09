CREATE OR ALTER VIEW dbo.vw_produtos
AS
/*
  MVP: Lista de produtos.

  Fonte: dbo.dim_produto
  Chave (PK): id_dim_prod
*/
SELECT
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
FROM dbo.dim_produto p;
GO
