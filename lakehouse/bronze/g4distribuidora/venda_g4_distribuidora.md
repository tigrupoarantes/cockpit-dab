<!-- generated: lakehouse-object -->
# bronze.venda_g4_distribuidora

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
| 3 | cd_emp_orc | int | True | False | False | - |
| 4 | nu_ped_orc | int | True | False | False | - |
| 5 | cd_vend | char(8) | True | False | False | - |
| 6 | cd_clien | int | False | False | False | - |
| 7 | distribuidor | bit | True | False | False | - |
| 8 | cd_clien_dist | int | True | False | False | - |
| 9 | seq_prom | int | True | False | False | - |
| 10 | perc_desc_geral | numeric(6,4) | True | False | False | - |
| 11 | vl_desc_geral | numeric(13,2) | True | False | False | - |
| 12 | perc_desc_fin | numeric(6,4) | True | False | False | - |
| 13 | vl_desc_fin | numeric(13,2) | True | False | False | - |
| 14 | nu_dias_desc_fin | smallint | True | False | False | - |
| 15 | tp_estab | char(2) | False | False | False | - |
| 16 | tp_ped | char(2) | True | False | False | - |
| 17 | dt_ped | smalldatetime | True | False | False | - |
| 18 | dt_cad | datetime | False | False | False | - |
| 19 | dt_prev_fatu | smalldatetime | True | False | False | - |
| 20 | dt_entrega | smalldatetime | True | False | False | - |
| 21 | cd_tabela | char(8) | True | False | False | - |
| 22 | vl_frete | numeric(13,2) | True | False | False | - |
| 23 | valor_tot | numeric(13,2) | True | False | False | - |
| 24 | peso_tot | numeric(13,2) | True | False | False | - |
| 25 | qtde_volumes | numeric(11,4) | True | False | False | - |
| 26 | qtde_fardos | numeric(11,4) | True | False | False | - |
| 27 | qtde_nao_fardos | numeric(11,4) | True | False | False | - |
| 28 | tp_midia | char(3) | True | False | False | - |
| 29 | cd_veic | char(4) | True | False | False | - |
| 30 | dt_inicio | smalldatetime | True | False | False | - |
| 31 | tp_entrega | char(2) | False | False | False | - |
| 32 | cd_forn | int | True | False | False | - |
| 33 | ent_outcli | bit | True | False | False | - |
| 34 | cd_clien_outcli | int | True | False | False | - |
| 35 | nu_ped_cli | varchar(35) | True | False | False | - |
| 36 | verificacao_cred | bit | True | False | False | - |
| 37 | nu_nf_inic_talao | int | True | False | False | - |
| 38 | nu_nf_fim_talao | int | True | False | False | - |
| 39 | placa_veiculo | char(8) | True | False | False | - |
| 40 | tp_frete | char(1) | True | False | False | - |
| 41 | tp_prod_ped | char(2) | True | False | False | - |
| 42 | consig_concluida | bit | True | False | False | - |
| 43 | formpgto | char(2) | False | False | False | - |
| 44 | cd_rot_prdf | char(8) | True | False | False | - |
| 45 | cfop | int | True | False | False | - |
| 46 | icms_diferido | tinyint | True | False | False | - |
| 47 | situacao | char(2) | False | False | False | - |
| 48 | cd_texto | int | True | False | False | - |
| 49 | cfop_sr | int | True | False | False | - |
| 50 | qtde_imp_sepa | int | True | False | False | - |
| 51 | qtde_imp_orca | tinyint | True | False | False | - |
| 52 | cliente_novo | tinyint | True | False | False | - |
| 53 | nu_nf_prt_entg | int | True | False | False | - |
| 54 | dt_emis_prt_entg | smalldatetime | True | False | False | - |
| 55 | dt_entrega_final | smalldatetime | True | False | False | - |
| 56 | nu_ped_orig_bon | int | True | False | False | - |
| 57 | cd_vend_lc | char(8) | True | False | False | - |
| 58 | perc_comis_vend | numeric(7,4) | False | False | False | - |
| 59 | perc_comis_lanc | numeric(7,4) | False | False | False | - |
| 60 | cd_vend_comis | char(8) | False | False | False | - |
| 61 | peso_tot_liq | numeric(13,2) | True | False | False | - |
| 62 | origem_pedido | char(1) | False | False | False | - |
| 63 | suframa | tinyint | False | False | False | - |
| 64 | cd_usr_separador | char(8) | True | False | False | - |
| 65 | dt_inic_sepa | smalldatetime | True | False | False | - |
| 66 | dt_fim_sepa | smalldatetime | True | False | False | - |
| 67 | lanc_cred_verba | char(4) | False | False | False | - |
| 68 | qtde_vol_ab | int | True | False | False | - |
| 69 | urgente | tinyint | True | False | False | - |
| 70 | cd_vend_verba | char(8) | True | False | False | - |
| 71 | qtde_vol_fe | int | True | False | False | - |
| 72 | seq_cont_cli | smallint | True | False | False | - |
| 73 | cd_emp_quebra_nf | int | True | False | False | - |
| 74 | nu_ped_quebra_nf | int | True | False | False | - |
| 75 | desm_quebra_nf | tinyint | True | False | False | - |
| 76 | prz_medio | numeric(6,2) | True | False | False | - |
| 77 | prev_vda_flx_caixa | tinyint | True | False | False | - |
| 78 | cd_grupo_prd | char(4) | True | False | False | - |
| 79 | tp_vl_base_comissao | char(4) | False | False | False | - |
| 80 | cd_vend_rt | char(8) | True | False | False | - |
| 81 | vl_comis_rt | numeric(13,2) | True | False | False | - |
| 82 | seq_lc_fatu | int | True | False | False | - |
| 83 | card_cred_numero | varchar(60) | True | False | False | - |
| 84 | card_cred_proprietario | varchar(60) | True | False | False | - |
| 85 | card_cred_tipo | varchar(20) | True | False | False | - |
| 86 | card_cred_complemento | varchar(4) | True | False | False | - |
| 87 | card_cred_dt_expiracao_mes | varchar(2) | True | False | False | - |
| 88 | card_cred_dt_expiracao_ano | varchar(4) | True | False | False | - |
| 89 | card_cred_cpf_proprietario | varchar(14) | True | False | False | - |
| 90 | cd_vend_serv_interno | char(8) | True | False | False | - |
| 91 | cd_vend_serv_tecnico | char(8) | True | False | False | - |
| 92 | vl_cust_frete | numeric(13,2) | True | False | False | - |
| 93 | st_remu_inst | char(2) | True | False | False | - |
| 94 | cd_forn_inst | int | True | False | False | - |
| 95 | dt_inst | smalldatetime | True | False | False | - |
| 96 | vl_custo_inst | numeric(13,2) | True | False | False | - |
| 97 | vl_remu_inst | numeric(13,2) | True | False | False | - |
| 98 | dt_pgto_inst | smalldatetime | True | False | False | - |
| 99 | vl_frete_nao_soma_ped | numeric(13,2) | True | False | False | - |
| 100 | cd_emp_original | int | True | False | False | - |
| 101 | nu_ped_original | int | True | False | False | - |
| 102 | qtde_imp_lmer | int | True | False | False | - |
| 103 | seq_trib_cli | int | True | False | False | - |
| 104 | sigla_separacao | char(3) | True | False | False | - |
| 105 | vl_desp_aces | numeric(13,2) | True | False | False | - |
| 107 | situacao_it_pedv | int | True | False | False | - |
| 108 | export_uf_embarque | char(2) | True | False | False | - |
| 109 | export_local_embarque | varchar(60) | True | False | False | - |
| 110 | import_vl_siscomex | numeric(13,2) | True | False | False | - |
| 111 | import_aliq_ii | numeric(6,4) | True | False | False | - |
| 112 | wms_transf_end_final | tinyint | True | False | False | - |
| 113 | lote_reservado | tinyint | True | False | False | - |
| 114 | sepa_hibrida_pedido | bit | True | False | False | - |
| 115 | VlTotNf | numeric(13,2) | True | False | False | - |
| 116 | PercDescGerAuto | numeric(13,4) | True | False | False | - |
| 117 | RotPrdfDiaDiarioID | int | True | False | False | - |
| 118 | CdDoca | char(5) | True | False | False | - |
| 119 | VlFreteAlteradoManual | bit | True | False | False | - |
| 120 | EntOutCli | bit | True | False | False | - |
| 121 | CdClienOutCli | int | True | False | False | - |
| 122 | InicioProcessoFatura | bit | True | False | False | - |
| 123 | DescricaoVan | varchar(100) | True | False | False | - |
| 124 | ExportLocDespacho | varchar(60) | True | False | False | - |
| 125 | CpfCnpjConsumidorFinal | varchar(14) | True | False | False | - |
| 126 | TipoPessoaIDConsumidorFinal | tinyint | True | False | False | - |
| 127 | InicioProcessoCorte | bit | False | False | False | - |
| 128 | PedVdaID | int | False | False | False | - |
| 129 | InicioProcessoSeparacao | bit | False | False | False | - |
| 130 | reentrega | bit | False | False | False | - |
| 131 | cdClienFatura | int | True | False | False | - |
| 132 | cdClienPagamento | int | True | False | False | - |
| 133 | cdClienAtacadista | int | True | False | False | - |
| 134 | emailTransferAtacadistaGerado | bit | True | False | False | - |
| 135 | emailTransferAtacadistaStatus | tinyint | True | False | False | - |
| 136 | SeqTribRegEmp | tinyint | True | False | False | - |
| 137 | PermiteFaturarSemLogEncerrada | bit | True | False | False | - |
| 138 | VlJuros | numeric(13,4) | True | False | False | - |
| 139 | VlTaxaContrato | numeric(13,4) | True | False | False | - |
| 140 | IntermediadorID | int | True | False | False | - |
| 141 | BandeiraID | int | True | False | False | - |
| 142 | CdGrupo | char(4) | True | False | False | - |
| 143 | DivisaoComissaoModeloID | tinyint | True | False | False | - |
| 144 | PercComisFixoLancador | numeric(7,4) | True | False | False | - |
| 145 | DivisaoComissaoVendedorPrincipalID | tinyint | True | False | False | - |
| 146 | PercComisVendedorPosRateio | numeric(7,4) | True | False | False | - |
| 147 | SeparacaoOnda | bit | True | False | False | - |
| 148 | ValorCupom | numeric(13,2) | True | False | False | - |
| 149 | NfRecmIDVerbaFabricante | int | True | False | False | - |
| 150 | TgtCRM_nu_ped_crm | varchar(30) | True | False | False | - |
| 151 | TgtCRM_status | int | True | False | False | - |
| 152 | EntregaHorarioDe | smalldatetime | True | False | False | - |
| 153 | EntregaHorarioAte | smalldatetime | True | False | False | - |
| 154 | Cortado | bit | False | False | False | - |
| 155 | DiasAteEntrega | int | True | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL Reconstruida

