<!-- generated: lakehouse-object -->
# bronze.etl_controle_carga_sankhya

- Tipo: `TABLE`
- Industria: `shared`
- Origem: `database:GA_DATALAKE`
- PKs: id
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | id | int | False | True | False | - |
| 2 | nome_processo | varchar(200) | False | False | False | - |
| 3 | nome_tabela_destino | varchar(200) | False | False | False | - |
| 4 | camada | varchar(20) | False | False | False | - |
| 5 | data_inicio_execucao | datetime | False | False | False | - |
| 6 | data_fim_execucao | datetime | True | False | False | - |
| 7 | duracao_segundos | int | True | False | False | - |
| 8 | tipo_carga | varchar(20) | False | False | False | - |
| 9 | linhas_origem | int | True | False | False | - |
| 10 | linhas_afetadas | int | True | False | False | - |
| 11 | status_execucao | varchar(20) | False | False | False | - |
| 12 | mensagem_erro | nvarchar(max) | True | False | False | - |
| 13 | servidor_origem | varchar(200) | True | False | False | - |
| 14 | observacao | varchar(500) | True | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL Reconstruida

```sql
CREATE TABLE [bronze].[etl_controle_carga_sankhya] (
    [id] int IDENTITY(1,1) NOT NULL,
    [nome_processo] varchar(200) NOT NULL,
    [nome_tabela_destino] varchar(200) NOT NULL,
    [camada] varchar(20) NOT NULL,
    [data_inicio_execucao] datetime NOT NULL,
    [data_fim_execucao] datetime NULL,
    [duracao_segundos] int NULL,
    [tipo_carga] varchar(20) NOT NULL,
    [linhas_origem] int NULL,
    [linhas_afetadas] int NULL,
    [status_execucao] varchar(20) NOT NULL,
    [mensagem_erro] nvarchar(max) NULL,
    [servidor_origem] varchar(200) NULL,
    [observacao] varchar(500) NULL,
    CONSTRAINT [PK__etl_cont__3213E83F7DF396E0] PRIMARY KEY ([id])
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
