CREATE OR ALTER VIEW dbo.vw_venda_prod
AS
/*
  Wrapper de compatibilidade (legado): mantem os nomes de colunas originais.

  View canonica (mais legivel/filtravel): dbo.vw_sales_product_detail
  Definicao original exportada: vw_venda_prod.original.sql
*/
SELECT
  v.id_venda                  AS ID_VENDA,
  CAST(v.tenant_id AS varchar(18)) AS EMPRESA,
  v.tenant_id                 AS COD_EMPRESA,
  v.ano_venda                 AS ANO_VENDA,
  v.mes_venda                 AS MES_VENDA,
  v.dt_ref                    AS DATA_VENDA,
  v.hr_venda                  AS HORA_VENDA,

  v.cpf_cnpj_cliente          AS CPF_CNPJ_CLIENTE,
  v.cod_cliente               AS CODIGO_CLIENTE,
  v.razao_social_cliente      AS RAZAO_SOCIAL,
  v.endereco_cliente          AS ENDERECO_CLIENTE,
  v.bairro_cliente            AS BAIRRO_CLIENTE,
  v.cidade_cliente            AS CIDADE_CLIENTE,
  v.cep_cliente               AS CEP_CLIENTE,
  v.uf_cliente                AS UF_CLIENTE,
  v.pais_cliente              AS PAIS_CLIENTE,
  v.numero_endereco_cliente   AS NUMERO_CASA_CLIENTE,
  v.telefone_comercial_cliente AS TELEFONE_COMERCIAL_CLIENTE,
  v.email_cliente             AS EMAIL_CLIENTE,
  v.segmento_cliente          AS SEGMENTO_CLIENTE,
  v.latitude_cliente          AS LATITUDE,
  v.longitude_cliente         AS LOGINTUDE,
  v.longitude_cliente         AS LONGITUDE,

  v.id_sku                    AS SKU_PRODUTO,
  v.ean                       AS EAN_PRODUTO,
  v.unid_venda                AS UNID_VENDA,
  v.descricao_produto         AS DESCRICAO_PRODUTO,
  v.categoria_produto         AS CATEGORIA_PRODUTO,
  v.familia_produto           AS FAMILIA_PRODUTO,
  v.fornecedor                AS FORNECEDOR,
  v.peso_liq                  AS PESO_LIQUIDO_PRODUTO,

  v.qt_vendida                AS QTDE_VENDIDA,
  v.vl_custo_unitario         AS CUSTO_UNITARIO,
  v.vl_unit_venda             AS VL_UNIT_VENDA,
  v.vl_unit_pedido            AS VL_UNIT_PEDIDO,
  v.vl_unit_tabela            AS VL_UNIT_TABELA,

  v.vendedor                  AS VENDEDOR,
  v.supervisor                AS SUPERVISOR,
  v.gerente                   AS GERENTE,
  v.tipo_pedido               AS TIPO_PEDIDO,
  v.situacao                  AS SITUACAO,
  v.numero_nf                 AS NF,
  v.numero_pedido             AS NUMERO_PEDIDO
FROM dbo.vw_sales_product_detail v;
GO
