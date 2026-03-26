<!-- generated: lakehouse-object -->
# bronze.fornec_fabric_chokdistribuidora

- Tipo: `TABLE`
- Industria: `chokdistribuidora`
- Origem: `database:GA_DATALAKE`
- PKs: Nao identificado no banco
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | cd_forn | int | False | False | False | - |
| 2 | cd_fabric | char(6) | False | False | False | - |
| 3 | principal | tinyint | True | False | False | - |
| 5 | FornFabrID | int | False | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL Reconstruida

```sql
CREATE TABLE [bronze].[fornec_fabric_chokdistribuidora] (
    [cd_forn] int NOT NULL,
    [cd_fabric] char(6) NOT NULL,
    [principal] tinyint NULL,
    [FornFabrID] int NOT NULL
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
