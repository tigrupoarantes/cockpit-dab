CREATE OR ALTER VIEW vw_venda_prod AS
(
SELECT DISTINCT
	venda.cod_empresa AS COD_EMPRESA
	, tempo.ano AS ANO_VENDA
	, tempo.mes AS MES_VENDA
	, tempo.data AS DATA_VENDA
	, venda.hora_venda AS HORA_VENDA
	, cliente.cpf_cnpj AS CPF_CNPJ_CLIENTE
	, cliente.razao_social AS RAZAO_SOCIAL
	, cliente.endereco AS ENDERECO_CLIENTE
	, cliente.bairro AS BAIRRO_CLIENTE
	, cliente.cidade AS CIDADE_CLIENTE
	, cliente.cep AS CEP_CLIENTE
	, cliente.uf AS UF_CLIENTE
	, cliente.pais AS PAIS_CLIENTE
	, cliente.numero AS NUMERO_CASA_CLIENTE
	, CONCAT(CAST(telefone.ddd AS VARCHAR(4)), CAST(telefone.numero AS VARCHAR(15))) AS TELEFONE_COMERCIAL_CLIENTE
	, cliente.segmento AS SEGMENTO_CLIENTE
	, cliente.latitude AS LATITUDE
	, cliente.longitude AS LOGINTUDE
	, produto.cod_produto AS SKU_PRODUTO
	, produto.ean AS EAN_PRODUTO
	, venda.unid_venda AS UNID_VENDA
	, produto.descricao AS DESCRICAO_PRODUTO
	, produto.categoria AS CATEGORIA_PRODUTO
	, produto.familia AS FAMILIA_PRODUTO
	, fornecedor.razao_social AS FORNECEDOR
	, produto.peso_liq AS PESO_LIQUIDO_PRODUTO
	, venda.qtde_venda AS QTDE_VENDIDA
	, produto_custo.custo_unitario AS CUSTO_UNITARIO
	, venda.vl_unit_venda AS VL_UNIT_VENDA
	, venda.vl_unit_tabela AS VL_UNIT_TABELA
	, vendedor.nome_vendedor AS VENDEDOR
	, vendedor.nome_supervisor AS SUPERVISOR
	, vendedor.nome_gerente AS GERENTE
	, venda.tipo_ped AS TIPO_PEDIDO
	, venda.situacao AS SITUACAO
	, venda.numero_nf AS NF

FROM fact_venda venda

INNER JOIN dim_tempo tempo
	ON tempo.sk_tempo = venda.cod_tempo

INNER JOIN dim_cliente cliente
	ON cliente.sk_cliente = venda.cod_cliente

LEFT JOIN dim_telefone telefone
	ON telefone.cod_cliente = cliente.cod_cliente
		AND telefone.tipo_tel = 'COMERCIAL'

INNER JOIN dim_produto produto
	ON produto.sk_prod = venda.cod_produto

INNER JOIN dim_prod_unid produto_unid
	ON produto_unid.sk_produto = venda.cod_produto

INNER JOIN dim_fornecedor fornecedor
	ON fornecedor.sk_fornecedor = produto_unid.sk_fornecedor

INNER JOIN fact_produto_custo produto_custo
	ON produto_custo.sk_prod = venda.cod_produto
		AND produto_custo.sk_fornecedor = fornecedor.sk_fornecedor
			AND produto_custo.sk_tipo_custo = 1 -- Medio Ponderado

INNER JOIN dim_vendedor vendedor
	ON vendedor.sk_vend = venda.cod_vendedor

)
GO
