<!-- generated: lakehouse-object -->
# bronze.unid_prod_nf_forn_chokdistribuidora

- Tipo: `TABLE`
- Industria: `chokdistribuidora`
- Origem: `database:GA_DATALAKE`
- PKs: Nao identificado no banco
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | cd_prod | int | False | False | False | - |
| 2 | cd_forn | int | False | False | False | - |
| 3 | unid_nf | char(6) | False | False | False | - |
| 4 | fator | numeric(15,6) | False | False | False | - |
| 5 | ind_relacao | char(5) | False | False | False | - |
| 6 | ativo | tinyint | True | False | False | - |
| 7 | UnidProdNfFornID | int | False | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL Reconstruida

```sql
CREATE TABLE [bronze].[unid_prod_nf_forn_chokdistribuidora] (
    [cd_prod] int NOT NULL,
    [cd_forn] int NOT NULL,
    [unid_nf] char(6) NOT NULL,
    [fator] numeric(15,6) NOT NULL,
    [ind_relacao] char(5) NOT NULL,
    [ativo] tinyint NULL,
    [UnidProdNfFornID] int NOT NULL
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
