<!-- generated: lakehouse-object -->
# gold.fact_venda_diaria_chokdist

- Tipo: `TABLE`
- Industria: `shared`
- Origem: `database:GA_DATALAKE`
- PKs: sk_venda_diaria
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | sk_venda_diaria | bigint | False | True | False | - |
| 2 | sk_calendario | int | False | False | False | - |
| 3 | sk_cliente | int | True | False | False | - |
| 4 | sk_grupo_cliente | int | True | False | False | - |
| 5 | sk_ramo_atividade | int | True | False | False | - |
| 6 | sk_prod | int | False | False | False | - |
| 7 | sk_fabricante | int | True | False | False | - |
| 8 | sk_linha | int | True | False | False | - |
| 9 | sk_categoria | int | True | False | False | - |
| 10 | sk_secao | int | True | False | False | - |
| 11 | sk_vendedor | int | False | False | False | - |
| 12 | sk_supervisor | int | True | False | False | - |
| 13 | sk_equipe | int | True | False | False | - |
| 14 | sk_gerente | int | True | False | False | - |
| 15 | sk_gerencia | int | True | False | False | - |
| 16 | sk_tipo_pedido | int | True | False | False | - |
| 17 | sk_situacao_pedido | int | True | False | False | - |
| 18 | empresa | varchar(50) | False | False | False | - |
| 19 | cd_emp | int | True | False | False | - |
| 20 | numero_pedido | bigint | False | False | False | - |
| 21 | id_item_pedido | int | False | False | False | - |
| 22 | nota_fiscal | bigint | True | False | False | - |
| 23 | codigo_promocao | int | True | False | False | - |
| 24 | cod_cliente | int | True | False | False | - |
| 25 | cnpj_cpf | varchar(20) | True | False | False | - |
| 26 | sku | int | True | False | False | - |
| 27 | cod_vendedor | varchar(20) | True | False | False | - |
| 28 | cod_supervisor | varchar(20) | True | False | False | - |
| 29 | cod_gerente | varchar(20) | True | False | False | - |
| 30 | origem_pedido | varchar(100) | True | False | False | - |
| 31 | unidade_venda | varchar(30) | True | False | False | - |
| 32 | data_movimento | date | False | False | False | - |
| 33 | hora_cadastro | time(0) | True | False | False | - |
| 34 | hora_inicio_checkin | time(0) | True | False | False | - |
| 35 | hora_fim_checkout | time(0) | True | False | False | - |
| 36 | data_liberacao_pedido | date | True | False | False | - |
| 37 | hora_liberacao_pedido | time(0) | True | False | False | - |
| 38 | data_entrega | date | True | False | False | - |
| 39 | hora_entrega | time(0) | True | False | False | - |
| 40 | fator_pedido | decimal(18,4) | True | False | False | - |
| 41 | qtde_vendida | decimal(13,2) | True | False | False | - |
| 42 | peso_liq_unid | decimal(14,3) | True | False | False | - |
| 43 | custo_unitario_prod | decimal(14,4) | True | False | False | - |
| 44 | preco_unitario_prod | decimal(14,4) | True | False | False | - |
| 45 | preco_tabela_cadastro | decimal(14,4) | True | False | False | - |
| 46 | desconto_aplicado_prod | decimal(14,2) | True | False | False | - |
| 47 | valor_total_venda | decimal(16,2) | True | False | False | - |
| 48 | prazo_venda_cliente | int | True | False | False | - |
| 49 | prazo_cadastro_cliente | int | True | False | False | - |
| 50 | duracao_checkin_minutos | int | True | False | False | - |
| 51 | acao_nao_venda | varchar(255) | True | False | False | - |
| 52 | motivo_nao_venda | varchar(255) | True | False | False | - |
| 53 | dt_inclusao | datetime2(0) | False | False | False | (sysdatetime()) |
| 54 | dt_atualizacao | datetime2(0) | True | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL Reconstruida

```sql
CREATE TABLE [gold].[fact_venda_diaria_chokdist] (
    [sk_venda_diaria] bigint IDENTITY(1,1) NOT NULL,
    [sk_calendario] int NOT NULL,
    [sk_cliente] int NULL,
    [sk_grupo_cliente] int NULL,
    [sk_ramo_atividade] int NULL,
    [sk_prod] int NOT NULL,
    [sk_fabricante] int NULL,
    [sk_linha] int NULL,
    [sk_categoria] int NULL,
    [sk_secao] int NULL,
    [sk_vendedor] int NOT NULL,
    [sk_supervisor] int NULL,
    [sk_equipe] int NULL,
    [sk_gerente] int NULL,
    [sk_gerencia] int NULL,
    [sk_tipo_pedido] int NULL,
    [sk_situacao_pedido] int NULL,
    [empresa] varchar(50) NOT NULL,
    [cd_emp] int NULL,
    [numero_pedido] bigint NOT NULL,
    [id_item_pedido] int NOT NULL,
    [nota_fiscal] bigint NULL,
    [codigo_promocao] int NULL,
    [cod_cliente] int NULL,
    [cnpj_cpf] varchar(20) NULL,
    [sku] int NULL,
    [cod_vendedor] varchar(20) NULL,
    [cod_supervisor] varchar(20) NULL,
    [cod_gerente] varchar(20) NULL,
    [origem_pedido] varchar(100) NULL,
    [unidade_venda] varchar(30) NULL,
    [data_movimento] date NOT NULL,
    [hora_cadastro] time(0) NULL,
    [hora_inicio_checkin] time(0) NULL,
    [hora_fim_checkout] time(0) NULL,
    [data_liberacao_pedido] date NULL,
    [hora_liberacao_pedido] time(0) NULL,
    [data_entrega] date NULL,
    [hora_entrega] time(0) NULL,
    [fator_pedido] decimal(18,4) NULL,
    [qtde_vendida] decimal(13,2) NULL,
    [peso_liq_unid] decimal(14,3) NULL,
    [custo_unitario_prod] decimal(14,4) NULL,
    [preco_unitario_prod] decimal(14,4) NULL,
    [preco_tabela_cadastro] decimal(14,4) NULL,
    [desconto_aplicado_prod] decimal(14,2) NULL,
    [valor_total_venda] decimal(16,2) NULL,
    [prazo_venda_cliente] int NULL,
    [prazo_cadastro_cliente] int NULL,
    [duracao_checkin_minutos] int NULL,
    [acao_nao_venda] varchar(255) NULL,
    [motivo_nao_venda] varchar(255) NULL,
    [dt_inclusao] datetime2(0) DEFAULT (sysdatetime()) NOT NULL,
    [dt_atualizacao] datetime2(0) NULL,
    CONSTRAINT [pk_fact_venda_diaria_chokdist] PRIMARY KEY ([sk_venda_diaria])
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
