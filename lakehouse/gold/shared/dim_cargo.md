<!-- generated: lakehouse-object -->
# gold.dim_cargo

- Tipo: `TABLE`
- Industria: `shared`
- Origem: `database:GA_DATALAKE`
- PKs: sk_cargo
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | sk_cargo | int | False | True | False | - |
| 2 | cod_cargo | int | False | False | False | - |
| 3 | nome_cargo | varchar(40) | False | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL Reconstruida

```sql
CREATE TABLE [gold].[dim_cargo] (
    [sk_cargo] int IDENTITY(1,1) NOT NULL,
    [cod_cargo] int NOT NULL,
    [nome_cargo] varchar(40) NOT NULL,
    CONSTRAINT [pk_dim_cargo] PRIMARY KEY ([sk_cargo])
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
