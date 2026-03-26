<!-- generated: lakehouse-object -->
# bronze.origem_pedido_chokdistribuidora

- Tipo: `TABLE`
- Industria: `chokdistribuidora`
- Origem: `database:GA_DATALAKE`
- PKs: Nao identificado no banco
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | OrigemPedidoVenda | char(1) | False | False | False | - |
| 2 | Descricao | varchar(40) | False | False | False | - |
| 3 | Ativo | bit | False | False | False | - |
| 4 | DetalhePedVdaEle | bit | False | False | False | - |
| 6 | ListaPedidoPendente | bit | True | False | False | - |
| 7 | EndPedNotaFiscal | bit | True | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL Reconstruida

```sql
CREATE TABLE [bronze].[origem_pedido_chokdistribuidora] (
    [OrigemPedidoVenda] char(1) NOT NULL,
    [Descricao] varchar(40) NOT NULL,
    [Ativo] bit NOT NULL,
    [DetalhePedVdaEle] bit NOT NULL,
    [ListaPedidoPendente] bit NULL,
    [EndPedNotaFiscal] bit NULL
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
