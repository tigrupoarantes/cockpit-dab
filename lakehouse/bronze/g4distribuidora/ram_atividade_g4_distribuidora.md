<!-- generated: lakehouse-object -->
# bronze.ram_atividade_g4_distribuidora

- Tipo: `TABLE`
- Industria: `g4distribuidora`
- Origem: `database:GA_DATALAKE`
- PKs: Nao identificado no banco
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | ram_ativ | char(4) | False | False | False | - |
| 2 | descricao | varchar(30) | False | False | False | - |
| 3 | tp_pes | char(1) | False | False | False | - |
| 4 | num_lock | tinyint | False | False | False | - |
| 5 | ativo | bit | False | False | False | - |
| 6 | codigo_nestle | varchar(10) | True | False | False | - |
| 7 | qtde_check_out | smallint | True | False | False | - |
| 8 | cnae | char(9) | True | False | False | - |
| 9 | sigla | varchar(6) | True | False | False | - |
| 10 | qtde_check_out_ate | smallint | True | False | False | - |
| 11 | obriga_check_out_cli | bit | True | False | False | - |
| 13 | RamAtivID | int | False | False | False | - |
| 14 | RotaPlanCorDestaque | varchar(4) | True | False | False | - |
| 15 | Industria | bit | True | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL Reconstruida

```sql
CREATE TABLE [bronze].[ram_atividade_g4_distribuidora] (
    [ram_ativ] char(4) NOT NULL,
    [descricao] varchar(30) NOT NULL,
    [tp_pes] char(1) NOT NULL,
    [num_lock] tinyint NOT NULL,
    [ativo] bit NOT NULL,
    [codigo_nestle] varchar(10) NULL,
    [qtde_check_out] smallint NULL,
    [cnae] char(9) NULL,
    [sigla] varchar(6) NULL,
    [qtde_check_out_ate] smallint NULL,
    [obriga_check_out_cli] bit NULL,
    [RamAtivID] int NOT NULL,
    [RotaPlanCorDestaque] varchar(4) NULL,
    [Industria] bit NULL
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
