<!-- generated: lakehouse-object -->
# gold.vw_venda_diaria_g4dist

- Tipo: `VIEW`
- Industria: `g4distribuidora`
- Origem: `database:GA_DATALAKE`
- PKs: Nao identificado no banco
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | empresa | varchar(18) | False | False | False | - |
| 2 | ano | smallint | False | False | False | - |
| 3 | nome_mes | varchar(15) | False | False | False | - |
| 4 | data | date | False | False | False | - |
| 5 | hora_cadastro | time(0) | True | False | False | - |
| 6 | cnpj_cpf | varchar(14) | True | False | False | - |
| 7 | cod_cliente | int | True | False | False | - |
| 8 | grupo_cliente | varchar(60) | True | False | False | - |
| 9 | razao_social | varchar(60) | True | False | False | - |
| 10 | endereco | varchar(140) | True | False | False | - |
| 11 | bairro | varchar(60) | True | False | False | - |
| 12 | municipio | varchar(60) | True | False | False | - |
| 13 | cep | int | True | False | False | - |
| 14 | estado | char(2) | True | False | False | - |
| 15 | cod_pais | char(3) | True | False | False | - |
| 16 | email | varchar(80) | True | False | False | - |
| 17 | segmento | varchar(40) | True | False | False | - |
| 18 | latitude | numeric(15,12) | True | False | False | - |
| 19 | longitude | numeric(15,12) | True | False | False | - |
| 20 | origem_pedido | varchar(40) | True | False | False | - |
| 21 | ean | varchar(14) | True | False | False | - |
| 22 | sku | int | False | False | False | - |
| 23 | descricao_produto | varchar(120) | False | False | False | - |
| 24 | categoria | varchar(40) | True | False | False | - |
| 25 | familia | varchar(40) | True | False | False | - |
| 26 | grupo | varchar(40) | True | False | False | - |
| 27 | fabricante | varchar(40) | True | False | False | - |
| 28 | peso_liq_unid | decimal(14,3) | True | False | False | - |
| 29 | codigo_promocao | int | True | False | False | - |
| 30 | descricao_promocao | varchar(40) | True | False | False | - |
| 31 | unidade_venda | varchar(30) | True | False | False | - |
| 32 | fator_pedido | float | True | False | False | - |
| 33 | qtde_vendida | int | True | False | False | - |
| 34 | custo_unitario_prod | decimal(14,4) | True | False | False | - |
| 35 | preco_unitario_prod | decimal(14,4) | True | False | False | - |
| 36 | preco_tabela_cadastro | decimal(14,4) | True | False | False | - |
| 37 | desconto_aplicado_prod | decimal(14,2) | True | False | False | - |
| 38 | cod_vendedor | varchar(8) | False | False | False | - |
| 39 | nome_vendedor | varchar(20) | True | False | False | - |
| 40 | cod_supervisor | varchar(8) | True | False | False | - |
| 41 | nome_supervisor | varchar(40) | True | False | False | - |
| 42 | nome_da_equipe | varchar(20) | True | False | False | - |
| 43 | cod_gerente | varchar(8) | True | False | False | - |
| 44 | nome_gerente | varchar(40) | True | False | False | - |
| 45 | nome_gerencia | varchar(40) | True | False | False | - |
| 46 | hora_inicio_checkin | time(0) | True | False | False | - |
| 47 | hora_fim_checkout | time(0) | True | False | False | - |
| 48 | duracao_checkin_minutos | int | True | False | False | - |
| 49 | acao_nao_venda | varchar(250) | True | False | False | - |
| 50 | motivo_nao_venda | varchar(20) | True | False | False | - |
| 51 | data_liberacao_pedido | date | True | False | False | - |
| 52 | hora_liberacao_pedido | time(0) | True | False | False | - |
| 53 | numero_pedido | int | False | False | False | - |
| 54 | tipo_pedido | varchar(30) | True | False | False | - |
| 55 | situacao_pedido | varchar(20) | True | False | False | - |
| 56 | nota_fiscal | int | True | False | False | - |
| 57 | prazo_venda_cliente | numeric(6,2) | True | False | False | - |
| 58 | prazo_cadastro_cliente | smallint | True | False | False | - |
| 59 | data_entrega | date | True | False | False | - |
| 60 | hora_entrega | time(0) | True | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL

