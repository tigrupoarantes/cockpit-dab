<!-- generated: lakehouse-object -->
# bronze.pedido_venda_g4_distribuidora

- Tipo: `TABLE`
- Industria: `g4distribuidora`
- Origem: `database:GA_DATALAKE`
- PKs: Nao identificado no banco
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | cd_emp | int | False | False | False | - |
| 2 | nu_ped | int | False | False | False | - |
| 3 | seq | int | False | False | False | - |
| 4 | cd_prod | int | False | False | False | - |
| 5 | papel_cortado | bit | True | False | False | - |
| 6 | qtde_volumes | numeric(13,4) | True | False | False | - |
| 7 | qtde | numeric(13,4) | False | False | False | - |
| 8 | qtde_consig_vend | numeric(13,4) | True | False | False | - |
| 9 | qtde_consig_dev | numeric(13,4) | True | False | False | - |
| 10 | consig_concluida | bit | True | False | False | - |
| 11 | unidade | char(2) | True | False | False | - |
| 12 | fator_est_vda | float | True | False | False | - |
| 13 | unid_vda | char(2) | True | False | False | - |
| 14 | qtde_unid_vda | numeric(13,4) | True | False | False | - |
| 15 | vl_unit_vda | numeric(15,4) | True | False | False | - |
| 16 | ind_relacao | char(5) | True | False | False | - |
| 17 | fator_est_ped | float | True | False | False | - |
| 18 | unid_ped | char(2) | True | False | False | - |
| 19 | qtde_unid_ped | numeric(13,4) | True | False | False | - |
| 20 | vl_unit_ped | numeric(15,4) | True | False | False | - |
| 21 | preco_tabela | numeric(15,4) | True | False | False | - |
| 22 | preco_basico | numeric(15,4) | True | False | False | - |
| 23 | desc_apl | numeric(6,4) | True | False | False | - |
| 24 | perc_desc_ger | numeric(6,4) | True | False | False | - |
| 25 | perc_desc_fin | numeric(6,4) | True | False | False | - |
| 26 | preco_unit | numeric(15,4) | False | False | False | - |
| 27 | preco_nf | numeric(13,2) | False | False | False | - |
| 28 | preco_nf_serv | numeric(13,2) | True | False | False | - |
| 29 | perc_acres_dif_icm | numeric(6,4) | True | False | False | - |
| 30 | vl_acres_dif_icm | numeric(13,2) | True | False | False | - |
| 31 | perc_acres_frete | numeric(6,4) | True | False | False | - |
| 32 | vl_acres_frete | numeric(13,2) | True | False | False | - |
| 33 | aliq_ipi | numeric(6,4) | True | False | False | - |
| 34 | descperm_prodqtde | numeric(6,4) | True | False | False | - |
| 35 | aliq_icm | numeric(6,4) | True | False | False | - |
| 36 | vl_ipi | numeric(13,2) | True | False | False | - |
| 37 | vda_av | numeric(13,2) | True | False | False | - |
| 38 | custo_av | numeric(13,2) | True | False | False | - |
| 39 | cust_cmp | numeric(13,2) | True | False | False | - |
| 40 | cust_cue | numeric(13,2) | True | False | False | - |
| 41 | vda_liq | numeric(13,2) | True | False | False | - |
| 42 | vl_base_comissao | numeric(15,4) | True | False | False | - |
| 43 | red_comissao | numeric(6,4) | True | False | False | - |
| 44 | comissao_padrao | numeric(6,4) | True | False | False | - |
| 45 | perc_com | numeric(6,4) | True | False | False | - |
| 46 | vl_comis | numeric(13,2) | True | False | False | - |
| 47 | nu_nf | int | True | False | False | - |
| 48 | est_insuf | bit | True | False | False | - |
| 49 | dt_fatur | smalldatetime | True | False | False | - |
| 50 | pesagem | tinyint | True | False | False | - |
| 51 | cd_texto | int | True | False | False | - |
| 52 | situacao | char(2) | False | False | False | - |
| 53 | qtde_pe_vend_ve | numeric(13,4) | True | False | False | - |
| 54 | qtde_pe_vend_vs | numeric(13,4) | True | False | False | - |
| 55 | qtde_pe_devolvida | numeric(13,4) | True | False | False | - |
| 56 | pe_concluida | tinyint | True | False | False | - |
| 57 | vl_tot_vda | numeric(13,2) | True | False | False | - |
| 58 | peso_tot_brt | numeric(7,3) | True | False | False | - |
| 59 | peso_tot_liq | numeric(7,3) | True | False | False | - |
| 60 | pesagem_nf | tinyint | True | False | False | - |
| 61 | vl_comis_vend | numeric(13,2) | True | False | False | - |
| 62 | vl_comis_lanc | numeric(13,2) | True | False | False | - |
| 63 | vl_desc_geral | numeric(13,2) | True | False | False | - |
| 64 | desc_apl_real | numeric(7,4) | True | False | False | - |
| 65 | seq_evento_dev | int | True | False | False | - |
| 66 | situacao_2_nf | char(2) | True | False | False | - |
| 67 | nu_nf_2_nf | int | True | False | False | - |
| 68 | seq_origem | int | True | False | False | - |
| 69 | descprom_lancprod | tinyint | True | False | False | - |
| 70 | descprom_redcomis | tinyint | True | False | False | - |
| 71 | ind_relacao_vda | char(5) | False | False | False | - |
| 72 | desc01 | numeric(7,4) | True | False | False | - |
| 73 | desc02 | numeric(7,4) | True | False | False | - |
| 74 | estoque_zerado | tinyint | True | False | False | - |
| 75 | vl_verba | numeric(13,2) | True | False | False | - |
| 76 | restr_vda | tinyint | True | False | False | - |
| 77 | bonificado | tinyint | True | False | False | - |
| 78 | fator_preco | numeric(7,4) | True | False | False | - |
| 79 | seq_kit | int | True | False | False | - |
| 80 | desc_prom | numeric(7,4) | True | False | False | - |
| 81 | desc_por_qtde | numeric(7,4) | True | False | False | - |
| 82 | custo_av_capado | numeric(15,4) | True | False | False | - |
| 83 | cust_cmp_capado | numeric(15,4) | True | False | False | - |
| 84 | cust_cue_capado | numeric(15,4) | True | False | False | - |
| 85 | vl_verba_emp | numeric(13,2) | True | False | False | - |
| 86 | vl_verba_equip | numeric(13,2) | True | False | False | - |
| 87 | vl_icm_subst | numeric(13,2) | True | False | False | - |
| 88 | desc_grd_bon | numeric(7,4) | True | False | False | - |
| 89 | desc_grd_com | numeric(7,4) | True | False | False | - |
| 90 | desc_grd_fin | numeric(7,4) | True | False | False | - |
| 91 | vl_desc_fin | numeric(13,2) | True | False | False | - |
| 92 | nf_preco_cheio_desc_bol | tinyint | True | False | False | - |
| 93 | seq_custo_crp | int | True | False | False | - |
| 94 | seq_custo_cue | int | True | False | False | - |
| 95 | seq_custo_cmp | int | True | False | False | - |
| 96 | vl_cred_icm_crp | numeric(13,4) | True | False | False | - |
| 97 | vl_cred_icm_cmp | numeric(13,4) | True | False | False | - |
| 98 | vl_cred_icm_cue | numeric(13,4) | True | False | False | - |
| 99 | direcionado | tinyint | True | False | False | - |
| 100 | trans_efet | tinyint | True | False | False | - |
| 101 | vl_deb_icm | numeric(13,2) | True | False | False | - |
| 102 | vl_deb_pis | numeric(13,2) | True | False | False | - |
| 103 | vl_deb_cofins | numeric(13,2) | True | False | False | - |
| 104 | nu_ped_cli | varchar(35) | True | False | False | - |
| 105 | venda_casada | tinyint | True | False | False | - |
| 106 | venda_casada_cd_forn | int | True | False | False | - |
| 107 | venda_casada_ped_comp | int | True | False | False | - |
| 108 | seq_it_pedc | int | True | False | False | - |
| 109 | venda_casada_negociacao | tinyint | True | False | False | - |
| 110 | vl_comis_rt | numeric(13,2) | True | False | False | - |
| 111 | vl_frete_item | numeric(13,2) | True | False | False | - |
| 112 | vl_verba_fabr | numeric(13,2) | True | False | False | - |
| 113 | vl_verba_fabr_adic | numeric(13,2) | True | False | False | - |
| 114 | seq_acao_comercial | int | True | False | False | - |
| 116 | import_seq_doc_import | bigint | True | False | False | - |
| 117 | import_seq_adicao_import | bigint | True | False | False | - |
| 118 | import_vl_siscomex | numeric(13,2) | True | False | False | - |
| 119 | import_aliq_ii | numeric(6,4) | True | False | False | - |
| 120 | import_vl_ii | numeric(13,2) | True | False | False | - |
| 121 | vl_st_unit_adic_item | numeric(15,4) | True | False | False | - |
| 122 | par_cfg_mg_bruta_desc_fin | bit | True | False | False | - |
| 123 | ItemBonifContrato | bit | True | False | False | - |
| 124 | nf_refer_cd_forn_compra | int | True | False | False | - |
| 125 | nf_refer_nu_nf_compra | int | True | False | False | - |
| 126 | nf_refer_avulsa_nfe | bit | True | False | False | - |
| 127 | nf_refer_avulsa_nu_nf | int | True | False | False | - |
| 128 | nf_refer_avulsa_serie | char(3) | True | False | False | - |
| 129 | nf_refer_avulsa_dt_emis | smalldatetime | True | False | False | - |
| 130 | QtdePecas | numeric(18,0) | True | False | False | - |
| 131 | nuRecopi | varchar(20) | True | False | False | - |
| 132 | NfReferAvulsaChaveAcesso | varchar(44) | True | False | False | - |
| 133 | SeqProm | int | True | False | False | - |
| 134 | SeqCustoUec | int | True | False | False | - |
| 135 | SeqCustoMpc | int | True | False | False | - |
| 136 | CustoUec | numeric(15,4) | True | False | False | - |
| 137 | CustoUecCapado | numeric(15,4) | True | False | False | - |
| 138 | CustoMpc | numeric(15,4) | True | False | False | - |
| 139 | CustoMpcCapado | numeric(15,4) | True | False | False | - |
| 140 | ItPedvID | int | False | False | False | - |
| 141 | PercDescCampanha | numeric(6,4) | True | False | False | - |
| 142 | CampanhaFamiliaID | int | True | False | False | - |
| 143 | VlJurosItem | numeric(13,4) | True | False | False | - |
| 144 | VlTaxaContrato | numeric(13,4) | True | False | False | - |
| 145 | CampanhaComboIDDesc | int | True | False | False | - |
| 146 | PercDescCampanhaCombo | numeric(6,4) | True | False | False | - |
| 147 | CoeficienteCustoFinanceiro | numeric(25,22) | True | False | False | - |
| 148 | VlCustoAdic | numeric(13,2) | True | False | False | - |
| 149 | PercCustoAdic | numeric(5,4) | True | False | False | - |
| 150 | Vasilhame | bit | True | False | False | - |
| 151 | TpPedBonificacaoValorZero | bit | True | False | False | - |
| 152 | ValorICMSDesonerado | numeric(13,2) | True | False | False | - |
| 153 | ValorTaxaMarketplace | numeric(13,2) | True | False | False | - |
| 154 | PercTaxaMarketplace | numeric(7,4) | True | False | False | - |
| 155 | ValorMaximoPedidoComplementar | numeric(15,4) | True | False | False | - |
| 156 | PercPedidoComplementar | numeric(38,11) | True | False | False | - |
| 157 | SeqPedCli | smallint | True | False | False | - |
| 158 | CdTabela | char(8) | True | False | False | - |
| 159 | DataDevolucao | datetime | True | False | False | - |
| 160 | CdTextoObs | int | True | False | False | - |
| 161 | vl_mg_brt_crp | numeric(13,2) | True | False | False | - |
| 162 | vl_mg_brt_cmp | numeric(13,2) | True | False | False | - |
| 163 | vl_mg_brt_cue | numeric(13,2) | True | False | False | - |
| 164 | vl_venda_av | numeric(13,2) | True | False | False | - |
| 165 | VlVendaAvMargem | numeric(13,2) | True | False | False | - |
| 166 | vl_venda | numeric(13,2) | True | False | False | - |
| 167 | VlVendaMargem | numeric(13,2) | True | False | False | - |
| 168 | VlVendaApuracaoBonificacao | numeric(13,2) | True | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL Reconstruida

