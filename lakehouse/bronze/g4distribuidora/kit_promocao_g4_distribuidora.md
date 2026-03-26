<!-- generated: lakehouse-object -->
# bronze.kit_promocao_g4_distribuidora

- Tipo: `TABLE`
- Industria: `g4distribuidora`
- Origem: `database:GA_DATALAKE`
- PKs: Nao identificado no banco
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | seq_kit | int | False | False | False | - |
| 2 | descricao | varchar(40) | False | False | False | - |
| 3 | validade_de | smalldatetime | True | False | False | - |
| 4 | validade_ate | smalldatetime | True | False | False | - |
| 5 | num_lock | tinyint | False | False | False | - |
| 6 | ativo | tinyint | True | False | False | - |
| 7 | cd_texto | int | True | False | False | - |
| 8 | flexivel | tinyint | True | False | False | - |
| 9 | flex_tp_benef_bonif | tinyint | True | False | False | - |
| 10 | flex_tp_bonif | char(2) | True | False | False | - |
| 11 | flex_tp_vl_bonif | char(3) | True | False | False | - |
| 12 | flex_vl_bonif | numeric(13,4) | True | False | False | - |
| 13 | envio_palm_top | tinyint | True | False | False | - |
| 14 | flex_requisito_minimo_item | tinyint | True | False | False | - |
| 15 | flex_tp_benef_prazo | tinyint | True | False | False | - |
| 16 | flex_tp_prazo | char(1) | True | False | False | - |
| 17 | flex_qtde_prazo | int | True | False | False | - |
| 18 | envia_ped_dir | tinyint | True | False | False | - |
| 19 | qtde_limite_venda | int | True | False | False | - |
| 20 | flex_vl_limite_venda | numeric(13,2) | True | False | False | - |
| 22 | vl_limite_cli | numeric(13,2) | True | False | False | - |
| 23 | qtde_limite_cli | int | True | False | False | - |
| 24 | FlexVerbaVend | bit | False | False | False | - |
| 25 | DescMaximo | numeric(7,4) | True | False | False | - |
| 26 | CondPagamentoPorItem | bit | False | False | False | - |
| 27 | RespeitaQtdeMinProduto | bit | False | False | False | - |
| 28 | RespeitaQtdeMultProduto | bit | False | False | False | - |
| 29 | KitPromID | int | False | False | False | - |
| 30 | PrecoFixo | bit | True | False | False | - |
| 31 | EnviaEcommerce | bit | True | False | False | - |
| 32 | RespeitaQtdeMaxProduto | bit | True | False | False | - |
| 33 | BloqueiaPedido | bit | True | False | False | - |
| 34 | ConsideraRedComissao | bit | True | False | False | - |
| 35 | AssociacaoAutomaticaNovoVendedor | bit | True | False | False | - |
| 36 | LancaPedSomenteUnidadePromocao | bit | True | False | False | - |
| 37 | UtilizaIntegracaoYalo | bit | True | False | False | - |
| 38 | UtilizaDescVolume | bit | True | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL Reconstruida

```sql
CREATE TABLE [bronze].[kit_promocao_g4_distribuidora] (
    [seq_kit] int NOT NULL,
    [descricao] varchar(40) NOT NULL,
    [validade_de] smalldatetime NULL,
    [validade_ate] smalldatetime NULL,
    [num_lock] tinyint NOT NULL,
    [ativo] tinyint NULL,
    [cd_texto] int NULL,
    [flexivel] tinyint NULL,
    [flex_tp_benef_bonif] tinyint NULL,
    [flex_tp_bonif] char(2) NULL,
    [flex_tp_vl_bonif] char(3) NULL,
    [flex_vl_bonif] numeric(13,4) NULL,
    [envio_palm_top] tinyint NULL,
    [flex_requisito_minimo_item] tinyint NULL,
    [flex_tp_benef_prazo] tinyint NULL,
    [flex_tp_prazo] char(1) NULL,
    [flex_qtde_prazo] int NULL,
    [envia_ped_dir] tinyint NULL,
    [qtde_limite_venda] int NULL,
    [flex_vl_limite_venda] numeric(13,2) NULL,
    [vl_limite_cli] numeric(13,2) NULL,
    [qtde_limite_cli] int NULL,
    [FlexVerbaVend] bit NOT NULL,
    [DescMaximo] numeric(7,4) NULL,
    [CondPagamentoPorItem] bit NOT NULL,
    [RespeitaQtdeMinProduto] bit NOT NULL,
    [RespeitaQtdeMultProduto] bit NOT NULL,
    [KitPromID] int NOT NULL,
    [PrecoFixo] bit NULL,
    [EnviaEcommerce] bit NULL,
    [RespeitaQtdeMaxProduto] bit NULL,
    [BloqueiaPedido] bit NULL,
    [ConsideraRedComissao] bit NULL,
    [AssociacaoAutomaticaNovoVendedor] bit NULL,
    [LancaPedSomenteUnidadePromocao] bit NULL,
    [UtilizaIntegracaoYalo] bit NULL,
    [UtilizaDescVolume] bit NULL
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
