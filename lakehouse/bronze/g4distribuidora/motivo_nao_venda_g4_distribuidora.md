<!-- generated: lakehouse-object -->
# bronze.motivo_nao_venda_g4_distribuidora

- Tipo: `TABLE`
- Industria: `g4distribuidora`
- Origem: `database:GA_DATALAKE`
- PKs: Nao identificado no banco
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | cd_resultado | char(8) | False | False | False | - |
| 2 | descricao | varchar(20) | False | False | False | - |
| 3 | exige_motivo | bit | True | False | False | - |
| 4 | exige_veiculo | bit | True | False | False | - |
| 5 | exige_contato | bit | True | False | False | - |
| 6 | venda | bit | True | False | False | - |
| 7 | num_lock | tinyint | False | False | False | - |
| 8 | ativo | bit | True | False | False | - |
| 9 | saida_rapida_pedv | bit | False | False | False | - |
| 10 | envio_palm_top | bit | False | False | False | - |
| 12 | ResTmktID | int | False | False | False | - |
| 13 | MotNaoVenda | bit | True | False | False | - |
| 14 | MotNaoVisita | bit | True | False | False | - |
| 15 | ProdutosEstrategicos | bit | True | False | False | - |
| 16 | EnviaMobPromotor | bit | True | False | False | - |
| 17 | MotNaoVisitaMobPromotor | bit | True | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL Reconstruida

```sql
CREATE TABLE [bronze].[motivo_nao_venda_g4_distribuidora] (
    [cd_resultado] char(8) NOT NULL,
    [descricao] varchar(20) NOT NULL,
    [exige_motivo] bit NULL,
    [exige_veiculo] bit NULL,
    [exige_contato] bit NULL,
    [venda] bit NULL,
    [num_lock] tinyint NOT NULL,
    [ativo] bit NULL,
    [saida_rapida_pedv] bit NOT NULL,
    [envio_palm_top] bit NOT NULL,
    [ResTmktID] int NOT NULL,
    [MotNaoVenda] bit NULL,
    [MotNaoVisita] bit NULL,
    [ProdutosEstrategicos] bit NULL,
    [EnviaMobPromotor] bit NULL,
    [MotNaoVisitaMobPromotor] bit NULL
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
