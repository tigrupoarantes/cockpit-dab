<!-- generated: lakehouse-object -->
# silver.dim_fabric_g4_distribuidora

- Tipo: `TABLE`
- Industria: `g4distribuidora`
- Origem: `database:GA_DATALAKE`
- PKs: sk_fabricante
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | sk_fabricante | int | False | True | False | - |
| 2 | cod_fabric | varchar(6) | False | False | False | - |
| 3 | descricao | varchar(40) | False | False | False | - |
| 4 | sigla | varchar(3) | True | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL Reconstruida

```sql
CREATE TABLE [silver].[dim_fabric_g4_distribuidora] (
    [sk_fabricante] int IDENTITY(1,1) NOT NULL,
    [cod_fabric] varchar(6) NOT NULL,
    [descricao] varchar(40) NOT NULL,
    [sigla] varchar(3) NULL,
    CONSTRAINT [pk_fabric_g4dist] PRIMARY KEY ([sk_fabricante])
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
