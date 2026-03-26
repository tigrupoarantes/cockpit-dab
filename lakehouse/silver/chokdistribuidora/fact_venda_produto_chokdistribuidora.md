<!-- generated: lakehouse-object -->
# silver.fact_venda_produto_chokdistribuidora

- Tipo: `TABLE`
- Industria: `chokdistribuidora`
- Origem: `database:GA_DATALAKE`
- PKs: sk_venda
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | sk_venda | int | False | True | False | - |
| 2 | sk_data_venda | int | True | False | False | - |
| 3 | sk_data_faturamento | int | True | False | False | - |
| 4 | sk_vendedor | int | True | False | False | - |
| 5 | sk_cliente | int | True | False | False | - |
| 6 | sk_prod | int | True | False | False | - |
| 7 | sk_situacao | int | True | False | False | - |
| 8 | sk_tipo_pedido | int | True | False | False | - |
| 9 | cod_empresa | smallint | True | False | False | - |
| 10 | num_pedido | int | True | False | False | - |
| 11 | hora_venda | time(0) | True | False | False | - |
| 12 | qtde_vendida | numeric(7,1) | True | False | False | - |
| 13 | valor_venda | numeric(10,2) | True | False | False | - |
| 14 | valor_faturado | numeric(10,2) | True | False | False | - |
| 15 | valor_icms | numeric(10,2) | True | False | False | - |
| 16 | valor_pis | numeric(10,2) | True | False | False | - |
| 17 | valor_cofins | numeric(10,2) | True | False | False | - |
| 18 | custo_produto | numeric(10,2) | True | False | False | - |
| 19 | valor_desconto_financeiro | numeric(10,2) | True | False | False | - |
| 20 | unid_prod_pedido | char(2) | True | False | False | - |
| 21 | qtde_unid_pedido | smallint | True | False | False | - |
| 22 | fator_produto | numeric(6,1) | True | False | False | - |
| 23 | numero_nf | int | True | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL Reconstruida

```sql
CREATE TABLE [silver].[fact_venda_produto_chokdistribuidora] (
    [sk_venda] int IDENTITY(1,1) NOT NULL,
    [sk_data_venda] int NULL,
    [sk_data_faturamento] int NULL,
    [sk_vendedor] int NULL,
    [sk_cliente] int NULL,
    [sk_prod] int NULL,
    [sk_situacao] int NULL,
    [sk_tipo_pedido] int NULL,
    [cod_empresa] smallint NULL,
    [num_pedido] int NULL,
    [hora_venda] time(0) NULL,
    [qtde_vendida] numeric(7,1) NULL,
    [valor_venda] numeric(10,2) NULL,
    [valor_faturado] numeric(10,2) NULL,
    [valor_icms] numeric(10,2) NULL,
    [valor_pis] numeric(10,2) NULL,
    [valor_cofins] numeric(10,2) NULL,
    [custo_produto] numeric(10,2) NULL,
    [valor_desconto_financeiro] numeric(10,2) NULL,
    [unid_prod_pedido] char(2) NULL,
    [qtde_unid_pedido] smallint NULL,
    [fator_produto] numeric(6,1) NULL,
    [numero_nf] int NULL,
    CONSTRAINT [pk_venda_chokdist] PRIMARY KEY ([sk_venda])
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
