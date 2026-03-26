<!-- generated: lakehouse-object -->
# bronze.fila_liberacao_venda_chokdistribuidora

- Tipo: `TABLE`
- Industria: `chokdistribuidora`
- Origem: `database:GA_DATALAKE`
- PKs: Nao identificado no banco
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | cd_fila | char(4) | False | False | False | - |
| 2 | des_fila | varchar(30) | False | False | False | - |
| 3 | cd_usr_resp | char(8) | False | False | False | - |
| 4 | qtde_max_pend | int | False | False | False | - |
| 5 | horas_max_pend | int | False | False | False | - |
| 6 | cd_depto | char(6) | True | False | False | - |
| 7 | producao | bit | True | False | False | - |
| 8 | etapa_ped | bit | True | False | False | - |
| 9 | tp_fila | char(2) | False | False | False | - |
| 10 | num_lock | tinyint | False | False | False | - |
| 11 | qtd_prd_desm_ped | bit | True | False | False | - |
| 12 | ativo | bit | True | False | False | - |
| 14 | FilaID | int | False | False | False | - |
| 15 | StatusPedido | varchar(100) | True | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL Reconstruida

```sql
CREATE TABLE [bronze].[fila_liberacao_venda_chokdistribuidora] (
    [cd_fila] char(4) NOT NULL,
    [des_fila] varchar(30) NOT NULL,
    [cd_usr_resp] char(8) NOT NULL,
    [qtde_max_pend] int NOT NULL,
    [horas_max_pend] int NOT NULL,
    [cd_depto] char(6) NULL,
    [producao] bit NULL,
    [etapa_ped] bit NULL,
    [tp_fila] char(2) NOT NULL,
    [num_lock] tinyint NOT NULL,
    [qtd_prd_desm_ped] bit NULL,
    [ativo] bit NULL,
    [FilaID] int NOT NULL,
    [StatusPedido] varchar(100) NULL
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
