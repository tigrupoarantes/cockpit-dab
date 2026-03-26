<!-- generated: lakehouse-object -->
# gold.dim_departamento

- Tipo: `TABLE`
- Industria: `shared`
- Origem: `database:GA_DATALAKE`
- PKs: sk_departamento
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | sk_departamento | int | False | True | False | - |
| 2 | cod_departamento | int | False | False | False | - |
| 3 | nome_departamento | varchar(40) | False | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL Reconstruida

```sql
CREATE TABLE [gold].[dim_departamento] (
    [sk_departamento] int IDENTITY(1,1) NOT NULL,
    [cod_departamento] int NOT NULL,
    [nome_departamento] varchar(40) NOT NULL,
    CONSTRAINT [pk_dim_departamento] PRIMARY KEY ([sk_departamento])
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
