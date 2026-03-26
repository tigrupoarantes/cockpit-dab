<!-- generated: lakehouse-object -->
# silver.dim_cliente_chokdistribuidora

- Tipo: `TABLE`
- Industria: `chokdistribuidora`
- Origem: `database:GA_DATALAKE`
- PKs: sk_cliente
- Relacionamentos: 2

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | sk_cliente | int | False | True | False | - |
| 2 | sk_segmento | int | True | False | False | - |
| 3 | sk_grupo_cliente | int | True | False | False | - |
| 4 | cod_cliente | int | False | False | False | - |
| 5 | nome | varchar(80) | False | False | False | - |
| 6 | nome_responsavel | varchar(40) | True | False | False | - |
| 7 | cnpj_cpf | varchar(14) | True | False | False | - |
| 8 | dt_cadastro | smalldatetime | True | False | False | - |
| 9 | email | varchar(80) | True | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| fk_cliente_chokdist_grupo | sk_grupo_cliente | silver.dim_grupo_cliente_chokdistribuidora.sk_grupo_cliente |
| fk_cliente_chokdist_segmento | sk_segmento | silver.dim_ramo_atividade_chokdistribuidora.sk_ramo_atividade |

## DDL Reconstruida

```sql
CREATE TABLE [silver].[dim_cliente_chokdistribuidora] (
    [sk_cliente] int IDENTITY(1,1) NOT NULL,
    [sk_segmento] int NULL,
    [sk_grupo_cliente] int NULL,
    [cod_cliente] int NOT NULL,
    [nome] varchar(80) NOT NULL,
    [nome_responsavel] varchar(40) NULL,
    [cnpj_cpf] varchar(14) NULL,
    [dt_cadastro] smalldatetime NULL,
    [email] varchar(80) NULL,
    CONSTRAINT [pk_cliente_chokdist] PRIMARY KEY ([sk_cliente])
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
