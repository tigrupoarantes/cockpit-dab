-- View simplificada para visualização rápida enquanto UPDATE STATISTICS roda.
-- Remove os CTEs pesados (checkin 27.7M, acao_nv 39.8M) que causam timeout.
-- Retorna os KPIs principais de vendas sem dados de check-in e ação não-venda.

CREATE OR ALTER VIEW gold.vw_venda_diaria_chokdist_lite AS

WITH evento_lib AS (
    SELECT
        nu_ped,
        cd_clien,
        MAX(CASE WHEN cd_fila = 'SEPA' THEN dt_encer END) AS dt_separacao,
        MAX(CASE WHEN cd_fila = 'ENTR' THEN dt_encer END) AS dt_entrega
    FROM bronze.evento_liberacao_venda_chokdistribuidora
    WHERE cd_fila IN ('SEPA','ENTR')
    GROUP BY nu_ped, cd_clien
),

nf AS (
    SELECT
        nu_ped,
        MAX(nu_nf_emp_fat) AS nota_fiscal
    FROM bronze.nota_fiscal_chokdistribuidora
    GROUP BY nu_ped
)

SELECT
    'CHOK DISTRIBUIDORA' AS empresa,

    cal.ano,
    cal.nome_mes,
    cal.data,

    CAST(venda.dt_cad AS TIME(0)) AS hora_cadastro,

    cli.cgc_cpf AS cnpj_cpf,
    cli.cd_clien AS cod_cliente,
    grupocli.descricao AS grupo_cliente,
    cli.nome AS razao_social,

    end_cliente.endereco,
    end_cliente.bairro,
    end_cliente.municipio,
    end_cliente.cep,
    end_cliente.estado,
    end_cliente.cd_pais AS cod_pais,
    cli.e_mail AS email,

    ram_ativ.descricao AS segmento,
    end_cliente.latitude,
    end_cliente.longitude,

    origem_ped.descricao AS origem_pedido,

    prod.ean,
    prod.cod_prod AS sku,
    prod.descricao AS descricao_produto,

    categ_prod.descricao AS categoria,
    linha.descricao AS familia,
    secao.descricao AS grupo,
    fabric.descricao AS fabricante,

    CAST(prod.peso_liq AS DECIMAL(14,3)) AS peso_liq_unid,

    kit_prom.seq_kit AS codigo_promocao,
    kit_prom.descricao AS descricao_promocao,

    unid_desc.descricao AS unidade_venda,

    pedido.fator_est_vda AS fator_pedido,
    CAST(pedido.qtde AS INT) AS qtde_vendida,

    CAST(custo_prod.vl_custo AS DECIMAL(14,4)) AS custo_unitario_prod,
    CAST(pedido.preco_unit AS DECIMAL(14,4)) AS preco_unitario_prod,
    CAST(preco_tabela.vl_preco AS DECIMAL(14,4)) AS preco_tabela_cadastro,
    CAST((pedido.preco_tabela - pedido.preco_unit) AS DECIMAL(14,2)) AS desconto_aplicado_prod,

    vendedor.cod_vendedor,
    vendedor.nome_guerra AS nome_vendedor,

    supervisor.cod_vendedor AS cod_supervisor,
    supervisor.nome AS nome_supervisor,

    equipe.descricao AS nome_da_equipe,

    gerente.cod_vendedor AS cod_gerente,
    gerente.nome AS nome_gerente,

    gerencia.descricao AS nome_gerencia,

    pedido.nu_ped AS numero_pedido,

    tp_ped.descricao AS tipo_pedido,
    situacao_ped.descricao AS situacao_pedido,

    nf.nota_fiscal,

    venda.prz_medio AS prazo_venda_cliente,
    cli_emp.prz_medio_max AS prazo_cadastro_cliente,

    CAST(evento_lib.dt_separacao AS DATE) AS data_liberacao_pedido,
    CAST(evento_lib.dt_separacao AS TIME(0)) AS hora_liberacao_pedido,
    CAST(evento_lib.dt_entrega AS DATE) AS data_entrega,
    CAST(evento_lib.dt_entrega AS TIME(0)) AS hora_entrega

FROM bronze.venda_chokdistribuidora venda

