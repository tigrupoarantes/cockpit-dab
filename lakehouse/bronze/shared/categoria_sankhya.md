<!-- generated: lakehouse-object -->
# bronze.categoria_sankhya

- Tipo: `TABLE`
- Industria: `shared`
- Origem: `database:GA_DATALAKE`
- PKs: Nao identificado no banco
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | CODCATEG | numeric(5,0) | False | False | False | - |
| 2 | DESCRCATEG | varchar(40) | False | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL Reconstruida

```sql
CREATE TABLE [bronze].[categoria_sankhya] (
    [CODCATEG] numeric(5,0) NOT NULL,
    [DESCRCATEG] varchar(40) NOT NULL
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
