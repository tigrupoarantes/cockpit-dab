CREATE OR ALTER VIEW dbo.vw_sales_product_detail
AS
/*
  Detalhe de vendas por produto (linha de venda), com dimensoes de tempo/cliente/produto/vendedor.

  Origem: view legado dbo.vw_venda_prod (exportada como vw_venda_prod.original.sql)

  Observacoes de performance/qualidade:
  - O DISTINCT indica que algum JOIN provavelmente esta gerando duplicidade (JOIN 1:N).
    O ideal e ajustar a chave/filtro (ex.: vigencia/custo atual/fornecedor principal) para remover o DISTINCT.
  - Qualifique schemas (dbo.) para evitar resolucao por default schema.
  - Colunas foram normalizadas para nomes previsiveis e faceis de filtrar via parametros (DAB).
*/
SELECT DISTINCT
  venda.sk_venda                                                  AS id_venda,
  venda.cod_empresa                                              AS tenant_id,
  tempo.ano                                                      AS ano_venda,
  tempo.mes                                                      AS mes_venda,
  tempo.data                                                     AS dt_ref,
  venda.hora_venda                                               AS hr_venda,

  cliente.cpf_cnpj                                               AS cpf_cnpj_cliente,
  cliente.razao_social                                           AS razao_social_cliente,
  cliente.endereco                                               AS endereco_cliente,
  cliente.bairro                                                 AS bairro_cliente,
  cliente.cidade                                                 AS cidade_cliente,
  cliente.cep                                                    AS cep_cliente,
  cliente.uf                                                     AS uf_cliente,
  cliente.pais                                                   AS pais_cliente,
  cliente.numero                                                 AS numero_endereco_cliente,
  CONCAT(CAST(telefone.ddd AS varchar(4)), CAST(telefone.numero AS varchar(15))) AS telefone_comercial_cliente,
  cliente.segmento                                               AS segmento_cliente,
  cliente.latitude                                               AS latitude_cliente,
  cliente.longitude                                              AS longitude_cliente,

  produto.cod_produto                                            AS id_sku,
  produto.ean                                                    AS ean,
  venda.unid_pedido                                              AS unid_venda,
  produto.descricao                                              AS descricao_produto,
  produto.categoria                                              AS categoria_produto,
  produto.familia                                                AS familia_produto,
  fornecedor.razao_social                                        AS fornecedor,
  produto.peso_liq                                               AS peso_liq,

  venda.qtde_venda                                               AS qt_vendida,
  produto_custo.custo_unitario                                   AS vl_custo_unitario,
  venda.preco_unit                                               AS vl_unit_venda,
  venda.vl_unit_tabela                                           AS vl_unit_tabela,

  vendedor.nome_vendedor                                         AS vendedor,
  vendedor.nome_supervisor                                       AS supervisor,
  vendedor.nome_gerente                                          AS gerente,
  venda.tipo_ped                                                 AS tipo_pedido,
  venda.situacao                                                 AS situacao,
  venda.numero_nf                                                AS numero_nf
FROM dbo.fact_venda_produto venda
INNER JOIN dbo.dim_tempo tempo
  ON tempo.sk_tempo = venda.sk_tempo
INNER JOIN dbo.dim_cliente cliente
  ON cliente.sk_cliente = venda.sk_cliente
LEFT JOIN dbo.dim_telefone telefone
  ON telefone.sk_cliente = cliente.sk_cliente
 AND telefone.tipo_tel = 'COMERCIAL'
INNER JOIN dbo.dim_produto produto
  ON produto.sk_prod = venda.sk_produto
INNER JOIN dbo.dim_prod_unid produto_unid
  ON produto_unid.sk_produto = venda.sk_produto
INNER JOIN dbo.dim_fornecedor fornecedor
  ON fornecedor.sk_fornecedor = produto_unid.sk_fornecedor
INNER JOIN dbo.fact_produto_custo produto_custo
  ON produto_custo.sk_prod = venda.sk_produto
 AND produto_custo.sk_fornecedor = fornecedor.sk_fornecedor
 AND produto_custo.sk_tipo_custo = 1 -- Medio Ponderado
LEFT JOIN dbo.dim_vendedor vendedor
  ON vendedor.sk_vend = venda.sk_vendedor;
GO
