<!-- generated: lakehouse-object -->
# silver.dim_categoria

- Tipo: `TABLE`
- Industria: `shared`
- Origem: `database:GA_DATALAKE`
- PKs: sk_categoria
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | sk_categoria | int | False | True | False | - |
| 2 | cod_categoria | int | False | False | False | - |
| 3 | nome_categoria | varchar(40) | False | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL Reconstruida

```sql
CREATE TABLE [silver].[dim_categoria] (
    [sk_categoria] int IDENTITY(1,1) NOT NULL,
    [cod_categoria] int NOT NULL,
    [nome_categoria] varchar(40) NOT NULL,
    CONSTRAINT [pk_categoria] PRIMARY KEY ([sk_categoria])
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
