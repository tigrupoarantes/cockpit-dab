<!-- generated: lakehouse-object -->
# bronze.pedido_parcela_chokdistribuidora

- Tipo: `TABLE`
- Industria: `chokdistribuidora`
- Origem: `database:GA_DATALAKE`
- PKs: Nao identificado no banco
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | cd_emp | int | False | False | False | - |
| 2 | nu_ped | int | False | False | False | - |
| 3 | seq_ped_parc | smallint | False | False | False | - |
| 4 | tp_tit | char(2) | True | False | False | - |
| 5 | dt_parcela | smalldatetime | False | False | False | - |
| 6 | vl_parcela | numeric(13,2) | False | False | False | - |
| 7 | DtParcelaSugerida | datetime | True | False | False | - |
| 8 | PedParcID | int | False | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL Reconstruida

```sql
CREATE TABLE [bronze].[pedido_parcela_chokdistribuidora] (
    [cd_emp] int NOT NULL,
    [nu_ped] int NOT NULL,
    [seq_ped_parc] smallint NOT NULL,
    [tp_tit] char(2) NULL,
    [dt_parcela] smalldatetime NOT NULL,
    [vl_parcela] numeric(13,2) NOT NULL,
    [DtParcelaSugerida] datetime NULL,
    [PedParcID] int NOT NULL
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
