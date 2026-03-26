<!-- generated: lakehouse-object -->
# bronze.fabric_g4_distribuidora

- Tipo: `TABLE`
- Industria: `g4distribuidora`
- Origem: `database:GA_DATALAKE`
- PKs: Nao identificado no banco
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | cd_fabric | char(6) | False | False | False | - |
| 2 | cd_fabric_comp | char(10) | True | False | False | - |
| 3 | descricao | varchar(30) | False | False | False | - |
| 4 | descricao_comp | varchar(50) | True | False | False | - |
| 5 | sigla | char(3) | False | False | False | - |
| 6 | num_lock | int | False | False | False | - |
| 7 | ativo | bit | False | False | False | - |
| 8 | envio_palm_top | bit | False | False | False | - |
| 9 | envia_ped_dir | bit | False | False | False | - |
| 11 | CorLegendaRGBWms3D | varchar(11) | True | False | False | - |
| 12 | FabricID | int | False | False | False | - |
| 13 | ExibeMetas | bit | True | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL Reconstruida

```sql
CREATE TABLE [bronze].[fabric_g4_distribuidora] (
    [cd_fabric] char(6) NOT NULL,
    [cd_fabric_comp] char(10) NULL,
    [descricao] varchar(30) NOT NULL,
    [descricao_comp] varchar(50) NULL,
    [sigla] char(3) NOT NULL,
    [num_lock] int NOT NULL,
    [ativo] bit NOT NULL,
    [envio_palm_top] bit NOT NULL,
    [envia_ped_dir] bit NOT NULL,
    [CorLegendaRGBWms3D] varchar(11) NULL,
    [FabricID] int NOT NULL,
    [ExibeMetas] bit NULL
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
