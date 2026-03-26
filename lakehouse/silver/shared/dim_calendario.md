<!-- generated: lakehouse-object -->
# silver.dim_calendario

- Tipo: `TABLE`
- Industria: `shared`
- Origem: `database:GA_DATALAKE`
- PKs: sk_calendario
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | sk_calendario | int | False | False | False | - |
| 2 | data | date | False | False | False | - |
| 3 | ano | smallint | False | False | False | - |
| 4 | mes | tinyint | False | False | False | - |
| 5 | nome_mes | varchar(15) | False | False | False | - |
| 6 | dia | tinyint | False | False | False | - |
| 7 | dia_semana | tinyint | False | False | False | - |
| 8 | nome_dia_semana | varchar(15) | False | False | False | - |
| 9 | trimestre | tinyint | False | False | False | - |
| 10 | semana_ano | tinyint | False | False | False | - |
| 11 | fim_de_semana | bit | False | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL Reconstruida

```sql
CREATE TABLE [silver].[dim_calendario] (
    [sk_calendario] int NOT NULL,
    [data] date NOT NULL,
    [ano] smallint NOT NULL,
    [mes] tinyint NOT NULL,
    [nome_mes] varchar(15) NOT NULL,
    [dia] tinyint NOT NULL,
    [dia_semana] tinyint NOT NULL,
    [nome_dia_semana] varchar(15) NOT NULL,
    [trimestre] tinyint NOT NULL,
    [semana_ano] tinyint NOT NULL,
    [fim_de_semana] bit NOT NULL,
    CONSTRAINT [pk_calendario] PRIMARY KEY ([sk_calendario])
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
