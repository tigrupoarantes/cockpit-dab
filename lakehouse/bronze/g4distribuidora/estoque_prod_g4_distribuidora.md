<!-- generated: lakehouse-object -->
# bronze.estoque_prod_g4_distribuidora

- Tipo: `TABLE`
- Industria: `g4distribuidora`
- Origem: `database:GA_DATALAKE`
- PKs: Nao identificado no banco
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | cd_emp | int | False | False | False | - |
| 2 | cd_local | char(8) | False | False | False | - |
| 3 | cd_prod | int | False | False | False | - |
| 4 | qtde | numeric(13,4) | False | False | False | - |
| 5 | qtde_pend_pedv | numeric(13,4) | False | False | False | - |
| 6 | qtde_outros | numeric(13,4) | False | False | False | - |
| 7 | qtde_ctb | numeric(13,4) | False | False | False | - |
| 8 | qtde_pend_pedv_ctb | numeric(13,4) | False | False | False | - |
| 9 | dt_ult_movimentacao | smalldatetime | False | False | False | - |
| 10 | dt_ult_reserva | smalldatetime | False | False | False | - |
| 12 | EstoqueID | int | False | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL Reconstruida

```sql
CREATE TABLE [bronze].[estoque_prod_g4_distribuidora] (
    [cd_emp] int NOT NULL,
    [cd_local] char(8) NOT NULL,
    [cd_prod] int NOT NULL,
    [qtde] numeric(13,4) NOT NULL,
    [qtde_pend_pedv] numeric(13,4) NOT NULL,
    [qtde_outros] numeric(13,4) NOT NULL,
    [qtde_ctb] numeric(13,4) NOT NULL,
    [qtde_pend_pedv_ctb] numeric(13,4) NOT NULL,
    [dt_ult_movimentacao] smalldatetime NOT NULL,
    [dt_ult_reserva] smalldatetime NOT NULL,
    [EstoqueID] int NOT NULL
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
