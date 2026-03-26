<!-- generated: lakehouse-object -->
# silver.dim_grupo_cliente_g4_distribuidora

- Tipo: `TABLE`
- Industria: `g4distribuidora`
- Origem: `database:GA_DATALAKE`
- PKs: sk_grupo_cliente
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | sk_grupo_cliente | int | False | True | False | - |
| 2 | cod_grupo_cliente | varchar(10) | False | False | False | - |
| 3 | descricao | varchar(60) | False | False | False | - |
| 4 | vl_limite_credito | numeric(12,2) | True | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL Reconstruida

```sql
CREATE TABLE [silver].[dim_grupo_cliente_g4_distribuidora] (
    [sk_grupo_cliente] int IDENTITY(1,1) NOT NULL,
    [cod_grupo_cliente] varchar(10) NOT NULL,
    [descricao] varchar(60) NOT NULL,
    [vl_limite_credito] numeric(12,2) NULL,
    CONSTRAINT [pk_grupo_cliente_g4dist] PRIMARY KEY ([sk_grupo_cliente])
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