```sql
CREATE   VIEW gold.vw_venda_diaria_g4dist AS

WITH evento_lib AS (
SELECT
    nu_ped,
    cd_clien,
    MAX(CASE WHEN cd_fila = 'SEPA' THEN dt_encer END) AS dt_separacao,
    MAX(CASE WHEN cd_fila = 'ENTR' THEN dt_encer END) AS dt_entrega
FROM bronze.evento_liberacao_venda_g4_distribuidora
WHERE cd_fila IN ('SEPA','ENTR')
GROUP BY
    nu_ped,
    cd_clien
),

checkin AS (
SELECT * 
FROM (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY CodigoVendedor, CodigoCliente
            ORDER BY Data DESC
        ) AS rn
    FROM bronze.check_in_out_vend_g4_distribuidora
    ) t
    WHERE rn = 1
),

nf AS (
SELECT
    nu_ped,
    MAX(nu_nf_emp_fat) AS nota_fiscal
FROM bronze.nota_fiscal_g4_distribuidora
GROUP BY nu_ped
),

acao_nv AS (
SELECT *
    FROM (
        SELECT *, 
            ROW_NUMBER() OVER (
                PARTITION BY cd_clien, cd_vend
                ORDER BY data DESC
            ) AS rn
        FROM bronze.acao_nao_venda_g4_distribuidora
        ) t
        WHERE rn = 1
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

    CONVERT(TIME(0), checkin.HoraInicio) AS hora_inicio_checkin,
    CONVERT(TIME(0), checkin.HoraFim) AS hora_fim_checkout,

    CASE 
    WHEN checkin.HoraInicio IS NOT NULL 
    AND checkin.HoraFim IS NOT NULL
    THEN DATEDIFF(MINUTE, checkin.HoraInicio, checkin.HoraFim)
    END AS duracao_checkin_minutos,

    acao_nv.desc_motivo AS acao_nao_venda,
    motivo_nv.descricao AS motivo_nao_venda,

    CAST(evento_lib.dt_separacao AS DATE) AS data_liberacao_pedido,
    CAST(evento_lib.dt_separacao AS TIME(0)) AS hora_liberacao_pedido,

    pedido.nu_ped AS numero_pedido,

    tp_ped.descricao AS tipo_pedido,
    situacao_ped.descricao AS situacao_pedido,

    nf.nota_fiscal,

    venda.prz_medio AS prazo_venda_cliente,
    cli_emp.prz_medio_max AS prazo_cadastro_cliente,

    CAST(evento_lib.dt_entrega AS DATE) AS data_entrega,
    CAST(evento_lib.dt_entrega AS TIME(0)) AS hora_entrega

FROM bronze.venda_g4_distribuidora venda

INNER JOIN bronze.pedido_venda_g4_distribuidora pedido
    ON pedido.nu_ped = venda.nu_ped
    AND pedido.cd_emp = venda.cd_emp

INNER JOIN silver.dim_calendario cal
    ON cal.data = venda.dt_ped

LEFT JOIN bronze.cliente_g4_distribuidora cli
    ON cli.cd_clien = venda.cd_clien

LEFT JOIN bronze.cliente_empresa_g4_distribuidora cli_emp
    ON cli_emp.cd_clien = cli.cd_clien

LEFT JOIN bronze.end_cliente_g4_distribuidora end_cliente
    ON end_cliente.cd_clien = cli.cd_clien
    AND end_cliente.tp_end = 'EN'

LEFT JOIN silver.dim_grupo_cliente_g4_distribuidora grupocli
    ON grupocli.cod_grupo_cliente = cli.cd_grupocli COLLATE SQL_Latin1_General_CP1_CI_AI

LEFT JOIN silver.dim_ramo_atividade_g4_distribuidora ram_ativ
    ON ram_ativ.cod_ramo_atividade = cli.ram_ativ COLLATE SQL_Latin1_General_CP1_CI_AI

INNER JOIN silver.dim_prod_g4_distribuidora prod
    ON prod.cod_prod = pedido.cd_prod

LEFT JOIN bronze.custo_prod_g4_distribuidora custo_prod
    ON custo_prod.cd_prod = pedido.cd_prod
    AND custo_prod.cd_emp = venda.cd_emp
    AND custo_prod.tp_custo = 'CMP'

LEFT JOIN bronze.preco_tabela_prod_g4_distribuidora preco_tabela
    ON preco_tabela.cd_prod = pedido.cd_prod
    AND preco_tabela.cd_tabela = venda.cd_tabela

LEFT JOIN bronze.kit_promocao_g4_distribuidora kit_prom
    ON kit_prom.seq_kit = pedido.seq_kit

LEFT JOIN bronze.unidade_prod_descricao_g4_distribuidora unid_desc
    ON unid_desc.unidade = pedido.unid_vda

LEFT JOIN silver.dim_fabric_g4_distribuidora fabric
    ON fabric.sk_fabricante = prod.sk_fabric

LEFT JOIN silver.dim_linha_g4_distribuidora linha
    ON linha.sk_linha = prod.sk_linha

LEFT JOIN silver.dim_categ_prod_g4_distribuidora categ_prod
    ON categ_prod.sk_categoria = linha.sk_categ

LEFT JOIN silver.dim_secao_g4_distribuidora secao
    ON secao.sk_secao = linha.sk_secao

INNER JOIN silver.dim_vendedor_g4_distribuidora vendedor
    ON vendedor.cod_vendedor = venda.cd_vend COLLATE SQL_Latin1_General_CP1_CI_AI

LEFT JOIN silver.dim_equipe_g4_distribuidora equipe
    ON equipe.cod_equipe = vendedor.cod_equipe

LEFT JOIN silver.dim_vendedor_g4_distribuidora supervisor
    ON supervisor.sk_vendedor = equipe.sk_supervisor

LEFT JOIN silver.dim_gerencia_g4_distribuidora gerencia
    ON gerencia.sk_gerencia = equipe.sk_gerencia

LEFT JOIN silver.dim_vendedor_g4_distribuidora gerente
    ON gerente.sk_vendedor = gerencia.sk_gerente

LEFT JOIN checkin
    ON checkin.CodigoVendedor COLLATE SQL_Latin1_General_CP1_CI_AI = vendedor.cod_vendedor
    AND checkin.CodigoCliente = cli.cd_clien
    AND checkin.Data = cal.data

LEFT JOIN evento_lib
    ON evento_lib.nu_ped = venda.nu_ped
    AND evento_lib.cd_clien = venda.cd_clien

LEFT JOIN nf
    ON nf.nu_ped = venda.nu_ped

LEFT JOIN acao_nv
    ON acao_nv.cd_clien = venda.cd_clien
    AND acao_nv.cd_vend = venda.cd_vend COLLATE SQL_Latin1_General_CP1_CI_AI

LEFT JOIN bronze.motivo_nao_venda_g4_distribuidora motivo_nv
    ON motivo_nv.cd_resultado = acao_nv.cd_motivo

LEFT JOIN silver.dim_tipo_pedido_g4_distribuidora tp_ped
    ON tp_ped.cod_tipo_pedido = venda.tp_ped COLLATE SQL_Latin1_General_CP1_CI_AI

LEFT JOIN silver.dim_situacao_pedido_g4_distribuidora situacao_ped
    ON situacao_ped.cod_situacao_pedido = pedido.situacao COLLATE SQL_Latin1_General_CP1_CI_AI

LEFT JOIN bronze.origem_pedido_g4_distribuidora origem_ped
    ON origem_ped.OrigemPedidoVenda = venda.origem_pedido
```
