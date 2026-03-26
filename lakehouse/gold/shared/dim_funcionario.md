<!-- generated: lakehouse-object -->
# gold.dim_funcionario

- Tipo: `TABLE`
- Industria: `shared`
- Origem: `database:GA_DATALAKE`
- PKs: sk_funcionario
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | sk_funcionario | int | False | True | False | - |
| 2 | cod_funcionario | int | False | False | False | - |
| 3 | nome_funcionario | varchar(60) | False | False | False | - |
| 4 | cpf | varchar(11) | False | False | False | - |
| 5 | sk_empresa | smallint | True | False | False | - |
| 6 | data_admissao | date | True | False | False | - |
| 7 | cod_contabilizacao | int | True | False | False | - |
| 8 | sk_cargo | int | True | False | False | - |
| 9 | sk_categoria | int | True | False | False | - |
| 10 | sk_departamento | int | True | False | False | - |
| 11 | sk_funcao | int | True | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL Reconstruida

```sql
CREATE TABLE [gold].[dim_funcionario] (
    [sk_funcionario] int IDENTITY(1,1) NOT NULL,
    [cod_funcionario] int NOT NULL,
    [nome_funcionario] varchar(60) NOT NULL,
    [cpf] varchar(11) NOT NULL,
    [sk_empresa] smallint NULL,
    [data_admissao] date NULL,
    [cod_contabilizacao] int NULL,
    [sk_cargo] int NULL,
    [sk_categoria] int NULL,
    [sk_departamento] int NULL,
    [sk_funcao] int NULL,
    CONSTRAINT [pk_dim_funcionario] PRIMARY KEY ([sk_funcionario])
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
