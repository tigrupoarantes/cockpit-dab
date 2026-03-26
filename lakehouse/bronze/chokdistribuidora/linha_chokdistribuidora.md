<!-- generated: lakehouse-object -->
# bronze.linha_chokdistribuidora

- Tipo: `TABLE`
- Industria: `chokdistribuidora`
- Origem: `database:GA_DATALAKE`
- PKs: Nao identificado no banco
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | cd_linha | char(4) | False | False | False | - |
| 2 | descricao | varchar(40) | False | False | False | - |
| 3 | num_lock | tinyint | False | False | False | - |
| 4 | ativo | bit | False | False | False | - |
| 5 | limpa_volumes_nf | bit | False | False | False | - |
| 6 | envio_palm_top | bit | False | False | False | - |
| 7 | cd_categprd | char(4) | True | False | False | - |
| 8 | cd_compr | char(8) | True | False | False | - |
| 9 | cd_secao | varchar(8) | False | False | False | - |
| 10 | sigla | varchar(6) | True | False | False | - |
| 12 | LinhaID | int | False | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL Reconstruida

```sql
CREATE TABLE [bronze].[linha_chokdistribuidora] (
    [cd_linha] char(4) NOT NULL,
    [descricao] varchar(40) NOT NULL,
    [num_lock] tinyint NOT NULL,
    [ativo] bit NOT NULL,
    [limpa_volumes_nf] bit NOT NULL,
    [envio_palm_top] bit NOT NULL,
    [cd_categprd] char(4) NULL,
    [cd_compr] char(8) NULL,
    [cd_secao] varchar(8) NOT NULL,
    [sigla] varchar(6) NULL,
    [LinhaID] int NOT NULL
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
