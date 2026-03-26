<!-- generated: lakehouse-object -->
# bronze.cargo_sankhya

- Tipo: `TABLE`
- Industria: `shared`
- Origem: `database:GA_DATALAKE`
- PKs: Nao identificado no banco
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | CODCARGO | numeric(10,0) | False | False | False | - |
| 2 | DESCRCARGO | varchar(100) | False | False | False | - |
| 3 | DTALTER | datetime2(7) | False | False | False | - |
| 4 | CODUSU | numeric(5,0) | True | False | False | - |
| 5 | CODCBO | numeric(10,0) | True | False | False | - |
| 6 | RESPONSABILIDADES | varchar(4000) | True | False | False | - |
| 7 | OBS | varchar(4000) | True | False | False | - |
| 8 | ATIVO | varchar(1) | False | False | False | - |
| 9 | CODGRUPOCARGO | numeric(10,0) | False | False | False | - |
| 10 | CODCARREIRA | numeric(10,0) | True | False | False | - |
| 11 | CONTAGEMTEMPO | varchar(1) | False | False | False | - |
| 12 | TECNICOCIENTIFICO | varchar(1) | False | False | False | - |
| 13 | CODESCALA | numeric(10,0) | True | False | False | - |
| 14 | ORIGATIV | numeric(5,0) | False | False | False | - |
| 15 | CODNIVELINI | numeric(5,0) | True | False | False | - |
| 16 | CODNIVELFIM | numeric(5,0) | True | False | False | - |
| 17 | DEDICACAOEXC | varchar(1) | False | False | False | - |
| 18 | APOSENTAESP | varchar(1) | False | False | False | - |
| 19 | POSSUINIVEL | varchar(1) | False | False | False | - |
| 20 | ACUMCARGO | numeric(5,0) | True | False | False | - |
| 21 | CONTAGEMESP | numeric(5,0) | True | False | False | - |
| 22 | NRLEI | varchar(12) | True | False | False | - |
| 23 | DTLEI | datetime2(7) | True | False | False | - |
| 24 | SITCARGO | numeric(5,0) | True | False | False | - |
| 25 | USADOESOCIAL | varchar(1) | False | False | False | - |
| 26 | TEMPOASO | numeric(5,0) | True | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL Reconstruida

```sql
CREATE TABLE [bronze].[cargo_sankhya] (
    [CODCARGO] numeric(10,0) NOT NULL,
    [DESCRCARGO] varchar(100) NOT NULL,
    [DTALTER] datetime2(7) NOT NULL,
    [CODUSU] numeric(5,0) NULL,
    [CODCBO] numeric(10,0) NULL,
    [RESPONSABILIDADES] varchar(4000) NULL,
    [OBS] varchar(4000) NULL,
    [ATIVO] varchar(1) NOT NULL,
    [CODGRUPOCARGO] numeric(10,0) NOT NULL,
    [CODCARREIRA] numeric(10,0) NULL,
    [CONTAGEMTEMPO] varchar(1) NOT NULL,
    [TECNICOCIENTIFICO] varchar(1) NOT NULL,
    [CODESCALA] numeric(10,0) NULL,
    [ORIGATIV] numeric(5,0) NOT NULL,
    [CODNIVELINI] numeric(5,0) NULL,
    [CODNIVELFIM] numeric(5,0) NULL,
    [DEDICACAOEXC] varchar(1) NOT NULL,
    [APOSENTAESP] varchar(1) NOT NULL,
    [POSSUINIVEL] varchar(1) NOT NULL,
    [ACUMCARGO] numeric(5,0) NULL,
    [CONTAGEMESP] numeric(5,0) NULL,
    [NRLEI] varchar(12) NULL,
    [DTLEI] datetime2(7) NULL,
    [SITCARGO] numeric(5,0) NULL,
    [USADOESOCIAL] varchar(1) NOT NULL,
    [TEMPOASO] numeric(5,0) NULL
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
