<!-- generated: lakehouse-object -->
# silver.dim_gerencia_g4_distribuidora

- Tipo: `TABLE`
- Industria: `g4distribuidora`
- Origem: `database:GA_DATALAKE`
- PKs: sk_gerencia
- Relacionamentos: 1

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | sk_gerencia | int | False | True | False | - |
| 2 | sk_gerente | int | True | False | False | - |
| 3 | cod_gerencia | varchar(4) | False | False | False | - |
| 4 | descricao | varchar(40) | False | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| fk_gerencia_g4dist_gerente | sk_gerente | silver.dim_vendedor_g4_distribuidora.sk_vendedor |

## DDL Reconstruida

```sql
CREATE TABLE [silver].[dim_gerencia_g4_distribuidora] (
    [sk_gerencia] int IDENTITY(1,1) NOT NULL,
    [sk_gerente] int NULL,
    [cod_gerencia] varchar(4) NOT NULL,
    [descricao] varchar(40) NOT NULL,
    CONSTRAINT [pk_gerencia_g4dist] PRIMARY KEY ([sk_gerencia])
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
