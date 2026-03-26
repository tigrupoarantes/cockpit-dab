<!-- generated: lakehouse-object -->
# bronze.situacao_pedido_g4_distribuidora

- Tipo: `TABLE`
- Industria: `g4distribuidora`
- Origem: `database:GA_DATALAKE`
- PKs: Nao identificado no banco
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | situacao | char(2) | False | False | False | - |
| 2 | descricao | varchar(20) | False | False | False | - |
| 3 | num_lock | tinyint | False | False | False | - |
| 4 | ativo | bit | False | False | False | - |
| 5 | seq | int | False | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL Reconstruida

```sql
CREATE TABLE [bronze].[situacao_pedido_g4_distribuidora] (
    [situacao] char(2) NOT NULL,
    [descricao] varchar(20) NOT NULL,
    [num_lock] tinyint NOT NULL,
    [ativo] bit NOT NULL,
    [seq] int NOT NULL
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