INNER JOIN bronze.pedido_venda_chokdistribuidora pedido
    ON pedido.nu_ped = venda.nu_ped AND pedido.cd_emp = venda.cd_emp

INNER JOIN silver.dim_calendario cal
    ON cal.data = venda.dt_ped

LEFT JOIN bronze.cliente_chokdistribuidora cli
    ON cli.cd_clien = venda.cd_clien

LEFT JOIN bronze.cliente_empresa_chokdistribuidora cli_emp
    ON cli_emp.cd_clien = cli.cd_clien

LEFT JOIN bronze.end_cliente_chokdistribuidora end_cliente
    ON end_cliente.cd_clien = cli.cd_clien AND end_cliente.tp_end = 'EN'

LEFT JOIN silver.dim_grupo_cliente_chokdistribuidora grupocli
    ON grupocli.cod_grupo_cliente = cli.cd_grupocli COLLATE SQL_Latin1_General_CP1_CI_AI

LEFT JOIN silver.dim_ramo_atividade_chokdistribuidora ram_ativ
    ON ram_ativ.cod_ramo_atividade = cli.ram_ativ COLLATE SQL_Latin1_General_CP1_CI_AI

INNER JOIN silver.dim_prod_chokdistribuidora prod
    ON prod.cod_prod = pedido.cd_prod

LEFT JOIN bronze.custo_prod_chokdistribuidora custo_prod
    ON custo_prod.cd_prod = pedido.cd_prod AND custo_prod.cd_emp = venda.cd_emp
    AND custo_prod.tp_custo = 'CMP'

LEFT JOIN bronze.preco_tabela_prod_chokdistribuidora preco_tabela
    ON preco_tabela.cd_prod = pedido.cd_prod AND preco_tabela.cd_tabela = venda.cd_tabela

LEFT JOIN bronze.kit_promocao_chokdistribuidora kit_prom
    ON kit_prom.seq_kit = pedido.seq_kit

LEFT JOIN bronze.unidade_prod_descricao_chokdistribuidora unid_desc
    ON unid_desc.unidade = pedido.unid_vda

LEFT JOIN silver.dim_fabric_chokdistribuidora fabric
    ON fabric.sk_fabricante = prod.sk_fabric

LEFT JOIN silver.dim_linha_chokdistribuidora linha
    ON linha.sk_linha = prod.sk_linha

LEFT JOIN silver.dim_categ_prod_chokdistribuidora categ_prod
    ON categ_prod.sk_categoria = linha.sk_categ

LEFT JOIN silver.dim_secao_chokdistribuidora secao
    ON secao.sk_secao = linha.sk_secao

INNER JOIN silver.dim_vendedor_chokdistribuidora vendedor
    ON vendedor.cod_vendedor = venda.cd_vend COLLATE SQL_Latin1_General_CP1_CI_AI

LEFT JOIN silver.dim_equipe_chokdistribuidora equipe
    ON equipe.cod_equipe = vendedor.cod_equipe

LEFT JOIN silver.dim_vendedor_chokdistribuidora supervisor
    ON supervisor.sk_vendedor = equipe.sk_supervisor

LEFT JOIN silver.dim_gerencia_chokdistribuidora gerencia
    ON gerencia.sk_gerencia = equipe.sk_gerencia

LEFT JOIN silver.dim_vendedor_chokdistribuidora gerente
    ON gerente.sk_vendedor = gerencia.sk_gerente

LEFT JOIN evento_lib
    ON evento_lib.nu_ped = venda.nu_ped AND evento_lib.cd_clien = venda.cd_clien

LEFT JOIN nf
    ON nf.nu_ped = venda.nu_ped

LEFT JOIN silver.dim_tipo_pedido_chokdistribuidora tp_ped
    ON tp_ped.cod_tipo_pedido = venda.tp_ped COLLATE SQL_Latin1_General_CP1_CI_AI

LEFT JOIN silver.dim_situacao_pedido_chokdistribuidora situacao_ped
    ON situacao_ped.cod_situacao_pedido = pedido.situacao COLLATE SQL_Latin1_General_CP1_CI_AI

LEFT JOIN bronze.origem_pedido_chokdistribuidora origem_ped
    ON origem_ped.OrigemPedidoVenda = venda.origem_pedido
