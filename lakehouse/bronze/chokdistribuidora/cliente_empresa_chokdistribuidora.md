<!-- generated: lakehouse-object -->
# bronze.cliente_empresa_chokdistribuidora

- Tipo: `TABLE`
- Industria: `chokdistribuidora`
- Origem: `database:GA_DATALAKE`
- PKs: Nao identificado no banco
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | cd_emp | int | False | False | False | - |
| 2 | cd_clien | int | False | False | False | - |
| 3 | cd_tabela | char(8) | True | False | False | - |
| 4 | seq_prom | int | True | False | False | - |
| 5 | nu_banco_ve | smallint | True | False | False | - |
| 6 | nu_agencia_ve | varchar(8) | True | False | False | - |
| 7 | nu_conta_ve | varchar(10) | True | False | False | - |
| 8 | nu_banco_vs | smallint | True | False | False | - |
| 9 | nu_agencia_vs | varchar(8) | True | False | False | - |
| 10 | nu_conta_vs | varchar(10) | True | False | False | - |
| 11 | vl_lim_ped_pf | numeric(13,2) | True | False | False | - |
| 12 | prz_medio_max | smallint | True | False | False | - |
| 14 | Utiliza | bit | False | False | False | - |
| 15 | CliEmpID | int | False | False | False | - |
| 16 | CdTabelaEcommerce | char(8) | True | False | False | - |
| 17 | ValorLimiteCredito | numeric(13,2) | True | False | False | - |
| 18 | DtPrimCompra | datetime | True | False | False | - |
| 19 | TpPedEcommerce | char(2) | True | False | False | - |
| 20 | VlLimiteCreditoTerceiros | numeric(13,2) | False | False | False | - |
| 21 | ConfiguracaoCobrancaPixId | int | True | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL Reconstruida

```sql
CREATE TABLE [bronze].[cliente_empresa_chokdistribuidora] (
    [cd_emp] int NOT NULL,
    [cd_clien] int NOT NULL,
    [cd_tabela] char(8) NULL,
    [seq_prom] int NULL,
    [nu_banco_ve] smallint NULL,
    [nu_agencia_ve] varchar(8) NULL,
    [nu_conta_ve] varchar(10) NULL,
    [nu_banco_vs] smallint NULL,
    [nu_agencia_vs] varchar(8) NULL,
    [nu_conta_vs] varchar(10) NULL,
    [vl_lim_ped_pf] numeric(13,2) NULL,
    [prz_medio_max] smallint NULL,
    [Utiliza] bit NOT NULL,
    [CliEmpID] int NOT NULL,
    [CdTabelaEcommerce] char(8) NULL,
    [ValorLimiteCredito] numeric(13,2) NULL,
    [DtPrimCompra] datetime NULL,
    [TpPedEcommerce] char(2) NULL,
    [VlLimiteCreditoTerceiros] numeric(13,2) NOT NULL,
    [ConfiguracaoCobrancaPixId] int NULL
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
