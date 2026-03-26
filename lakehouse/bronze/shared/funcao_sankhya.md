<!-- generated: lakehouse-object -->
# bronze.funcao_sankhya

- Tipo: `TABLE`
- Industria: `shared`
- Origem: `database:GA_DATALAKE`
- PKs: Nao identificado no banco
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | CODFUNCAO | numeric(10,0) | False | False | False | - |
| 2 | DESCRFUNCAO | varchar(100) | False | False | False | - |
| 3 | CODCBO | numeric(10,0) | True | False | False | - |
| 4 | DTALTER | datetime2(7) | False | False | False | - |
| 5 | PODESUPEMP | varchar(1) | False | False | False | - |
| 6 | PODEENCEMP | varchar(1) | False | False | False | - |
| 7 | INCAPONT | varchar(1) | False | False | False | - |
| 8 | EMPREGADO | varchar(40) | True | False | False | - |
| 9 | CODESCALA | numeric(10,0) | True | False | False | - |
| 10 | USADOESOCIAL | varchar(1) | False | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL Reconstruida

```sql
CREATE TABLE [bronze].[funcao_sankhya] (
    [CODFUNCAO] numeric(10,0) NOT NULL,
    [DESCRFUNCAO] varchar(100) NOT NULL,
    [CODCBO] numeric(10,0) NULL,
    [DTALTER] datetime2(7) NOT NULL,
    [PODESUPEMP] varchar(1) NOT NULL,
    [PODEENCEMP] varchar(1) NOT NULL,
    [INCAPONT] varchar(1) NOT NULL,
    [EMPREGADO] varchar(40) NULL,
    [CODESCALA] numeric(10,0) NULL,
    [USADOESOCIAL] varchar(1) NOT NULL
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
