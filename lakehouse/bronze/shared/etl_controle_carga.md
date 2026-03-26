<!-- generated: lakehouse-object -->
# bronze.etl_controle_carga

- Tipo: `TABLE`
- Industria: `shared`
- Origem: `database:GA_DATALAKE`
- PKs: id
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | id | int | False | True | False | - |
| 2 | nome_processo | varchar(200) | True | False | False | - |
| 3 | data_inicio_execucao | datetime | True | False | False | - |
| 4 | data_fim_execucao | datetime | True | False | False | - |
| 5 | duracao_segundos | int | True | False | False | - |
| 6 | data_ultima_carga | datetime | True | False | False | - |
| 7 | total_lotes | int | True | False | False | - |
| 8 | linhas_inseridas | int | True | False | False | - |
| 9 | status_execucao | varchar(20) | True | False | False | - |
| 10 | mensagem_erro | nvarchar(max) | True | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL Reconstruida

```sql
CREATE TABLE [bronze].[etl_controle_carga] (
    [id] int IDENTITY(1,1) NOT NULL,
    [nome_processo] varchar(200) NULL,
    [data_inicio_execucao] datetime NULL,
    [data_fim_execucao] datetime NULL,
    [duracao_segundos] int NULL,
    [data_ultima_carga] datetime NULL,
    [total_lotes] int NULL,
    [linhas_inseridas] int NULL,
    [status_execucao] varchar(20) NULL,
    [mensagem_erro] nvarchar(max) NULL,
    CONSTRAINT [PK__etl_cont__3213E83F4FE7BD53] PRIMARY KEY ([id])
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
