<!-- generated: lakehouse-object -->
# bronze.preco_tabela_prod_g4_distribuidora

- Tipo: `TABLE`
- Industria: `g4distribuidora`
- Origem: `database:GA_DATALAKE`
- PKs: Nao identificado no banco
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | cd_tabela | char(8) | False | False | False | - |
| 2 | cd_prod | int | False | False | False | - |
| 3 | vl_preco | numeric(15,4) | True | False | False | - |
| 4 | descprom_lancprod | tinyint | True | False | False | - |
| 5 | desc_prom | numeric(7,4) | True | False | False | - |
| 6 | descprom_redcomis | tinyint | True | False | False | - |
| 7 | imprime_tab_pre | tinyint | True | False | False | - |
| 8 | dt_alt_imprime | smalldatetime | True | False | False | - |
| 9 | gera_verba | tinyint | True | False | False | - |
| 10 | desc_max_prd | numeric(7,4) | True | False | False | - |
| 11 | promocao | tinyint | True | False | False | - |
| 12 | limite_acrescimo | numeric(7,4) | True | False | False | - |
| 13 | vl_verba_unit | numeric(13,2) | True | False | False | - |
| 14 | desp_extra | numeric(7,4) | True | False | False | - |
| 15 | verba_max_deb | numeric(7,4) | True | False | False | - |
| 16 | desc_grd_bon | numeric(7,4) | True | False | False | - |
| 17 | desc_grd_com | numeric(7,4) | True | False | False | - |
| 18 | desc_grd_fin | numeric(7,4) | True | False | False | - |
| 19 | seq_grade_desc_it | smallint | True | False | False | - |
| 20 | desc_flex | numeric(7,4) | True | False | False | - |
| 21 | perc_desc_fin_auto | numeric(13,4) | True | False | False | - |
| 22 | seq_oferta | int | True | False | False | - |
| 23 | dt_ult_alteracao | smalldatetime | False | False | False | - |
| 25 | PercMgCt | numeric(7,4) | True | False | False | - |
| 26 | PercMgBr | numeric(7,4) | True | False | False | - |
| 27 | PrecoID | int | False | False | False | - |
| 28 | OrigemUltProgramaAlter | varchar(50) | True | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL Reconstruida

```sql
CREATE TABLE [bronze].[preco_tabela_prod_g4_distribuidora] (
    [cd_tabela] char(8) NOT NULL,
    [cd_prod] int NOT NULL,
    [vl_preco] numeric(15,4) NULL,
    [descprom_lancprod] tinyint NULL,
    [desc_prom] numeric(7,4) NULL,
    [descprom_redcomis] tinyint NULL,
    [imprime_tab_pre] tinyint NULL,
    [dt_alt_imprime] smalldatetime NULL,
    [gera_verba] tinyint NULL,
    [desc_max_prd] numeric(7,4) NULL,
    [promocao] tinyint NULL,
    [limite_acrescimo] numeric(7,4) NULL,
    [vl_verba_unit] numeric(13,2) NULL,
    [desp_extra] numeric(7,4) NULL,
    [verba_max_deb] numeric(7,4) NULL,
    [desc_grd_bon] numeric(7,4) NULL,
    [desc_grd_com] numeric(7,4) NULL,
    [desc_grd_fin] numeric(7,4) NULL,
    [seq_grade_desc_it] smallint NULL,
    [desc_flex] numeric(7,4) NULL,
    [perc_desc_fin_auto] numeric(13,4) NULL,
    [seq_oferta] int NULL,
    [dt_ult_alteracao] smalldatetime NOT NULL,
    [PercMgCt] numeric(7,4) NULL,
    [PercMgBr] numeric(7,4) NULL,
    [PrecoID] int NOT NULL,
    [OrigemUltProgramaAlter] varchar(50) NULL
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
