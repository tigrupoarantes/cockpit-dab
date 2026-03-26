<!-- generated: lakehouse-object -->
# silver.dim_secao_chokdistribuidora

- Tipo: `TABLE`
- Industria: `chokdistribuidora`
- Origem: `database:GA_DATALAKE`
- PKs: sk_secao
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | sk_secao | int | False | True | False | - |
| 2 | cod_secao | varchar(8) | False | False | False | - |
| 3 | descricao | varchar(40) | False | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL Reconstruida

```sql
CREATE TABLE [silver].[dim_secao_chokdistribuidora] (
    [sk_secao] int IDENTITY(1,1) NOT NULL,
    [cod_secao] varchar(8) NOT NULL,
    [descricao] varchar(40) NOT NULL,
    CONSTRAINT [pk_secao_chokdist] PRIMARY KEY ([sk_secao])
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
