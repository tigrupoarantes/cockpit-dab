CREATE OR ALTER VIEW dbo.vw_sales_product_detail_api
AS
/*
  View de vendas (linha por produto) "API-ready".

  Regras (PRD 2):
  - incluir cnpj_empresa_origem (tenant canônico)
  - remover PII desnecessária (cpf/cnpj cliente, email, telefone, endereço, cep)
  - padronizar nomes para filtros/parametrização
  - criar id_linha (hash estável) para key-fields

  Fonte: dbo.vw_sales_product_detail (canônica atual, com joins controlados)
*/
SELECT
  CONVERT(varchar(64), HASHBYTES(
    'SHA2_256',
    CONCAT_WS('|',
      CAST(v.tenant_id AS varchar(10)),
      CONVERT(varchar(10), v.dt_ref, 23),
      CAST(v.numero_pedido AS varchar(20)),
      CAST(v.id_sku AS varchar(20)),
      CAST(v.id_venda AS varchar(20))
    )
  ), 2)                                                       AS id_linha,

  e.cnpj_empresa_origem                                       AS cnpj_empresa_origem,
  v.tenant_id                                                 AS tenant_id,
  v.dt_ref                                                    AS dt_venda,

  v.numero_pedido                                             AS numero_pedido,
  v.numero_nf                                                 AS numero_nf,

  v.id_sku                                                    AS sku,
  v.ean                                                       AS ean,
  v.descricao_produto                                         AS ds_produto,
  v.categoria_produto                                         AS ds_categoria,
  v.familia_produto                                           AS ds_familia,
  v.fornecedor                                                AS nm_fornecedor,
  v.peso_liq                                                  AS peso_liq,

  v.qt_vendida                                                AS qt,
  v.vl_unit_venda                                             AS vl_unit,
  v.vl_unit_pedido                                            AS vl_unit_pedido,
  v.vl_unit_tabela                                            AS vl_unit_tabela,
  v.vl_custo_unitario                                         AS vl_custo_unit,
  CAST(v.qt_vendida * v.vl_unit_venda AS numeric(18,4))        AS vl_total,

  v.cidade_cliente                                            AS ds_cidade,
  v.uf_cliente                                                AS uf,
  v.segmento_cliente                                          AS ds_segmento,

  v.vendedor                                                  AS nm_vendedor,
  v.supervisor                                                AS nm_supervisor,
  v.gerente                                                   AS nm_gerente,
  v.tipo_pedido                                               AS ds_tipo_pedido,
  v.situacao                                                  AS ds_situacao
FROM dbo.vw_sales_product_detail v
LEFT JOIN dbo.vw_empresa_dim e
  ON e.cod_empresa = v.tenant_id;
GO
