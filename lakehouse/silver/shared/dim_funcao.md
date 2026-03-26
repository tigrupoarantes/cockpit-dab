<!-- generated: lakehouse-object -->
# silver.dim_funcao

- Tipo: `TABLE`
- Industria: `shared`
- Origem: `database:GA_DATALAKE`
- PKs: sk_funcao
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | sk_funcao | int | False | True | False | - |
| 2 | cod_funcao | int | False | False | False | - |
| 3 | nome_funcao | varchar(40) | False | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL Reconstruida

```sql
CREATE TABLE [silver].[dim_funcao] (
    [sk_funcao] int IDENTITY(1,1) NOT NULL,
    [cod_funcao] int NOT NULL,
    [nome_funcao] varchar(40) NOT NULL,
    CONSTRAINT [pk_funcao] PRIMARY KEY ([sk_funcao])
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
