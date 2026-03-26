<!-- generated: lakehouse-object -->
# silver.dim_empresa

- Tipo: `TABLE`
- Industria: `shared`
- Origem: `database:GA_DATALAKE`
- PKs: sk_empresa
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | sk_empresa | smallint | False | True | False | - |
| 2 | cod_empresa | smallint | False | False | False | - |
| 3 | cnpj | varchar(14) | False | False | False | - |
| 4 | razao_social | varchar(40) | False | False | False | - |
| 5 | nome_fantasia | varchar(40) | True | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL Reconstruida

```sql
CREATE TABLE [silver].[dim_empresa] (
    [sk_empresa] smallint IDENTITY(1,1) NOT NULL,
    [cod_empresa] smallint NOT NULL,
    [cnpj] varchar(14) NOT NULL,
    [razao_social] varchar(40) NOT NULL,
    [nome_fantasia] varchar(40) NULL,
    CONSTRAINT [pk_empresa] PRIMARY KEY ([sk_empresa])
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
