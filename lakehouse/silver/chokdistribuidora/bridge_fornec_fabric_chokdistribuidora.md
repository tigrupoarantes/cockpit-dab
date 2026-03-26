<!-- generated: lakehouse-object -->
# silver.bridge_fornec_fabric_chokdistribuidora

- Tipo: `TABLE`
- Industria: `chokdistribuidora`
- Origem: `database:GA_DATALAKE`
- PKs: sk_fornecedor, sk_fabricante
- Relacionamentos: 2

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | sk_fornecedor | int | False | False | False | - |
| 2 | sk_fabricante | int | False | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| fk_bridge_fornec_fabric_fabricante | sk_fabricante | silver.dim_fabric_chokdistribuidora.sk_fabricante |
| fk_bridge_fornec_fabric_fornecedor | sk_fornecedor | silver.dim_fornecedor_chokdistribuidora.sk_fornecedor |

## DDL Reconstruida

```sql
CREATE TABLE [silver].[bridge_fornec_fabric_chokdistribuidora] (
    [sk_fornecedor] int NOT NULL,
    [sk_fabricante] int NOT NULL,
    CONSTRAINT [pk_bridge_fornec_fabric] PRIMARY KEY ([sk_fornecedor], [sk_fabricante])
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
