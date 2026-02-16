CREATE OR ALTER VIEW dbo.vw_produtos
AS
/*
  MVP: Lista de produtos.

  Observação:
  - Esta view precisa COMPILAR em qualquer ambiente para o DAB iniciar.
  - Em alguns bancos, a tabela de origem/colunas podem divergir.
  - Por isso, esta implementação é um "stub" (retorna 0 linhas).

  TODO: mapear para a dimensão real (ex.: dbo.dim_produto) quando o schema estiver confirmado.
  Chave (PK exposta): id_dim_prod
*/
SELECT
  p.sk_prod                                              AS id_dim_prod,
  p.cod_produto                                          AS cod_produto,
  CAST(p.descricao AS varchar(120))                      AS descricao,
  CAST(p.ean AS varchar(14))                             AS ean,
  CAST(p.categoria AS varchar(40))                       AS categoria,
  CAST(p.grupo AS varchar(40))                           AS grupo,
  CAST(p.familia AS varchar(40))                         AS familia,
  CAST(fornecedor.razao_social AS varchar(60))           AS fornecedor,
  p.peso_liq                                             AS peso_liq,
  p.peso_bruto                                           AS peso_bruto,
  CAST('MEDIO_PONDERADO' AS varchar(25))                 AS tipo_custo,
  CAST(custo.custo_unitario AS numeric(9,4))             AS custo_unid_produto,
  CAST(p.qtde_estoque AS numeric(9,4))                   AS qtde_estoque,
  CAST(prod_unid.unid_compra AS char(2))                 AS unid_compra,
  CAST(prod_unid.unid_estoque AS char(2))                AS unid_estoque,
  CAST(prod_unid.fator AS smallint)                      AS fator,
  p.cod_empresa                                          AS cod_empresa
FROM dbo.dim_produto p
OUTER APPLY (
  SELECT TOP (1)
    pu.sk_fornecedor,
    pu.unid_compra,
    pu.unid_estoque,
    pu.fator
  FROM dbo.dim_prod_unid pu
  WHERE pu.sk_produto = p.sk_prod
  ORDER BY pu.sk_fornecedor
) prod_unid
OUTER APPLY (
  SELECT TOP (1)
    f.razao_social
  FROM dbo.dim_fornecedor f
  WHERE f.sk_fornecedor = prod_unid.sk_fornecedor
  ORDER BY f.sk_fornecedor
) fornecedor
OUTER APPLY (
  SELECT TOP (1)
    pc.custo_unitario
  FROM dbo.fact_produto_custo pc
  WHERE pc.sk_prod = p.sk_prod
    AND pc.sk_tipo_custo = 1
    AND (prod_unid.sk_fornecedor IS NULL OR pc.sk_fornecedor = prod_unid.sk_fornecedor)
  ORDER BY pc.sk_fornecedor
) custo
WHERE p.cod_empresa IS NOT NULL;
GO
