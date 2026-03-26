<!-- generated: lakehouse-object -->
# silver.dim_linha_g4_distribuidora

- Tipo: `TABLE`
- Industria: `g4distribuidora`
- Origem: `database:GA_DATALAKE`
- PKs: sk_linha
- Relacionamentos: 2

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | sk_linha | int | False | True | False | - |
| 2 | cod_linha | char(4) | False | False | False | - |
| 3 | descricao | varchar(40) | False | False | False | - |
| 4 | sigla | varchar(6) | True | False | False | - |
| 5 | sk_categ | int | True | False | False | - |
| 6 | sk_secao | int | True | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| fk_linha_g4dist_categ | sk_categ | silver.dim_categ_prod_g4_distribuidora.sk_categoria |
| fk_linha_g4dist_secao | sk_secao | silver.dim_secao_g4_distribuidora.sk_secao |

## DDL Reconstruida

```sql
CREATE TABLE [silver].[dim_linha_g4_distribuidora] (
    [sk_linha] int IDENTITY(1,1) NOT NULL,
    [cod_linha] char(4) NOT NULL,
    [descricao] varchar(40) NOT NULL,
    [sigla] varchar(6) NULL,
    [sk_categ] int NULL,
    [sk_secao] int NULL,
    CONSTRAINT [pk_linha_g4dist] PRIMARY KEY ([sk_linha])
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
