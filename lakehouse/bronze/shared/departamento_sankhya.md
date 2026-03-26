<!-- generated: lakehouse-object -->
# bronze.departamento_sankhya

- Tipo: `TABLE`
- Industria: `shared`
- Origem: `database:GA_DATALAKE`
- PKs: Nao identificado no banco
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | CODDEP | numeric(10,0) | False | False | False | - |
| 2 | DESCRDEP | varchar(30) | False | False | False | - |
| 3 | CODEND | numeric(10,0) | True | False | False | - |
| 4 | NUMEND | varchar(6) | True | False | False | - |
| 5 | COMPLEMENTO | varchar(30) | True | False | False | - |
| 6 | CODCENCUS | numeric(10,0) | False | False | False | - |
| 7 | CODREGFIS | numeric(5,0) | True | False | False | - |
| 8 | CODDEPPAI | numeric(10,0) | False | False | False | - |
| 9 | GRAU | numeric(5,0) | False | False | False | - |
| 10 | ANALITICO | varchar(1) | False | False | False | - |
| 11 | ATIVO | varchar(1) | False | False | False | - |
| 12 | CODPARC | numeric(10,0) | False | False | False | - |
| 13 | TIPPONTO | varchar(1) | False | False | False | - |
| 14 | DIAAPURAPONTO | numeric(5,0) | False | False | False | - |
| 15 | TIPLOTACAO | numeric(5,0) | False | False | False | - |
| 16 | TPINSCPROP | numeric(5,0) | True | False | False | - |
| 17 | NRINSCPROP | varchar(14) | True | False | False | - |
| 18 | USADOESOCIAL | varchar(1) | False | False | False | - |
| 19 | NRINSCCONTRAT | varchar(14) | True | False | False | - |
| 20 | TPINSCCONTRAT | numeric(5,0) | True | False | False | - |
| 21 | CODPROJ | numeric(10,0) | True | False | False | - |
| 22 | DHALTER | datetime2(7) | False | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL Reconstruida

```sql
CREATE TABLE [bronze].[departamento_sankhya] (
    [CODDEP] numeric(10,0) NOT NULL,
    [DESCRDEP] varchar(30) NOT NULL,
    [CODEND] numeric(10,0) NULL,
    [NUMEND] varchar(6) NULL,
    [COMPLEMENTO] varchar(30) NULL,
    [CODCENCUS] numeric(10,0) NOT NULL,
    [CODREGFIS] numeric(5,0) NULL,
    [CODDEPPAI] numeric(10,0) NOT NULL,
    [GRAU] numeric(5,0) NOT NULL,
    [ANALITICO] varchar(1) NOT NULL,
    [ATIVO] varchar(1) NOT NULL,
    [CODPARC] numeric(10,0) NOT NULL,
    [TIPPONTO] varchar(1) NOT NULL,
    [DIAAPURAPONTO] numeric(5,0) NOT NULL,
    [TIPLOTACAO] numeric(5,0) NOT NULL,
    [TPINSCPROP] numeric(5,0) NULL,
    [NRINSCPROP] varchar(14) NULL,
    [USADOESOCIAL] varchar(1) NOT NULL,
    [NRINSCCONTRAT] varchar(14) NULL,
    [TPINSCCONTRAT] numeric(5,0) NULL,
    [CODPROJ] numeric(10,0) NULL,
    [DHALTER] datetime2(7) NOT NULL
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
