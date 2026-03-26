<!-- generated: lakehouse-object -->
# silver.dim_ramo_atividade_g4_distribuidora

- Tipo: `TABLE`
- Industria: `g4distribuidora`
- Origem: `database:GA_DATALAKE`
- PKs: sk_ramo_atividade
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | sk_ramo_atividade | int | False | True | False | - |
| 2 | cod_ramo_atividade | varchar(4) | False | False | False | - |
| 3 | descricao | varchar(40) | False | False | False | - |
| 4 | sigla | varchar(6) | True | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL Reconstruida

```sql
CREATE TABLE [silver].[dim_ramo_atividade_g4_distribuidora] (
    [sk_ramo_atividade] int IDENTITY(1,1) NOT NULL,
    [cod_ramo_atividade] varchar(4) NOT NULL,
    [descricao] varchar(40) NOT NULL,
    [sigla] varchar(6) NULL,
    CONSTRAINT [pk_ramo_atividade_g4dist] PRIMARY KEY ([sk_ramo_atividade])
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
