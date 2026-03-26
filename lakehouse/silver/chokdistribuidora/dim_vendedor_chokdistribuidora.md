<!-- generated: lakehouse-object -->
# silver.dim_vendedor_chokdistribuidora

- Tipo: `TABLE`
- Industria: `chokdistribuidora`
- Origem: `database:GA_DATALAKE`
- PKs: sk_vendedor
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | sk_vendedor | int | False | True | False | - |
| 2 | cod_vendedor | varchar(8) | False | False | False | - |
| 3 | nome | varchar(40) | False | False | False | - |
| 4 | nome_guerra | varchar(20) | True | False | False | - |
| 5 | cpf | varchar(14) | True | False | False | - |
| 6 | cod_equipe | varchar(4) | True | False | False | - |
| 7 | hash_diff | binary(32) | True | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL Reconstruida

```sql
CREATE TABLE [silver].[dim_vendedor_chokdistribuidora] (
    [sk_vendedor] int IDENTITY(1,1) NOT NULL,
    [cod_vendedor] varchar(8) NOT NULL,
    [nome] varchar(40) NOT NULL,
    [nome_guerra] varchar(20) NULL,
    [cpf] varchar(14) NULL,
    [cod_equipe] varchar(4) NULL,
    [hash_diff] binary(32) NULL,
    CONSTRAINT [pk_vendedor_chokdist] PRIMARY KEY ([sk_vendedor])
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
