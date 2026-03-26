<!-- generated: lakehouse-object -->
# bronze.pag_verba_mes_sankhya

- Tipo: `TABLE`
- Industria: `shared`
- Origem: `database:GA_DATALAKE`
- PKs: Nao identificado no banco
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | CODEMP | numeric(5,0) | False | False | False | - |
| 2 | CODFUNC | numeric(10,0) | False | False | False | - |
| 3 | CODEVENTO | numeric(5,0) | False | False | False | - |
| 4 | SEQUENCIA | numeric(5,0) | False | False | False | - |
| 5 | ANO | numeric(5,0) | False | False | False | - |
| 6 | VLRJANEIRO | float | True | False | False | - |
| 7 | VLRFEVEREIRO | float | True | False | False | - |
| 8 | VLRMARCO | float | True | False | False | - |
| 9 | VLRABRIL | float | True | False | False | - |
| 10 | VLRMAIO | float | True | False | False | - |
| 11 | VLRJUNHO | float | True | False | False | - |
| 12 | VLRJULHO | float | True | False | False | - |
| 13 | VLRAGOSTO | float | True | False | False | - |
| 14 | VLRSETEMBRO | float | True | False | False | - |
| 15 | VLROUTUBRO | float | True | False | False | - |
| 16 | VLRNOVEMBRO | float | True | False | False | - |
| 17 | VLRDEZEMBRO | float | True | False | False | - |
| 18 | INDJANEIRO | float | True | False | False | - |
| 19 | INDFEVEREIRO | float | True | False | False | - |
| 20 | INDMARCO | float | True | False | False | - |
| 21 | INDABRIL | float | True | False | False | - |
| 22 | INDMAIO | float | True | False | False | - |
| 23 | INDJUNHO | float | True | False | False | - |
| 24 | INDJULHO | float | True | False | False | - |
| 25 | INDAGOSTO | float | True | False | False | - |
| 26 | INDSETEMBRO | float | True | False | False | - |
| 27 | INDOUTUBRO | float | True | False | False | - |
| 28 | INDNOVEMBRO | float | True | False | False | - |
| 29 | INDDEZEMBRO | float | True | False | False | - |
| 30 | DTALTER | datetime2(7) | False | False | False | - |
| 31 | CODUSU | numeric(5,0) | True | False | False | - |
| 32 | TIPEVENTO | numeric(5,0) | False | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL Reconstruida

```sql
CREATE TABLE [bronze].[pag_verba_mes_sankhya] (
    [CODEMP] numeric(5,0) NOT NULL,
    [CODFUNC] numeric(10,0) NOT NULL,
    [CODEVENTO] numeric(5,0) NOT NULL,
    [SEQUENCIA] numeric(5,0) NOT NULL,
    [ANO] numeric(5,0) NOT NULL,
    [VLRJANEIRO] float NULL,
    [VLRFEVEREIRO] float NULL,
    [VLRMARCO] float NULL,
    [VLRABRIL] float NULL,
    [VLRMAIO] float NULL,
    [VLRJUNHO] float NULL,
    [VLRJULHO] float NULL,
    [VLRAGOSTO] float NULL,
    [VLRSETEMBRO] float NULL,
    [VLROUTUBRO] float NULL,
    [VLRNOVEMBRO] float NULL,
    [VLRDEZEMBRO] float NULL,
    [INDJANEIRO] float NULL,
    [INDFEVEREIRO] float NULL,
    [INDMARCO] float NULL,
    [INDABRIL] float NULL,
    [INDMAIO] float NULL,
    [INDJUNHO] float NULL,
    [INDJULHO] float NULL,
    [INDAGOSTO] float NULL,
    [INDSETEMBRO] float NULL,
    [INDOUTUBRO] float NULL,
    [INDNOVEMBRO] float NULL,
    [INDDEZEMBRO] float NULL,
    [DTALTER] datetime2(7) NOT NULL,
    [CODUSU] numeric(5,0) NULL,
    [TIPEVENTO] numeric(5,0) NOT NULL
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
