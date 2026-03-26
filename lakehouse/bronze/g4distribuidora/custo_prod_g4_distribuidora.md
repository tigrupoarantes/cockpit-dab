<!-- generated: lakehouse-object -->
# bronze.custo_prod_g4_distribuidora

- Tipo: `TABLE`
- Industria: `g4distribuidora`
- Origem: `database:GA_DATALAKE`
- PKs: Nao identificado no banco
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | cd_emp | int | False | False | False | - |
| 2 | cd_prod | int | False | False | False | - |
| 3 | tp_custo | char(3) | False | False | False | - |
| 4 | dt_inicio | smalldatetime | False | False | False | - |
| 5 | desc_apl_1 | numeric(6,4) | True | False | False | - |
| 6 | desc_apl_2 | numeric(6,4) | True | False | False | - |
| 7 | vl_custo_sem_imposto | numeric(13,4) | True | False | False | - |
| 8 | vl_ipi | numeric(13,4) | True | False | False | - |
| 9 | vl_icm_subst | numeric(13,4) | True | False | False | - |
| 10 | vl_frete | numeric(13,4) | True | False | False | - |
| 11 | vl_compl | numeric(13,4) | True | False | False | - |
| 12 | vl_icm_compra | numeric(13,4) | True | False | False | - |
| 13 | vl_pis | numeric(13,4) | True | False | False | - |
| 14 | vl_cofins | numeric(13,4) | True | False | False | - |
| 15 | nu_nf | int | True | False | False | - |
| 16 | cd_forn | int | True | False | False | - |
| 17 | qtde | numeric(13,4) | True | False | False | - |
| 18 | seq_grp_desc | int | True | False | False | - |
| 19 | seq_nf_reci | int | True | False | False | - |
| 20 | seq_cust_ant | int | True | False | False | - |
| 21 | par_cfg_custo_capado_subtrai_ipi | bit | True | False | False | - |
| 22 | par_cfg_calc_imp_tare | bit | True | False | False | - |
| 23 | nf_recm_aplic_icm_cust_capado | bit | True | False | False | - |
| 24 | nf_recm_aplic_vl_st_custo_bruto | bit | True | False | False | - |
| 25 | nf_recm_aplic_vl_st_custo_capado | bit | True | False | False | - |
| 26 | vl_imp_cmp_adic | numeric(13,4) | True | False | False | - |
| 28 | VlICMSDeson | numeric(15,4) | True | False | False | - |
| 29 | ValorFCP | numeric(15,4) | True | False | False | - |
| 30 | ValorFCPST | numeric(15,4) | True | False | False | - |
| 31 | ProdutoCustoID | int | False | False | False | - |
| 32 | VlCreditoPresumido | numeric(15,4) | True | False | False | - |
| 33 | custo_capado_cred_icm | tinyint | True | False | False | - |
| 34 | vl_custo | numeric(15,4) | True | False | False | - |
| 35 | vl_cust_brt | numeric(15,4) | True | False | False | - |
| 36 | VlCustoSemImpostoDeson | numeric(15,4) | True | False | False | - |
| 37 | vl_custo_capado | numeric(15,4) | True | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL Reconstruida

```sql
CREATE TABLE [bronze].[custo_prod_g4_distribuidora] (
    [cd_emp] int NOT NULL,
    [cd_prod] int NOT NULL,
    [tp_custo] char(3) NOT NULL,
    [dt_inicio] smalldatetime NOT NULL,
    [desc_apl_1] numeric(6,4) NULL,
    [desc_apl_2] numeric(6,4) NULL,
    [vl_custo_sem_imposto] numeric(13,4) NULL,
    [vl_ipi] numeric(13,4) NULL,
    [vl_icm_subst] numeric(13,4) NULL,
    [vl_frete] numeric(13,4) NULL,
    [vl_compl] numeric(13,4) NULL,
    [vl_icm_compra] numeric(13,4) NULL,
    [vl_pis] numeric(13,4) NULL,
    [vl_cofins] numeric(13,4) NULL,
    [nu_nf] int NULL,
    [cd_forn] int NULL,
    [qtde] numeric(13,4) NULL,
    [seq_grp_desc] int NULL,
    [seq_nf_reci] int NULL,
    [seq_cust_ant] int NULL,
    [par_cfg_custo_capado_subtrai_ipi] bit NULL,
    [par_cfg_calc_imp_tare] bit NULL,
    [nf_recm_aplic_icm_cust_capado] bit NULL,
    [nf_recm_aplic_vl_st_custo_bruto] bit NULL,
    [nf_recm_aplic_vl_st_custo_capado] bit NULL,
    [vl_imp_cmp_adic] numeric(13,4) NULL,
    [VlICMSDeson] numeric(15,4) NULL,
    [ValorFCP] numeric(15,4) NULL,
    [ValorFCPST] numeric(15,4) NULL,
    [ProdutoCustoID] int NOT NULL,
    [VlCreditoPresumido] numeric(15,4) NULL,
    [custo_capado_cred_icm] tinyint NULL,
    [vl_custo] numeric(15,4) NULL,
    [vl_cust_brt] numeric(15,4) NULL,
    [VlCustoSemImpostoDeson] numeric(15,4) NULL,
    [vl_custo_capado] numeric(15,4) NULL
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
