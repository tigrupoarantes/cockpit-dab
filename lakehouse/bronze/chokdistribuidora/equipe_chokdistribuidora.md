<!-- generated: lakehouse-object -->
# bronze.equipe_chokdistribuidora

- Tipo: `TABLE`
- Industria: `chokdistribuidora`
- Origem: `database:GA_DATALAKE`
- PKs: Nao identificado no banco
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | cd_emp | int | False | False | False | - |
| 2 | cd_equipe | char(4) | False | False | False | - |
| 3 | descricao | varchar(20) | False | False | False | - |
| 4 | cd_vend_sup | char(8) | True | False | False | - |
| 5 | num_lock | int | False | False | False | - |
| 6 | ativo | bit | False | False | False | - |
| 7 | telemarketing | bit | False | False | False | - |
| 8 | cd_gerencia | char(4) | False | False | False | - |
| 10 | EquipeId | int | False | False | False | - |
| 11 | GerenciaID | int | False | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL Reconstruida

```sql
CREATE TABLE [bronze].[equipe_chokdistribuidora] (
    [cd_emp] int NOT NULL,
    [cd_equipe] char(4) NOT NULL,
    [descricao] varchar(20) NOT NULL,
    [cd_vend_sup] char(8) NULL,
    [num_lock] int NOT NULL,
    [ativo] bit NOT NULL,
    [telemarketing] bit NOT NULL,
    [cd_gerencia] char(4) NOT NULL,
    [EquipeId] int NOT NULL,
    [GerenciaID] int NOT NULL
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