```sql
CREATE TABLE [bronze].[pedido_venda_g4_distribuidora] (
    [cd_emp] int NOT NULL,
    [nu_ped] int NOT NULL,
    [seq] int NOT NULL,
    [cd_prod] int NOT NULL,
    [papel_cortado] bit NULL,
    [qtde_volumes] numeric(13,4) NULL,
    [qtde] numeric(13,4) NOT NULL,
    [qtde_consig_vend] numeric(13,4) NULL,
    [qtde_consig_dev] numeric(13,4) NULL,
    [consig_concluida] bit NULL,
    [unidade] char(2) NULL,
    [fator_est_vda] float NULL,
    [unid_vda] char(2) NULL,
    [qtde_unid_vda] numeric(13,4) NULL,
    [vl_unit_vda] numeric(15,4) NULL,
    [ind_relacao] char(5) NULL,
    [fator_est_ped] float NULL,
    [unid_ped] char(2) NULL,
    [qtde_unid_ped] numeric(13,4) NULL,
    [vl_unit_ped] numeric(15,4) NULL,
    [preco_tabela] numeric(15,4) NULL,
    [preco_basico] numeric(15,4) NULL,
    [desc_apl] numeric(6,4) NULL,
    [perc_desc_ger] numeric(6,4) NULL,
    [perc_desc_fin] numeric(6,4) NULL,
    [preco_unit] numeric(15,4) NOT NULL,
    [preco_nf] numeric(13,2) NOT NULL,
    [preco_nf_serv] numeric(13,2) NULL,
    [perc_acres_dif_icm] numeric(6,4) NULL,
    [vl_acres_dif_icm] numeric(13,2) NULL,
    [perc_acres_frete] numeric(6,4) NULL,
    [vl_acres_frete] numeric(13,2) NULL,
    [aliq_ipi] numeric(6,4) NULL,
    [descperm_prodqtde] numeric(6,4) NULL,
    [aliq_icm] numeric(6,4) NULL,
    [vl_ipi] numeric(13,2) NULL,
    [vda_av] numeric(13,2) NULL,
    [custo_av] numeric(13,2) NULL,
    [cust_cmp] numeric(13,2) NULL,
    [cust_cue] numeric(13,2) NULL,
    [vda_liq] numeric(13,2) NULL,
    [vl_base_comissao] numeric(15,4) NULL,
    [red_comissao] numeric(6,4) NULL,
    [comissao_padrao] numeric(6,4) NULL,
    [perc_com] numeric(6,4) NULL,
    [vl_comis] numeric(13,2) NULL,
    [nu_nf] int NULL,
    [est_insuf] bit NULL,
    [dt_fatur] smalldatetime NULL,
    [pesagem] tinyint NULL,
    [cd_texto] int NULL,
    [situacao] char(2) NOT NULL,
    [qtde_pe_vend_ve] numeric(13,4) NULL,
    [qtde_pe_vend_vs] numeric(13,4) NULL,
    [qtde_pe_devolvida] numeric(13,4) NULL,
    [pe_concluida] tinyint NULL,
    [vl_tot_vda] numeric(13,2) NULL,
    [peso_tot_brt] numeric(7,3) NULL,
    [peso_tot_liq] numeric(7,3) NULL,
    [pesagem_nf] tinyint NULL,
    [vl_comis_vend] numeric(13,2) NULL,
    [vl_comis_lanc] numeric(13,2) NULL,
    [vl_desc_geral] numeric(13,2) NULL,
    [desc_apl_real] numeric(7,4) NULL,
    [seq_evento_dev] int NULL,
    [situacao_2_nf] char(2) NULL,
    [nu_nf_2_nf] int NULL,
    [seq_origem] int NULL,
    [descprom_lancprod] tinyint NULL,
    [descprom_redcomis] tinyint NULL,
    [ind_relacao_vda] char(5) NOT NULL,
    [desc01] numeric(7,4) NULL,
    [desc02] numeric(7,4) NULL,
    [estoque_zerado] tinyint NULL,
    [vl_verba] numeric(13,2) NULL,
    [restr_vda] tinyint NULL,
    [bonificado] tinyint NULL,
    [fator_preco] numeric(7,4) NULL,
    [seq_kit] int NULL,
    [desc_prom] numeric(7,4) NULL,
    [desc_por_qtde] numeric(7,4) NULL,
    [custo_av_capado] numeric(15,4) NULL,
    [cust_cmp_capado] numeric(15,4) NULL,
    [cust_cue_capado] numeric(15,4) NULL,
    [vl_verba_emp] numeric(13,2) NULL,
    [vl_verba_equip] numeric(13,2) NULL,
    [vl_icm_subst] numeric(13,2) NULL,
    [desc_grd_bon] numeric(7,4) NULL,
    [desc_grd_com] numeric(7,4) NULL,
    [desc_grd_fin] numeric(7,4) NULL,
    [vl_desc_fin] numeric(13,2) NULL,
    [nf_preco_cheio_desc_bol] tinyint NULL,
    [seq_custo_crp] int NULL,
    [seq_custo_cue] int NULL,
    [seq_custo_cmp] int NULL,
    [vl_cred_icm_crp] numeric(13,4) NULL,
    [vl_cred_icm_cmp] numeric(13,4) NULL,
    [vl_cred_icm_cue] numeric(13,4) NULL,
    [direcionado] tinyint NULL,
    [trans_efet] tinyint NULL,
    [vl_deb_icm] numeric(13,2) NULL,
    [vl_deb_pis] numeric(13,2) NULL,
    [vl_deb_cofins] numeric(13,2) NULL,
    [nu_ped_cli] varchar(35) NULL,
    [venda_casada] tinyint NULL,
    [venda_casada_cd_forn] int NULL,
    [venda_casada_ped_comp] int NULL,
    [seq_it_pedc] int NULL,
    [venda_casada_negociacao] tinyint NULL,
    [vl_comis_rt] numeric(13,2) NULL,
    [vl_frete_item] numeric(13,2) NULL,
    [vl_verba_fabr] numeric(13,2) NULL,
    [vl_verba_fabr_adic] numeric(13,2) NULL,
    [seq_acao_comercial] int NULL,
    [import_seq_doc_import] bigint NULL,
    [import_seq_adicao_import] bigint NULL,
    [import_vl_siscomex] numeric(13,2) NULL,
    [import_aliq_ii] numeric(6,4) NULL,
    [import_vl_ii] numeric(13,2) NULL,
    [vl_st_unit_adic_item] numeric(15,4) NULL,
    [par_cfg_mg_bruta_desc_fin] bit NULL,
    [ItemBonifContrato] bit NULL,
    [nf_refer_cd_forn_compra] int NULL,
    [nf_refer_nu_nf_compra] int NULL,
    [nf_refer_avulsa_nfe] bit NULL,
    [nf_refer_avulsa_nu_nf] int NULL,
    [nf_refer_avulsa_serie] char(3) NULL,
    [nf_refer_avulsa_dt_emis] smalldatetime NULL,
    [QtdePecas] numeric(18,0) NULL,
    [nuRecopi] varchar(20) NULL,
    [NfReferAvulsaChaveAcesso] varchar(44) NULL,
    [SeqProm] int NULL,
    [SeqCustoUec] int NULL,
    [SeqCustoMpc] int NULL,
    [CustoUec] numeric(15,4) NULL,
    [CustoUecCapado] numeric(15,4) NULL,
    [CustoMpc] numeric(15,4) NULL,
    [CustoMpcCapado] numeric(15,4) NULL,
    [ItPedvID] int NOT NULL,
    [PercDescCampanha] numeric(6,4) NULL,
    [CampanhaFamiliaID] int NULL,
    [VlJurosItem] numeric(13,4) NULL,
    [VlTaxaContrato] numeric(13,4) NULL,
    [CampanhaComboIDDesc] int NULL,
    [PercDescCampanhaCombo] numeric(6,4) NULL,
    [CoeficienteCustoFinanceiro] numeric(25,22) NULL,
    [VlCustoAdic] numeric(13,2) NULL,
    [PercCustoAdic] numeric(5,4) NULL,
    [Vasilhame] bit NULL,
    [TpPedBonificacaoValorZero] bit NULL,
    [ValorICMSDesonerado] numeric(13,2) NULL,
    [ValorTaxaMarketplace] numeric(13,2) NULL,
    [PercTaxaMarketplace] numeric(7,4) NULL,
    [ValorMaximoPedidoComplementar] numeric(15,4) NULL,
    [PercPedidoComplementar] numeric(38,11) NULL,
    [SeqPedCli] smallint NULL,
    [CdTabela] char(8) NULL,
    [DataDevolucao] datetime NULL,
    [CdTextoObs] int NULL,
    [vl_mg_brt_crp] numeric(13,2) NULL,
    [vl_mg_brt_cmp] numeric(13,2) NULL,
    [vl_mg_brt_cue] numeric(13,2) NULL,
    [vl_venda_av] numeric(13,2) NULL,
    [VlVendaAvMargem] numeric(13,2) NULL,
    [vl_venda] numeric(13,2) NULL,
    [VlVendaMargem] numeric(13,2) NULL,
    [VlVendaApuracaoBonificacao] numeric(13,2) NULL
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
