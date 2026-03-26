<!-- generated: lakehouse-object -->
# silver.dim_evento

- Tipo: `TABLE`
- Industria: `shared`
- Origem: `database:GA_DATALAKE`
- PKs: sk_evento
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | sk_evento | int | False | True | False | - |
| 2 | cod_evento | int | False | False | False | - |
| 3 | nome_evento | varchar(100) | False | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL Reconstruida

```sql
CREATE TABLE [silver].[dim_evento] (
    [sk_evento] int IDENTITY(1,1) NOT NULL,
    [cod_evento] int NOT NULL,
    [nome_evento] varchar(100) NOT NULL,
    CONSTRAINT [pk_evento] PRIMARY KEY ([sk_evento])
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
