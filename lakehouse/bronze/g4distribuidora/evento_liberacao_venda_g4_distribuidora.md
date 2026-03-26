<!-- generated: lakehouse-object -->
# bronze.evento_liberacao_venda_g4_distribuidora

- Tipo: `TABLE`
- Industria: `g4distribuidora`
- Origem: `database:GA_DATALAKE`
- PKs: Nao identificado no banco
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | seq_evento | int | False | False | False | - |
| 2 | cd_fila | char(4) | False | False | False | - |
| 3 | cd_emp | int | False | False | False | - |
| 4 | cd_clien | int | True | False | False | - |
| 5 | nu_ped | int | True | False | False | - |
| 6 | cd_usr_ger | char(8) | True | False | False | - |
| 7 | cd_usr_resp | char(8) | True | False | False | - |
| 8 | cd_usr_enc | char(8) | True | False | False | - |
| 9 | dt_criacao | smalldatetime | False | False | False | - |
| 10 | dt_reserva | smalldatetime | True | False | False | - |
| 11 | dt_encer | smalldatetime | True | False | False | - |
| 12 | dt_prevista | smalldatetime | True | False | False | - |
| 13 | dt_follow | smalldatetime | True | False | False | - |
| 14 | num_follow | int | True | False | False | - |
| 15 | situacao | nchar(2) | False | False | False | - |
| 16 | comentario | int | True | False | False | - |
| 18 | EventoID | int | False | False | False | - |
| 19 | NomeMaquina | nvarchar(128) | True | False | False | - |
| 20 | NomeAplicacao | nvarchar(128) | True | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL Reconstruida

```sql
CREATE TABLE [bronze].[evento_liberacao_venda_g4_distribuidora] (
    [seq_evento] int NOT NULL,
    [cd_fila] char(4) NOT NULL,
    [cd_emp] int NOT NULL,
    [cd_clien] int NULL,
    [nu_ped] int NULL,
    [cd_usr_ger] char(8) NULL,
    [cd_usr_resp] char(8) NULL,
    [cd_usr_enc] char(8) NULL,
    [dt_criacao] smalldatetime NOT NULL,
    [dt_reserva] smalldatetime NULL,
    [dt_encer] smalldatetime NULL,
    [dt_prevista] smalldatetime NULL,
    [dt_follow] smalldatetime NULL,
    [num_follow] int NULL,
    [situacao] nchar(2) NOT NULL,
    [comentario] int NULL,
    [EventoID] int NOT NULL,
    [NomeMaquina] nvarchar(128) NULL,
    [NomeAplicacao] nvarchar(128) NULL
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
