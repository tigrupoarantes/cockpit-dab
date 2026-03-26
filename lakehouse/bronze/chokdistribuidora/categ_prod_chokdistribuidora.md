<!-- generated: lakehouse-object -->
# bronze.categ_prod_chokdistribuidora

- Tipo: `TABLE`
- Industria: `chokdistribuidora`
- Origem: `database:GA_DATALAKE`
- PKs: Nao identificado no banco
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | cd_categprd | char(4) | False | False | False | - |
| 2 | descricao | varchar(40) | False | False | False | - |
| 3 | num_lock | tinyint | False | False | False | - |
| 4 | ativo | bit | False | False | False | - |
| 5 | envio_palm_top | bit | False | False | False | - |
| 6 | envia_ped_dir | bit | False | False | False | - |
| 7 | sigla | varchar(6) | True | False | False | - |
| 9 | CategprdID | int | False | False | False | - |
| 10 | FreezerKibon | bit | True | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL Reconstruida

```sql
CREATE TABLE [bronze].[categ_prod_chokdistribuidora] (
    [cd_categprd] char(4) NOT NULL,
    [descricao] varchar(40) NOT NULL,
    [num_lock] tinyint NOT NULL,
    [ativo] bit NOT NULL,
    [envio_palm_top] bit NOT NULL,
    [envia_ped_dir] bit NOT NULL,
    [sigla] varchar(6) NULL,
    [CategprdID] int NOT NULL,
    [FreezerKibon] bit NULL
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
