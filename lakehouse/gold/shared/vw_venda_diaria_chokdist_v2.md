<!-- generated: lakehouse-object -->
# gold.vw_venda_diaria_chokdist_v2

- Tipo: `VIEW`
- Industria: `shared`
- Origem: `database:GA_DATALAKE`
- PKs: Nao identificado no banco
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | empresa | varchar(50) | False | False | False | - |
| 2 | ano | smallint | False | False | False | - |
| 3 | mes | tinyint | False | False | False | - |
| 4 | data | date | False | False | False | - |
| 5 | hora_cadastro | time(0) | True | False | False | - |
| 6 | cnpj_cpf | varchar(20) | True | False | False | - |
| 7 | cod_cliente | int | True | False | False | - |
| 8 | grupo_cliente | varchar(60) | True | False | False | - |
| 9 | razao_social | varchar(80) | True | False | False | - |
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
| 20 | origem_pedido | varchar(100) | True | False | False | - |
| 21 | ean | varchar(14) | True | False | False | - |
| 22 | sku | int | True | False | False | - |
| 23 | descricao_produto | varchar(120) | True | False | False | - |
| 24 | categoria | varchar(40) | True | False | False | - |
| 25 | familia | varchar(40) | True | False | False | - |
| 26 | grupo | varchar(40) | True | False | False | - |
| 27 | fabricante | varchar(40) | True | False | False | - |
| 28 | peso_liq_unid | decimal(14,3) | True | False | False | - |
| 29 | peso_liq | numeric(7,3) | True | False | False | - |
| 30 | peso_bruto | numeric(7,3) | True | False | False | - |
| 31 | codigo_promocao | int | True | False | False | - |
| 32 | descricao_promocao | varchar(40) | True | False | False | - |
| 33 | unidade_venda | varchar(30) | True | False | False | - |
| 34 | fator_pedido | decimal(18,4) | True | False | False | - |
| 35 | qtde_vendida | decimal(13,2) | True | False | False | - |
| 36 | custo_unitario_prod | decimal(14,4) | True | False | False | - |
| 37 | preco_unitario_prod | decimal(14,4) | True | False | False | - |
| 38 | preco_tabela_cadastro | decimal(14,4) | True | False | False | - |
| 39 | valor_total_venda | decimal(16,2) | True | False | False | - |
| 40 | desconto_aplicado_prod | decimal(14,2) | True | False | False | - |
| 41 | cod_vendedor | varchar(20) | True | False | False | - |
| 42 | nome_vendedor | varchar(20) | True | False | False | - |
| 43 | cod_supervisor | varchar(20) | True | False | False | - |
| 44 | nome_supervisor | varchar(40) | True | False | False | - |
| 45 | nome_da_equipe | varchar(20) | True | False | False | - |
| 46 | cod_gerente | varchar(20) | True | False | False | - |
| 47 | nome_gerente | varchar(40) | True | False | False | - |
| 48 | nome_gerencia | varchar(40) | True | False | False | - |
| 49 | hora_inicio_checkin | time(0) | True | False | False | - |
| 50 | hora_fim_checkout | time(0) | True | False | False | - |
| 51 | duracao_checkin_minutos | int | True | False | False | - |
| 52 | acao_nao_venda | varchar(255) | True | False | False | - |
| 53 | motivo_nao_venda | varchar(255) | True | False | False | - |
| 54 | data_liberacao_pedido | date | True | False | False | - |
| 55 | hora_liberacao_pedido | time(0) | True | False | False | - |
| 56 | numero_pedido | bigint | False | False | False | - |
| 57 | tipo_pedido | varchar(30) | True | False | False | - |
| 58 | situacao_pedido | varchar(20) | True | False | False | - |
| 59 | nota_fiscal | bigint | True | False | False | - |
| 60 | prazo_venda_cliente | int | True | False | False | - |
| 61 | prazo_cadastro_cliente | int | True | False | False | - |
| 62 | data_entrega | date | True | False | False | - |
| 63 | hora_entrega | time(0) | True | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL

