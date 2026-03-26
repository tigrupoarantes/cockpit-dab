<!-- generated: lakehouse-object -->
# silver.dim_tipo_pedido_chokdistribuidora

- Tipo: `TABLE`
- Industria: `chokdistribuidora`
- Origem: `database:GA_DATALAKE`
- PKs: sk_tipo_pedido
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | sk_tipo_pedido | int | False | True | False | - |
| 2 | cod_tipo_pedido | char(2) | False | False | False | - |
| 3 | descricao | varchar(30) | False | False | False | - |
| 4 | hash_diff | binary(32) | True | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL Reconstruida

```sql
CREATE TABLE [silver].[dim_tipo_pedido_chokdistribuidora] (
    [sk_tipo_pedido] int IDENTITY(1,1) NOT NULL,
    [cod_tipo_pedido] char(2) NOT NULL,
    [descricao] varchar(30) NOT NULL,
    [hash_diff] binary(32) NULL,
    CONSTRAINT [pk_tipo_pedido_chokdist] PRIMARY KEY ([sk_tipo_pedido])
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
