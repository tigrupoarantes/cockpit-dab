<!-- generated: lakehouse-object -->
# silver.fato_venda_item_chokdistribuidora

- Tipo: `TABLE`
- Industria: `chokdistribuidora`
- Origem: `database:GA_DATALAKE`
- PKs: sk_venda_item
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | sk_venda_item | bigint | False | True | False | - |
| 2 | sk_empresa | tinyint | False | False | False | - |
| 3 | sk_data_pedido | int | False | False | False | - |
| 4 | sk_data_faturamento | int | True | False | False | - |
| 5 | sk_cliente | int | False | False | False | - |
| 6 | sk_produto | int | False | False | False | - |
| 7 | sk_vendedor | int | False | False | False | - |
| 8 | sk_tipo_pedido | int | False | False | False | - |
| 9 | sk_situacao_pedido | int | False | False | False | - |
| 10 | sk_promocao | int | True | False | False | - |
| 11 | numero_pedido | int | False | False | False | - |
| 12 | sequencia_item | int | False | False | False | - |
| 13 | quantidade_estoque | decimal(19,6) | True | False | False | - |
| 14 | quantidade_venda | decimal(19,6) | True | False | False | - |
| 15 | quantidade_convertida | decimal(19,6) | True | False | False | - |
| 16 | valor_bruto | decimal(19,4) | True | False | False | - |
| 17 | valor_desconto | decimal(19,4) | True | False | False | ((0)) |
| 18 | valor_desconto_fin | decimal(19,4) | True | False | False | ((0)) |
| 19 | valor_liquido | decimal(19,4) | True | False | False | - |
| 20 | custo_cmp_unitario | decimal(19,6) | True | False | False | - |
| 21 | custo_cmp_total | decimal(19,4) | True | False | False | - |
| 22 | margem_bruta_valor | decimal(19,4) | True | False | False | - |
| 23 | margem_bruta_percentual | decimal(19,8) | True | False | False | - |
| 24 | valor_ipi | decimal(19,4) | True | False | False | ((0)) |
| 25 | valor_icms_st | decimal(19,4) | True | False | False | ((0)) |
| 26 | valor_pis | decimal(19,4) | True | False | False | ((0)) |
| 27 | valor_cofins | decimal(19,4) | True | False | False | ((0)) |
| 28 | valor_icms_desonerado | decimal(19,4) | True | False | False | ((0)) |
| 29 | valor_frete | decimal(19,4) | True | False | False | ((0)) |
| 30 | valor_verba | decimal(19,4) | True | False | False | ((0)) |
| 31 | valor_comissao | decimal(19,4) | True | False | False | ((0)) |
| 32 | peso_bruto_total | decimal(19,6) | True | False | False | - |
| 33 | peso_liquido_total | decimal(19,6) | True | False | False | - |
| 34 | flag_bonificado | bit | True | False | False | ((0)) |
| 35 | flag_consignado | bit | True | False | False | ((0)) |
| 36 | flag_venda_casada | bit | True | False | False | ((0)) |
| 37 | dt_carga | datetime2(7) | True | False | False | (sysdatetime()) |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL Reconstruida

```sql
CREATE TABLE [silver].[fato_venda_item_chokdistribuidora] (
    [sk_venda_item] bigint IDENTITY(1,1) NOT NULL,
    [sk_empresa] tinyint NOT NULL,
    [sk_data_pedido] int NOT NULL,
    [sk_data_faturamento] int NULL,
    [sk_cliente] int NOT NULL,
    [sk_produto] int NOT NULL,
    [sk_vendedor] int NOT NULL,
    [sk_tipo_pedido] int NOT NULL,
    [sk_situacao_pedido] int NOT NULL,
    [sk_promocao] int NULL,
    [numero_pedido] int NOT NULL,
    [sequencia_item] int NOT NULL,
    [quantidade_estoque] decimal(19,6) NULL,
    [quantidade_venda] decimal(19,6) NULL,
    [quantidade_convertida] decimal(19,6) NULL,
    [valor_bruto] decimal(19,4) NULL,
    [valor_desconto] decimal(19,4) DEFAULT ((0)) NULL,
    [valor_desconto_fin] decimal(19,4) DEFAULT ((0)) NULL,
    [valor_liquido] decimal(19,4) NULL,
    [custo_cmp_unitario] decimal(19,6) NULL,
    [custo_cmp_total] decimal(19,4) NULL,
    [margem_bruta_valor] decimal(19,4) NULL,
    [margem_bruta_percentual] decimal(19,8) NULL,
    [valor_ipi] decimal(19,4) DEFAULT ((0)) NULL,
    [valor_icms_st] decimal(19,4) DEFAULT ((0)) NULL,
    [valor_pis] decimal(19,4) DEFAULT ((0)) NULL,
    [valor_cofins] decimal(19,4) DEFAULT ((0)) NULL,
    [valor_icms_desonerado] decimal(19,4) DEFAULT ((0)) NULL,
    [valor_frete] decimal(19,4) DEFAULT ((0)) NULL,
    [valor_verba] decimal(19,4) DEFAULT ((0)) NULL,
    [valor_comissao] decimal(19,4) DEFAULT ((0)) NULL,
    [peso_bruto_total] decimal(19,6) NULL,
    [peso_liquido_total] decimal(19,6) NULL,
    [flag_bonificado] bit DEFAULT ((0)) NULL,
    [flag_consignado] bit DEFAULT ((0)) NULL,
    [flag_venda_casada] bit DEFAULT ((0)) NULL,
    [dt_carga] datetime2(7) DEFAULT (sysdatetime()) NULL,
    CONSTRAINT [PK__fato_ven__4BD9872DB6EBF4D8] PRIMARY KEY ([sk_venda_item])
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
