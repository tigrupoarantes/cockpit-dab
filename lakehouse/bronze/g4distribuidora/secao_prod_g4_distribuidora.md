<!-- generated: lakehouse-object -->
# bronze.secao_prod_g4_distribuidora

- Tipo: `TABLE`
- Industria: `g4distribuidora`
- Origem: `database:GA_DATALAKE`
- PKs: Nao identificado no banco
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | cd_secao | varchar(8) | False | False | False | - |
| 2 | cd_depto | varchar(8) | False | False | False | - |
| 3 | descricao | varchar(40) | False | False | False | - |
| 4 | seq | smallint | False | False | False | - |
| 5 | num_lock | tinyint | False | False | False | - |
| 6 | ativo | bit | False | False | False | - |
| 8 | SecaoID | int | False | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL Reconstruida

```sql
CREATE TABLE [bronze].[secao_prod_g4_distribuidora] (
    [cd_secao] varchar(8) NOT NULL,
    [cd_depto] varchar(8) NOT NULL,
    [descricao] varchar(40) NOT NULL,
    [seq] smallint NOT NULL,
    [num_lock] tinyint NOT NULL,
    [ativo] bit NOT NULL,
    [SecaoID] int NOT NULL
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
