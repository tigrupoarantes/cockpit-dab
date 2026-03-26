<!-- generated: lakehouse-object -->
# bronze.cadastro_tabela_g4_distribuidora

- Tipo: `TABLE`
- Industria: `g4distribuidora`
- Origem: `database:GA_DATALAKE`
- PKs: Nao identificado no banco
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | cd_tabela | char(8) | False | False | False | - |
| 2 | dt_cad | smalldatetime | False | False | False | - |
| 3 | descricao | varchar(30) | False | False | False | - |
| 4 | num_lock | tinyint | False | False | False | - |
| 5 | ativo | bit | True | False | False | - |
| 6 | venda_especial | tinyint | True | False | False | - |
| 7 | cd_tabela_ant | char(8) | True | False | False | - |
| 8 | cd_tabela_prox | char(8) | True | False | False | - |
| 9 | desc_embutido | numeric(7,4) | True | False | False | - |
| 10 | dt_validade | smalldatetime | True | False | False | - |
| 11 | tp_entrega | char(2) | True | False | False | - |
| 12 | nf_imp_desc_itens | tinyint | True | False | False | - |
| 13 | estado | char(2) | True | False | False | - |
| 14 | arq_consys | tinyint | True | False | False | - |
| 15 | cd_tab_pre_categ | char(4) | True | False | False | - |
| 16 | nf_preco_cheio_desc_bol | tinyint | True | False | False | - |
| 17 | cd_texto | int | True | False | False | - |
| 19 | TabPreID | int | False | False | False | - |
| 20 | UtilizaPrecificacaoAutomatica | bit | True | False | False | - |
| 21 | SeqTribCli | int | True | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL Reconstruida

```sql
CREATE TABLE [bronze].[cadastro_tabela_g4_distribuidora] (
    [cd_tabela] char(8) NOT NULL,
    [dt_cad] smalldatetime NOT NULL,
    [descricao] varchar(30) NOT NULL,
    [num_lock] tinyint NOT NULL,
    [ativo] bit NULL,
    [venda_especial] tinyint NULL,
    [cd_tabela_ant] char(8) NULL,
    [cd_tabela_prox] char(8) NULL,
    [desc_embutido] numeric(7,4) NULL,
    [dt_validade] smalldatetime NULL,
    [tp_entrega] char(2) NULL,
    [nf_imp_desc_itens] tinyint NULL,
    [estado] char(2) NULL,
    [arq_consys] tinyint NULL,
    [cd_tab_pre_categ] char(4) NULL,
    [nf_preco_cheio_desc_bol] tinyint NULL,
    [cd_texto] int NULL,
    [TabPreID] int NOT NULL,
    [UtilizaPrecificacaoAutomatica] bit NULL,
    [SeqTribCli] int NULL
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
