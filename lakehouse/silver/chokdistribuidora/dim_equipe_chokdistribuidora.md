<!-- generated: lakehouse-object -->
# silver.dim_equipe_chokdistribuidora

- Tipo: `TABLE`
- Industria: `chokdistribuidora`
- Origem: `database:GA_DATALAKE`
- PKs: sk_equipe
- Relacionamentos: 2

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | sk_equipe | int | False | True | False | - |
| 2 | sk_supervisor | int | True | False | False | - |
| 3 | sk_gerencia | int | True | False | False | - |
| 4 | cod_equipe | varchar(4) | False | False | False | - |
| 5 | descricao | varchar(20) | False | False | False | - |
| 6 | cod_gerencia | varchar(4) | False | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| fk_equipe_chokdist_gerencia | sk_gerencia | silver.dim_gerencia_chokdistribuidora.sk_gerencia |
| fk_equipe_chokdist_supervisor | sk_supervisor | silver.dim_vendedor_chokdistribuidora.sk_vendedor |

## DDL Reconstruida

```sql
CREATE TABLE [silver].[dim_equipe_chokdistribuidora] (
    [sk_equipe] int IDENTITY(1,1) NOT NULL,
    [sk_supervisor] int NULL,
    [sk_gerencia] int NULL,
    [cod_equipe] varchar(4) NOT NULL,
    [descricao] varchar(20) NOT NULL,
    [cod_gerencia] varchar(4) NOT NULL,
    CONSTRAINT [pk_equipe_chokdist] PRIMARY KEY ([sk_equipe])
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
