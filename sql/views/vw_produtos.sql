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
  CAST(NULL AS int)          AS id_dim_prod,
  CAST(NULL AS int)          AS cod_produto,
  CAST(NULL AS varchar(120)) AS descricao,
  CAST(NULL AS varchar(14))  AS ean,
  CAST(NULL AS varchar(40))  AS categoria,
  CAST(NULL AS varchar(40))  AS grupo,
  CAST(NULL AS varchar(40))  AS familia,
  CAST(NULL AS varchar(60))  AS fornecedor,
  CAST(NULL AS numeric(5,3)) AS peso_liq,
  CAST(NULL AS numeric(5,3)) AS peso_bruto,
  CAST(NULL AS varchar(25))  AS tipo_custo,
  CAST(NULL AS numeric(9,4)) AS custo_unid_produto,
  CAST(NULL AS numeric(9,4)) AS qtde_estoque,
  CAST(NULL AS char(2))      AS unid_compra,
  CAST(NULL AS char(2))      AS unid_estoque,
  CAST(NULL AS smallint)     AS fator,
  CAST(NULL AS tinyint)      AS cod_empresa
WHERE 1 = 0;
GO
