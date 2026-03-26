<!-- generated: lakehouse-object -->
# silver.dim_endereco_cliente_chokdistribuidora

- Tipo: `TABLE`
- Industria: `chokdistribuidora`
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
| 8 | cep | varchar(9) | True | False | False | - |
| 9 | estado | char(2) | True | False | False | - |
| 10 | logradouro | varchar(60) | True | False | False | - |
| 11 | numero | varchar(10) | True | False | False | - |
| 12 | cod_pais | char(3) | True | False | False | - |
| 13 | latitude | numeric(10,7) | True | False | False | - |
| 14 | longitude | numeric(10,7) | True | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| fk_endereco_cliente_chokdist_cliente | sk_cliente | silver.dim_cliente_chokdistribuidora.sk_cliente |

## DDL Reconstruida

```sql
CREATE TABLE [silver].[dim_endereco_cliente_chokdistribuidora] (
    [sk_endereco] int IDENTITY(1,1) NOT NULL,
    [sk_cliente] int NULL,
    [tp_endereco] char(2) NULL,
    [endereco] varchar(140) NULL,
    [bairro] varchar(60) NULL,
    [municipio] varchar(60) NULL,
    [cod_municipio] int NULL,
    [cep] varchar(9) NULL,
    [estado] char(2) NULL,
    [logradouro] varchar(60) NULL,
    [numero] varchar(10) NULL,
    [cod_pais] char(3) NULL,
    [latitude] numeric(10,7) NULL,
    [longitude] numeric(10,7) NULL,
    CONSTRAINT [pk_endereco_cliente_chokdist] PRIMARY KEY ([sk_endereco])
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