```sql
CREATE TABLE [bronze].[venda_g4_distribuidora] (
    [cd_emp] int NOT NULL,
    [nu_ped] int NOT NULL,
    [cd_emp_orc] int NULL,
    [nu_ped_orc] int NULL,
    [cd_vend] char(8) NULL,
    [cd_clien] int NOT NULL,
    [distribuidor] bit NULL,
    [cd_clien_dist] int NULL,
    [seq_prom] int NULL,
    [perc_desc_geral] numeric(6,4) NULL,
    [vl_desc_geral] numeric(13,2) NULL,
    [perc_desc_fin] numeric(6,4) NULL,
    [vl_desc_fin] numeric(13,2) NULL,
    [nu_dias_desc_fin] smallint NULL,
    [tp_estab] char(2) NOT NULL,
    [tp_ped] char(2) NULL,
    [dt_ped] smalldatetime NULL,
    [dt_cad] datetime NOT NULL,
    [dt_prev_fatu] smalldatetime NULL,
    [dt_entrega] smalldatetime NULL,
    [cd_tabela] char(8) NULL,
    [vl_frete] numeric(13,2) NULL,
    [valor_tot] numeric(13,2) NULL,
    [peso_tot] numeric(13,2) NULL,
    [qtde_volumes] numeric(11,4) NULL,
    [qtde_fardos] numeric(11,4) NULL,
    [qtde_nao_fardos] numeric(11,4) NULL,
    [tp_midia] char(3) NULL,
    [cd_veic] char(4) NULL,
    [dt_inicio] smalldatetime NULL,
    [tp_entrega] char(2) NOT NULL,
    [cd_forn] int NULL,
    [ent_outcli] bit NULL,
    [cd_clien_outcli] int NULL,
    [nu_ped_cli] varchar(35) NULL,
    [verificacao_cred] bit NULL,
    [nu_nf_inic_talao] int NULL,
    [nu_nf_fim_talao] int NULL,
    [placa_veiculo] char(8) NULL,
    [tp_frete] char(1) NULL,
    [tp_prod_ped] char(2) NULL,
    [consig_concluida] bit NULL,
    [formpgto] char(2) NOT NULL,
    [cd_rot_prdf] char(8) NULL,
    [cfop] int NULL,
    [icms_diferido] tinyint NULL,
    [situacao] char(2) NOT NULL,
    [cd_texto] int NULL,
    [cfop_sr] int NULL,
    [qtde_imp_sepa] int NULL,
    [qtde_imp_orca] tinyint NULL,
    [cliente_novo] tinyint NULL,
    [nu_nf_prt_entg] int NULL,
    [dt_emis_prt_entg] smalldatetime NULL,
    [dt_entrega_final] smalldatetime NULL,
    [nu_ped_orig_bon] int NULL,
    [cd_vend_lc] char(8) NULL,
    [perc_comis_vend] numeric(7,4) NOT NULL,
    [perc_comis_lanc] numeric(7,4) NOT NULL,
    [cd_vend_comis] char(8) NOT NULL,
    [peso_tot_liq] numeric(13,2) NULL,
    [origem_pedido] char(1) NOT NULL,
    [suframa] tinyint NOT NULL,
    [cd_usr_separador] char(8) NULL,
    [dt_inic_sepa] smalldatetime NULL,
    [dt_fim_sepa] smalldatetime NULL,
    [lanc_cred_verba] char(4) NOT NULL,
    [qtde_vol_ab] int NULL,
    [urgente] tinyint NULL,
    [cd_vend_verba] char(8) NULL,
    [qtde_vol_fe] int NULL,
    [seq_cont_cli] smallint NULL,
    [cd_emp_quebra_nf] int NULL,
    [nu_ped_quebra_nf] int NULL,
    [desm_quebra_nf] tinyint NULL,
    [prz_medio] numeric(6,2) NULL,
    [prev_vda_flx_caixa] tinyint NULL,
    [cd_grupo_prd] char(4) NULL,
    [tp_vl_base_comissao] char(4) NOT NULL,
    [cd_vend_rt] char(8) NULL,
    [vl_comis_rt] numeric(13,2) NULL,
    [seq_lc_fatu] int NULL,
    [card_cred_numero] varchar(60) NULL,
    [card_cred_proprietario] varchar(60) NULL,
    [card_cred_tipo] varchar(20) NULL,
    [card_cred_complemento] varchar(4) NULL,
    [card_cred_dt_expiracao_mes] varchar(2) NULL,
    [card_cred_dt_expiracao_ano] varchar(4) NULL,
    [card_cred_cpf_proprietario] varchar(14) NULL,
    [cd_vend_serv_interno] char(8) NULL,
    [cd_vend_serv_tecnico] char(8) NULL,
    [vl_cust_frete] numeric(13,2) NULL,
    [st_remu_inst] char(2) NULL,
    [cd_forn_inst] int NULL,
    [dt_inst] smalldatetime NULL,
    [vl_custo_inst] numeric(13,2) NULL,
    [vl_remu_inst] numeric(13,2) NULL,
    [dt_pgto_inst] smalldatetime NULL,
    [vl_frete_nao_soma_ped] numeric(13,2) NULL,
    [cd_emp_original] int NULL,
    [nu_ped_original] int NULL,
    [qtde_imp_lmer] int NULL,
    [seq_trib_cli] int NULL,
    [sigla_separacao] char(3) NULL,
    [vl_desp_aces] numeric(13,2) NULL,
    [situacao_it_pedv] int NULL,
    [export_uf_embarque] char(2) NULL,
    [export_local_embarque] varchar(60) NULL,
    [import_vl_siscomex] numeric(13,2) NULL,
    [import_aliq_ii] numeric(6,4) NULL,
    [wms_transf_end_final] tinyint NULL,
    [lote_reservado] tinyint NULL,
    [sepa_hibrida_pedido] bit NULL,
    [VlTotNf] numeric(13,2) NULL,
    [PercDescGerAuto] numeric(13,4) NULL,
    [RotPrdfDiaDiarioID] int NULL,
    [CdDoca] char(5) NULL,
    [VlFreteAlteradoManual] bit NULL,
    [EntOutCli] bit NULL,
    [CdClienOutCli] int NULL,
    [InicioProcessoFatura] bit NULL,
    [DescricaoVan] varchar(100) NULL,
    [ExportLocDespacho] varchar(60) NULL,
    [CpfCnpjConsumidorFinal] varchar(14) NULL,
    [TipoPessoaIDConsumidorFinal] tinyint NULL,
    [InicioProcessoCorte] bit NOT NULL,
    [PedVdaID] int NOT NULL,
    [InicioProcessoSeparacao] bit NOT NULL,
    [reentrega] bit NOT NULL,
    [cdClienFatura] int NULL,
    [cdClienPagamento] int NULL,
    [cdClienAtacadista] int NULL,
    [emailTransferAtacadistaGerado] bit NULL,
    [emailTransferAtacadistaStatus] tinyint NULL,
    [SeqTribRegEmp] tinyint NULL,
    [PermiteFaturarSemLogEncerrada] bit NULL,
    [VlJuros] numeric(13,4) NULL,
    [VlTaxaContrato] numeric(13,4) NULL,
    [IntermediadorID] int NULL,
    [BandeiraID] int NULL,
    [CdGrupo] char(4) NULL,
    [DivisaoComissaoModeloID] tinyint NULL,
    [PercComisFixoLancador] numeric(7,4) NULL,
    [DivisaoComissaoVendedorPrincipalID] tinyint NULL,
    [PercComisVendedorPosRateio] numeric(7,4) NULL,
    [SeparacaoOnda] bit NULL,
    [ValorCupom] numeric(13,2) NULL,
    [NfRecmIDVerbaFabricante] int NULL,
    [TgtCRM_nu_ped_crm] varchar(30) NULL,
    [TgtCRM_status] int NULL,
    [EntregaHorarioDe] smalldatetime NULL,
    [EntregaHorarioAte] smalldatetime NULL,
    [Cortado] bit NOT NULL,
    [DiasAteEntrega] int NULL
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
