<!-- generated: lakehouse-object -->
# silver.dim_fornecedor_chokdistribuidora

- Tipo: `TABLE`
- Industria: `chokdistribuidora`
- Origem: `database:GA_DATALAKE`
- PKs: sk_fornecedor
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | sk_fornecedor | int | False | True | False | - |
| 2 | cod_fornecedor | int | False | False | False | - |
| 3 | descricao | varchar(120) | False | False | False | - |
| 4 | cnpj | varchar(14) | True | False | False | - |
| 5 | ramo_atividade | varchar(4) | True | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL Reconstruida

```sql
CREATE TABLE [silver].[dim_fornecedor_chokdistribuidora] (
    [sk_fornecedor] int IDENTITY(1,1) NOT NULL,
    [cod_fornecedor] int NOT NULL,
    [descricao] varchar(120) NOT NULL,
    [cnpj] varchar(14) NULL,
    [ramo_atividade] varchar(4) NULL,
    CONSTRAINT [pk_fornecedor_chokdist] PRIMARY KEY ([sk_fornecedor])
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
