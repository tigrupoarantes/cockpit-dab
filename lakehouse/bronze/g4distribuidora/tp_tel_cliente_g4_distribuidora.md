<!-- generated: lakehouse-object -->
# bronze.tp_tel_cliente_g4_distribuidora

- Tipo: `TABLE`
- Industria: `g4distribuidora`
- Origem: `database:GA_DATALAKE`
- PKs: Nao identificado no banco
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | tp_tel | char(2) | False | False | False | - |
| 2 | descricao | varchar(30) | False | False | False | - |
| 3 | num_lock | tinyint | False | False | False | - |
| 4 | ativo | bit | False | False | False | - |
| 6 | TpTelID | int | False | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL Reconstruida

```sql
CREATE TABLE [bronze].[tp_tel_cliente_g4_distribuidora] (
    [tp_tel] char(2) NOT NULL,
    [descricao] varchar(30) NOT NULL,
    [num_lock] tinyint NOT NULL,
    [ativo] bit NOT NULL,
    [TpTelID] int NOT NULL
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
