<!-- generated: lakehouse-object -->
# bronze.unidade_prod_descricao_g4_distribuidora

- Tipo: `TABLE`
- Industria: `g4distribuidora`
- Origem: `database:GA_DATALAKE`
- PKs: Nao identificado no banco
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | unidade | char(2) | False | False | False | - |
| 2 | descricao | varchar(30) | False | False | False | - |
| 3 | enfardavel | bit | True | False | False | - |
| 4 | num_lock | tinyint | False | False | False | - |
| 5 | ativo | bit | True | False | False | - |
| 6 | qtde_decimais_nf | tinyint | False | False | False | - |
| 7 | cd_unidade_ean | char(3) | True | False | False | - |
| 8 | codigo_cometa | char(2) | True | False | False | - |
| 9 | CodigoTivit | char(3) | True | False | False | - |
| 10 | CodigoIms | char(3) | True | False | False | - |
| 12 | UnidadeSefazID | int | True | False | False | - |
| 13 | UnidadeSefazExteriorID | int | True | False | False | - |
| 14 | UnidadeID | int | False | False | False | - |
| 15 | UnidadeEstoquePadrao | bit | False | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL Reconstruida

```sql
CREATE TABLE [bronze].[unidade_prod_descricao_g4_distribuidora] (
    [unidade] char(2) NOT NULL,
    [descricao] varchar(30) NOT NULL,
    [enfardavel] bit NULL,
    [num_lock] tinyint NOT NULL,
    [ativo] bit NULL,
    [qtde_decimais_nf] tinyint NOT NULL,
    [cd_unidade_ean] char(3) NULL,
    [codigo_cometa] char(2) NULL,
    [CodigoTivit] char(3) NULL,
    [CodigoIms] char(3) NULL,
    [UnidadeSefazID] int NULL,
    [UnidadeSefazExteriorID] int NULL,
    [UnidadeID] int NOT NULL,
    [UnidadeEstoquePadrao] bit NOT NULL
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
