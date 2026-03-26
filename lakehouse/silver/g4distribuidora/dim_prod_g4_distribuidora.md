<!-- generated: lakehouse-object -->
# silver.dim_prod_g4_distribuidora

- Tipo: `TABLE`
- Industria: `g4distribuidora`
- Origem: `database:GA_DATALAKE`
- PKs: sk_prod
- Relacionamentos: 2

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | sk_prod | int | False | True | False | - |
| 2 | cod_empresa | smallint | True | False | False | - |
| 3 | cod_prod | int | False | False | False | - |
| 4 | descricao | varchar(120) | False | False | False | - |
| 5 | sk_linha | int | True | False | False | - |
| 6 | sk_fabric | int | True | False | False | - |
| 7 | peso_liq | numeric(7,3) | True | False | False | - |
| 8 | peso_bruto | numeric(7,3) | True | False | False | - |
| 9 | ean | varchar(14) | True | False | False | - |
| 10 | fonte | varchar(20) | True | False | False | - |
| 11 | dt_cadastro | smalldatetime | True | False | False | - |
| 12 | qtde_unid_compra | int | True | False | False | - |
| 13 | unid_estoque | char(2) | True | False | False | - |
| 14 | unid_compra | char(2) | True | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| fk_produto_g4dist_fabric | sk_fabric | silver.dim_fabric_g4_distribuidora.sk_fabricante |
| fk_produto_g4dist_linha | sk_linha | silver.dim_linha_g4_distribuidora.sk_linha |

## DDL Reconstruida

```sql
CREATE TABLE [silver].[dim_prod_g4_distribuidora] (
    [sk_prod] int IDENTITY(1,1) NOT NULL,
    [cod_empresa] smallint NULL,
    [cod_prod] int NOT NULL,
    [descricao] varchar(120) NOT NULL,
    [sk_linha] int NULL,
    [sk_fabric] int NULL,
    [peso_liq] numeric(7,3) NULL,
    [peso_bruto] numeric(7,3) NULL,
    [ean] varchar(14) NULL,
    [fonte] varchar(20) NULL,
    [dt_cadastro] smalldatetime NULL,
    [qtde_unid_compra] int NULL,
    [unid_estoque] char(2) NULL,
    [unid_compra] char(2) NULL,
    CONSTRAINT [pk_produto_g4dist] PRIMARY KEY ([sk_prod])
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
