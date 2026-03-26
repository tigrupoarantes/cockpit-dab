<!-- generated: lakehouse-object -->
# bronze.check_in_out_vend_g4_distribuidora

- Tipo: `TABLE`
- Industria: `g4distribuidora`
- Origem: `database:GA_DATALAKE`
- PKs: Nao identificado no banco
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | IdCoordenadaRoteiroVendedorPermanencia | bigint | False | False | False | - |
| 2 | IdVendedor | int | False | False | False | - |
| 3 | CodigoVendedor | varchar(8) | True | False | False | - |
| 4 | Data | date | False | False | False | - |
| 5 | CodigoCliente | int | False | False | False | - |
| 6 | HoraInicio | time(7) | False | False | False | - |
| 7 | HoraFim | time(7) | False | False | False | - |
| 8 | Roteiro | int | False | False | False | - |
| 9 | CodigoAcao | int | False | False | False | - |
| 11 | VisitaTelefonica | bit | True | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL Reconstruida

```sql
CREATE TABLE [bronze].[check_in_out_vend_g4_distribuidora] (
    [IdCoordenadaRoteiroVendedorPermanencia] bigint NOT NULL,
    [IdVendedor] int NOT NULL,
    [CodigoVendedor] varchar(8) NULL,
    [Data] date NOT NULL,
    [CodigoCliente] int NOT NULL,
    [HoraInicio] time(7) NOT NULL,
    [HoraFim] time(7) NOT NULL,
    [Roteiro] int NOT NULL,
    [CodigoAcao] int NOT NULL,
    [VisitaTelefonica] bit NULL
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
