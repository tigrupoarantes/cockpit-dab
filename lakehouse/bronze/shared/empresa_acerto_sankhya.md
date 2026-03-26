<!-- generated: lakehouse-object -->
# bronze.empresa_acerto_sankhya

- Tipo: `TABLE`
- Industria: `shared`
- Origem: `database:GA_DATALAKE`
- PKs: Nao identificado no banco
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | CODEMP | numeric(5,0) | False | False | False | - |
| 2 | CNPJ | varchar(14) | False | False | False | - |
| 3 | ARQUIVO | varchar(255) | True | False | False | - |
| 4 | NOME | varchar(255) | True | False | False | - |
| 5 | EMISSOR | varchar(255) | True | False | False | - |
| 6 | CIDADE | varchar(255) | True | False | False | - |
| 7 | ESTADO | varchar(255) | True | False | False | - |
| 8 | DTVALINI | datetime2(7) | True | False | False | - |
| 9 | DTVALFIM | datetime2(7) | True | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL Reconstruida

```sql
CREATE TABLE [bronze].[empresa_acerto_sankhya] (
    [CODEMP] numeric(5,0) NOT NULL,
    [CNPJ] varchar(14) NOT NULL,
    [ARQUIVO] varchar(255) NULL,
    [NOME] varchar(255) NULL,
    [EMISSOR] varchar(255) NULL,
    [CIDADE] varchar(255) NULL,
    [ESTADO] varchar(255) NULL,
    [DTVALINI] datetime2(7) NULL,
    [DTVALFIM] datetime2(7) NULL
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