```sql

CREATE   VIEW gold.vw_venda_diaria_chokdist_v2
AS
SELECT
    f.empresa,

    cal.ano,
    cal.mes,
    f.data_movimento AS data,

    f.hora_cadastro,

    f.cnpj_cpf,
    f.cod_cliente,

    grupocli.descricao AS grupo_cliente,
    cli.nome AS razao_social,

    end_cliente.endereco,
    end_cliente.bairro,
    end_cliente.municipio,
    end_cliente.cep,
    end_cliente.estado,
    end_cliente.cd_pais AS cod_pais,
    cli.email,

    ram_ativ.descricao AS segmento,
    end_cliente.latitude,
    end_cliente.longitude,

    f.origem_pedido,

    prod.ean,
    f.sku,
    prod.descricao AS descricao_produto,

    categ_prod.descricao AS categoria,
    linha.descricao AS familia,
    secao.descricao AS grupo,
    fabric.descricao AS fabricante,

    f.peso_liq_unid,
    prod.peso_liq,
    prod.peso_bruto,

    f.codigo_promocao,
    kit_prom.descricao AS descricao_promocao,

    f.unidade_venda,

    f.fator_pedido,
    f.qtde_vendida,

    f.custo_unitario_prod,
    f.preco_unitario_prod,
    f.preco_tabela_cadastro,
    f.valor_total_venda,

    f.desconto_aplicado_prod,

    f.cod_vendedor,
    vendedor.nome_guerra AS nome_vendedor,

    f.cod_supervisor,
    supervisor.nome AS nome_supervisor,

    equipe.descricao AS nome_da_equipe,

    f.cod_gerente,
    gerente.nome AS nome_gerente,

    gerencia.descricao AS nome_gerencia,

    f.hora_inicio_checkin,
    f.hora_fim_checkout,

    f.duracao_checkin_minutos,

    f.acao_nao_venda,
    f.motivo_nao_venda,

    f.data_liberacao_pedido,
    f.hora_liberacao_pedido,

    f.numero_pedido,

    tp_ped.descricao AS tipo_pedido,
    situacao_ped.descricao AS situacao_pedido,

    f.nota_fiscal,

    f.prazo_venda_cliente,
    f.prazo_cadastro_cliente,

    f.data_entrega,
    f.hora_entrega

FROM gold.fact_venda_diaria_chokdist f

INNER JOIN silver.dim_calendario cal
    ON cal.sk_calendario = f.sk_calendario

LEFT JOIN silver.dim_cliente_chokdistribuidora cli
    ON cli.sk_cliente = f.sk_cliente

LEFT JOIN bronze.end_cliente_chokdistribuidora end_cliente
    ON end_cliente.cd_clien = cli.cod_cliente
   AND end_cliente.tp_end = 'EN'

LEFT JOIN silver.dim_grupo_cliente_chokdistribuidora grupocli
    ON grupocli.sk_grupo_cliente = f.sk_grupo_cliente

LEFT JOIN silver.dim_ramo_atividade_chokdistribuidora ram_ativ
    ON ram_ativ.sk_ramo_atividade = f.sk_ramo_atividade

LEFT JOIN silver.dim_prod_chokdistribuidora prod
    ON prod.sk_prod = f.sk_prod

LEFT JOIN silver.dim_fabric_chokdistribuidora fabric
    ON fabric.sk_fabricante = f.sk_fabricante

LEFT JOIN silver.dim_linha_chokdistribuidora linha
    ON linha.sk_linha = f.sk_linha

LEFT JOIN silver.dim_categ_prod_chokdistribuidora categ_prod
    ON categ_prod.sk_categoria = f.sk_categoria

LEFT JOIN silver.dim_secao_chokdistribuidora secao
    ON secao.sk_secao = f.sk_secao

LEFT JOIN bronze.kit_promocao_chokdistribuidora kit_prom
    ON kit_prom.seq_kit = f.codigo_promocao

LEFT JOIN silver.dim_vendedor_chokdistribuidora vendedor
    ON vendedor.sk_vendedor = f.sk_vendedor

LEFT JOIN silver.dim_vendedor_chokdistribuidora supervisor
    ON supervisor.sk_vendedor = f.sk_supervisor

LEFT JOIN silver.dim_equipe_chokdistribuidora equipe
    ON equipe.sk_equipe = f.sk_equipe

LEFT JOIN silver.dim_vendedor_chokdistribuidora gerente
    ON gerente.sk_vendedor = f.sk_gerente

LEFT JOIN silver.dim_gerencia_chokdistribuidora gerencia
    ON gerencia.sk_gerencia = f.sk_gerencia

LEFT JOIN silver.dim_tipo_pedido_chokdistribuidora tp_ped
    ON tp_ped.sk_tipo_pedido = f.sk_tipo_pedido

LEFT JOIN silver.dim_situacao_pedido_chokdistribuidora situacao_ped
    ON situacao_ped.sk_situacao_pedido = f.sk_situacao_pedido;
```
