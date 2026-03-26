<!-- generated: lakehouse-object -->
# bronze.grupo_cliente_g4_distribuidora

- Tipo: `TABLE`
- Industria: `g4distribuidora`
- Origem: `database:GA_DATALAKE`
- PKs: Nao identificado no banco
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | cd_grupocli | char(10) | False | False | False | - |
| 2 | descricao | varchar(60) | False | False | False | - |
| 3 | num_lock | tinyint | False | False | False | - |
| 4 | ativo | bit | False | False | False | - |
| 5 | seq | numeric(2,0) | True | False | False | - |
| 6 | grupo_edi | bit | False | False | False | - |
| 7 | ean_13 | varchar(13) | True | False | False | - |
| 8 | funcao_msg | char(1) | True | False | False | - |
| 9 | informa_dt_venc_titrec | bit | True | False | False | - |
| 10 | vl_lim_cred | numeric(13,2) | True | False | False | - |
| 12 | GrupocliID | int | False | False | False | - |
| 13 | GrupoEcommerce | bit | True | False | False | - |
| 14 | PaleteDedicado | bit | False | False | False | - |
| 15 | GrpEconomicoID | int | True | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL Reconstruida

```sql
CREATE TABLE [bronze].[grupo_cliente_g4_distribuidora] (
    [cd_grupocli] char(10) NOT NULL,
    [descricao] varchar(60) NOT NULL,
    [num_lock] tinyint NOT NULL,
    [ativo] bit NOT NULL,
    [seq] numeric(2,0) NULL,
    [grupo_edi] bit NOT NULL,
    [ean_13] varchar(13) NULL,
    [funcao_msg] char(1) NULL,
    [informa_dt_venc_titrec] bit NULL,
    [vl_lim_cred] numeric(13,2) NULL,
    [GrupocliID] int NOT NULL,
    [GrupoEcommerce] bit NULL,
    [PaleteDedicado] bit NOT NULL,
    [GrpEconomicoID] int NULL
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
