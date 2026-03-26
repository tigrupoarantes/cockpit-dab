<!-- generated: lakehouse-object -->
# silver.dim_categ_prod_g4_distribuidora

- Tipo: `TABLE`
- Industria: `g4distribuidora`
- Origem: `database:GA_DATALAKE`
- PKs: sk_categoria
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | sk_categoria | int | False | True | False | - |
| 2 | cod_categoria | varchar(4) | False | False | False | - |
| 3 | descricao | varchar(40) | False | False | False | - |
| 4 | sigla | varchar(6) | True | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL Reconstruida

```sql
CREATE TABLE [silver].[dim_categ_prod_g4_distribuidora] (
    [sk_categoria] int IDENTITY(1,1) NOT NULL,
    [cod_categoria] varchar(4) NOT NULL,
    [descricao] varchar(40) NOT NULL,
    [sigla] varchar(6) NULL,
    CONSTRAINT [pk_categ_g4dist] PRIMARY KEY ([sk_categoria])
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
