<!-- generated: lakehouse-object -->
# silver.dim_funcionario

- Tipo: `TABLE`
- Industria: `shared`
- Origem: `database:GA_DATALAKE`
- PKs: sk_funcionario
- Relacionamentos: 5

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | sk_funcionario | int | False | True | False | - |
| 2 | sk_empresa | smallint | True | False | False | - |
| 3 | sk_cargo | int | True | False | False | - |
| 4 | sk_categoria | int | True | False | False | - |
| 5 | sk_departamento | int | True | False | False | - |
| 6 | sk_funcao | int | True | False | False | - |
| 7 | cod_funcionario | int | False | False | False | - |
| 8 | nome_funcionario | varchar(60) | False | False | False | - |
| 9 | cpf | varchar(11) | False | False | False | - |
| 10 | email | varchar(100) | True | False | False | - |
| 11 | data_nascimento | date | True | False | False | - |
| 12 | cod_contabilizacao | int | True | False | False | - |
| 13 | data_admissao | date | True | False | False | - |
| 14 | data_demissao | date | True | False | False | - |
| 15 | sexo | char(1) | True | False | False | - |
| 16 | estado_civil | tinyint | True | False | False | - |
| 17 | nivel_escolaridade | tinyint | True | False | False | - |
| 18 | primeiro_emprego | bit | True | False | False | - |
| 19 | deficiente_fisico | bit | True | False | False | - |
| 20 | situacao | tinyint | True | False | False | - |
| 21 | hash_diff | binary(32) | True | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| fk_funcionario_cargo | sk_cargo | silver.dim_cargo.sk_cargo |
| fk_funcionario_categoria | sk_categoria | silver.dim_categoria.sk_categoria |
| fk_funcionario_departamento | sk_departamento | silver.dim_departamento.sk_departamento |
| fk_funcionario_empresa | sk_empresa | silver.dim_empresa.sk_empresa |
| fk_funcionario_funcao | sk_funcao | silver.dim_funcao.sk_funcao |

## DDL Reconstruida

```sql
CREATE TABLE [silver].[dim_funcionario] (
    [sk_funcionario] int IDENTITY(1,1) NOT NULL,
    [sk_empresa] smallint NULL,
    [sk_cargo] int NULL,
    [sk_categoria] int NULL,
    [sk_departamento] int NULL,
    [sk_funcao] int NULL,
    [cod_funcionario] int NOT NULL,
    [nome_funcionario] varchar(60) NOT NULL,
    [cpf] varchar(11) NOT NULL,
    [email] varchar(100) NULL,
    [data_nascimento] date NULL,
    [cod_contabilizacao] int NULL,
    [data_admissao] date NULL,
    [data_demissao] date NULL,
    [sexo] char(1) NULL,
    [estado_civil] tinyint NULL,
    [nivel_escolaridade] tinyint NULL,
    [primeiro_emprego] bit NULL,
    [deficiente_fisico] bit NULL,
    [situacao] tinyint NULL,
    [hash_diff] binary(32) NULL,
    CONSTRAINT [pk_funcionario] PRIMARY KEY ([sk_funcionario])
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
