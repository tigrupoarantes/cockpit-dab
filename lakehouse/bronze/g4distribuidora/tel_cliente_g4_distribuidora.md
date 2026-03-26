<!-- generated: lakehouse-object -->
# bronze.tel_cliente_g4_distribuidora

- Tipo: `TABLE`
- Industria: `g4distribuidora`
- Origem: `database:GA_DATALAKE`
- PKs: Nao identificado no banco
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | cd_clien | int | True | False | False | - |
| 2 | seq | tinyint | True | False | False | - |
| 3 | tp_tel | char(2) | True | False | False | - |
| 4 | ddd | varchar(4) | True | False | False | - |
| 5 | numero | bigint | True | False | False | - |
| 6 | compl | int | True | False | False | - |
| 8 | TelCliID | int | True | False | False | - |
| 9 | Anonimizado | bit | True | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL Reconstruida

```sql
CREATE TABLE [bronze].[tel_cliente_g4_distribuidora] (
    [cd_clien] int NULL,
    [seq] tinyint NULL,
    [tp_tel] char(2) NULL,
    [ddd] varchar(4) NULL,
    [numero] bigint NULL,
    [compl] int NULL,
    [TelCliID] int NULL,
    [Anonimizado] bit NULL
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
