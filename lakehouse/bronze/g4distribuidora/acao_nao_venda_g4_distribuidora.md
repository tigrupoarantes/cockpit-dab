<!-- generated: lakehouse-object -->
# bronze.acao_nao_venda_g4_distribuidora

- Tipo: `TABLE`
- Industria: `g4distribuidora`
- Origem: `database:GA_DATALAKE`
- PKs: Nao identificado no banco
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | cd_clien | int | True | False | False | - |
| 2 | cd_motivo | char(8) | True | False | False | - |
| 3 | desc_motivo | varchar(250) | True | False | False | - |
| 4 | data | smalldatetime | True | False | False | - |
| 5 | cd_vend | char(8) | True | False | False | - |
| 6 | cd_texto | int | True | False | False | - |
| 7 | seq | int | False | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL Reconstruida

```sql
CREATE TABLE [bronze].[acao_nao_venda_g4_distribuidora] (
    [cd_clien] int NULL,
    [cd_motivo] char(8) NULL,
    [desc_motivo] varchar(250) NULL,
    [data] smalldatetime NULL,
    [cd_vend] char(8) NULL,
    [cd_texto] int NULL,
    [seq] int NOT NULL
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
