<!-- generated: lakehouse-object -->
# silver.dim_endereco_cliente_g4_distribuidora

- Tipo: `TABLE`
- Industria: `g4distribuidora`
- Origem: `database:GA_DATALAKE`
- PKs: sk_endereco
- Relacionamentos: 1

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | sk_endereco | int | False | True | False | - |
| 2 | sk_cliente | int | True | False | False | - |
| 3 | tp_endereco | char(2) | True | False | False | - |
| 4 | endereco | varchar(140) | True | False | False | - |
| 5 | bairro | varchar(60) | True | False | False | - |
| 6 | municipio | varchar(60) | True | False | False | - |
| 7 | cod_municipio | int | True | False | False | - |
| 8 | cep | varchar(10) | True | False | False | - |
| 9 | estado | char(2) | True | False | False | - |
| 10 | logradouro | varchar(60) | True | False | False | - |
| 11 | numero | varchar(15) | True | False | False | - |
| 12 | cod_pais | char(3) | True | False | False | - |
| 13 | latitude | numeric(15,12) | True | False | False | - |
| 14 | longitude | numeric(15,12) | True | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| fk_endereco_cliente_g4dist_cliente | sk_cliente | silver.dim_cliente_g4_distribuidora.sk_cliente |

## DDL Reconstruida

```sql
CREATE TABLE [silver].[dim_endereco_cliente_g4_distribuidora] (
    [sk_endereco] int IDENTITY(1,1) NOT NULL,
    [sk_cliente] int NULL,
    [tp_endereco] char(2) NULL,
    [endereco] varchar(140) NULL,
    [bairro] varchar(60) NULL,
    [municipio] varchar(60) NULL,
    [cod_municipio] int NULL,
    [cep] varchar(10) NULL,
    [estado] char(2) NULL,
    [logradouro] varchar(60) NULL,
    [numero] varchar(15) NULL,
    [cod_pais] char(3) NULL,
    [latitude] numeric(15,12) NULL,
    [longitude] numeric(15,12) NULL,
    CONSTRAINT [pk_endereco_cliente_g4dist] PRIMARY KEY ([sk_endereco])
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
