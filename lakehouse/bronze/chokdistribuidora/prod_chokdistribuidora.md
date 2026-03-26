<!-- generated: lakehouse-object -->
# bronze.prod_chokdistribuidora

- Tipo: `TABLE`
- Industria: `chokdistribuidora`
- Origem: `database:GA_DATALAKE`
- PKs: Nao identificado no banco
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | cd_prod | int | False | False | False | - |
| 2 | tp_prod | char(2) | False | False | False | - |
| 3 | descricao | varchar(120) | False | False | False | - |
| 4 | desc_resum | varchar(20) | False | False | False | - |
| 5 | cd_barra | varchar(14) | True | False | False | - |
| 6 | cd_linha | char(4) | False | False | False | - |
| 7 | cd_cor | char(10) | True | False | False | - |
| 8 | fardo | bit | True | False | False | - |
| 9 | inf_volumes | bit | True | False | False | - |
| 10 | venda | bit | True | False | False | - |
| 11 | compra | bit | True | False | False | - |
| 12 | produzido | bit | True | False | False | - |
| 13 | conjunto | bit | True | False | False | - |
| 14 | cd_fabric | char(6) | False | False | False | - |
| 15 | controle_lote | bit | True | False | False | - |
| 16 | reg_ms | char(20) | True | False | False | - |
| 17 | unid_est | char(2) | False | False | False | - |
| 18 | unid_cmp | char(2) | False | False | False | - |
| 19 | qtde_unid_cmp | float | False | False | False | - |
| 20 | peso_brt | numeric(7,3) | False | False | False | - |
| 21 | peso_liq | numeric(7,3) | False | False | False | - |
| 22 | gramatura | int | True | False | False | - |
| 23 | comprimento | int | True | False | False | - |
| 24 | largura | int | True | False | False | - |
| 25 | num_folhas | int | True | False | False | - |
| 26 | aliq_ipi | float | True | False | False | - |
| 27 | aliq_ipi_cortado | numeric(6,4) | True | False | False | - |
| 28 | cl_fisc | char(2) | True | False | False | - |
| 29 | perc_ipi_compra | numeric(6,4) | True | False | False | - |
| 30 | preco | numeric(13,2) | True | False | False | - |
| 31 | vl_base_produto | numeric(13,2) | True | False | False | - |
| 32 | importado | bit | True | False | False | - |
| 33 | dt_cad | smalldatetime | False | False | False | - |
| 34 | sit_emissao | char(2) | True | False | False | - |
| 35 | volume | numeric(16,10) | True | False | False | - |
| 36 | controlado | bit | True | False | False | - |
| 37 | cd_texto | int | True | False | False | - |
| 38 | pesado | tinyint | True | False | False | - |
| 39 | num_lock | int | False | False | False | - |
| 40 | ativo | bit | True | False | False | - |
| 41 | cd_prod_clien | varchar(30) | True | False | False | - |
| 42 | desc_internacional | varchar(120) | True | False | False | - |
| 43 | cd_ctactb | char(5) | True | False | False | - |
| 44 | cd_cl_gsas | char(10) | True | False | False | - |
| 45 | ctr_nu_serie | tinyint | True | False | False | - |
| 46 | pesado_nf | tinyint | True | False | False | - |
| 47 | icms_diferido | tinyint | True | False | False | - |
| 48 | cl_fisc_diferido | char(2) | True | False | False | - |
| 49 | qtde_base | numeric(13,4) | True | False | False | - |
| 50 | fracao_min | numeric(4,0) | True | False | False | - |
| 51 | substrib_icms_compra | tinyint | True | False | False | - |
| 52 | margem_icms_st_compra | numeric(7,4) | True | False | False | - |
| 53 | desc_nf | varchar(120) | True | False | False | - |
| 54 | perc_ii | numeric(7,4) | True | False | False | - |
| 55 | vl_ipi_cmp_fixo | numeric(17,6) | True | False | False | - |
| 56 | cd_prod_fabric | varchar(30) | True | False | False | - |
| 57 | qtde_unid | int | True | False | False | - |
| 58 | tp_prazo_valid | char(3) | True | False | False | - |
| 59 | prazo_valid | numeric(9,0) | True | False | False | - |
| 60 | qtde_min_transf_est | int | True | False | False | - |
| 61 | enviar_arq_fabr | tinyint | False | False | False | - |
| 62 | conteudo_unid | char(6) | True | False | False | - |
| 63 | tp_cd_barra | varchar(5) | True | False | False | - |
| 64 | tp_cd_barra_compra | varchar(5) | True | False | False | - |
| 65 | cd_barra_compra | varchar(14) | True | False | False | - |
| 66 | fator_est_consumo | numeric(7,4) | True | False | False | - |
| 67 | ind_rel_consumo | char(5) | True | False | False | - |
| 68 | preco_fixo | tinyint | True | False | False | - |
| 69 | qtde_multipla | numeric(13,4) | True | False | False | - |
| 70 | bloq_envio_palm_top | tinyint | True | False | False | - |
| 71 | cd_grupoest | char(8) | True | False | False | - |
| 72 | qtde_minima | numeric(7,3) | True | False | False | - |
| 73 | caixa_fechada | int | True | False | False | - |
| 74 | arq_txtped | tinyint | True | False | False | - |
| 75 | calculo_rentabilidade | tinyint | True | False | False | - |
| 76 | vl_preco_minimo | numeric(15,4) | True | False | False | - |
| 77 | situacao_especial | tinyint | True | False | False | - |
| 78 | dt_classe_prd | smalldatetime | True | False | False | - |
| 79 | id_prod_ctrl | char(3) | True | False | False | - |
| 80 | obs_prod_ctr | varchar(40) | True | False | False | - |
| 81 | concentracao | varchar(30) | True | False | False | - |
| 82 | qtde_lim_prd_ctr | numeric(13,4) | True | False | False | - |
| 83 | cd_prod_ncm | char(10) | True | False | False | - |
| 84 | cd_trib_pdv | char(3) | True | False | False | - |
| 85 | cd_dif | int | True | False | False | - |
| 86 | ordem_tab_pre | int | True | False | False | - |
| 87 | exige_doc_anvisa | tinyint | True | False | False | - |
| 88 | cl_trib_medic | char(1) | True | False | False | - |
| 89 | enviar_arq_wms | tinyint | True | False | False | - |
| 90 | altura_vol_est | numeric(10,4) | True | False | False | - |
| 91 | compr_vol_est | numeric(10,4) | True | False | False | - |
| 92 | largura_vol_est | numeric(10,4) | True | False | False | - |
| 93 | altura_vol_cmp | numeric(10,4) | True | False | False | - |
| 94 | compr_vol_cmp | numeric(10,4) | True | False | False | - |
| 95 | largura_vol_cmp | numeric(10,4) | True | False | False | - |
| 96 | altura_vol_pl | numeric(10,4) | True | False | False | - |
| 97 | compr_vol_pl | numeric(10,4) | True | False | False | - |
| 98 | largura_vol_pl | numeric(10,4) | True | False | False | - |
| 99 | bloq_admv | tinyint | True | False | False | - |
| 100 | exige_alvara_vig_san | tinyint | True | False | False | - |
| 101 | exige_conf_eletr | tinyint | True | False | False | - |
| 102 | cd_grp_desp_vda | char(8) | True | False | False | - |
| 103 | cd_texto_alerta | int | True | False | False | - |
| 104 | desc_compl_nf | varchar(120) | True | False | False | - |
| 105 | dt_validade_ms | smalldatetime | True | False | False | - |
| 106 | volume_subs_ctr | numeric(16,10) | True | False | False | - |
| 107 | path_imagem | varchar(100) | True | False | False | - |
| 108 | prz_medio_max | smallint | True | False | False | - |
| 109 | prazo_valid_direcionado | int | True | False | False | - |
| 110 | cd_grupo_prd | char(4) | True | False | False | - |
| 111 | cd_emp | int | True | False | False | - |
| 112 | subst_trib_prc_max_cmp | tinyint | True | False | False | - |
| 113 | venda_casada | tinyint | True | False | False | - |
| 114 | bloq_envia_ped_dir | tinyint | True | False | False | - |
| 115 | imp_dif_rom_sepa | tinyint | True | False | False | - |
| 116 | brinde | tinyint | True | False | False | - |
| 117 | sepa_vol_nao_perm_cx_fe | tinyint | True | False | False | - |
| 118 | lib_fiscal | bit | True | False | False | - |
| 119 | excecao_trib_ncm | bit | True | False | False | - |
| 120 | cd_ex_tipi | char(3) | True | False | False | - |
| 121 | tp_medic | int | True | False | False | - |
| 122 | exibe_ori_comp | bit | True | False | False | - |
| 123 | qtde_dias_valid_minima | int | True | False | False | - |
| 124 | perc_mg_ct | numeric(7,4) | True | False | False | - |
| 125 | perc_mg_br | numeric(7,4) | True | False | False | - |
| 126 | seq_padrao_cd_barra_lote | int | True | False | False | - |
| 127 | cd_subst | varchar(10) | True | False | False | - |
| 128 | desc_prod_fabric | varchar(60) | True | False | False | - |
| 129 | envia_pdv_bmc | bit | True | False | False | - |
| 131 | envia_pdv_cgm | bit | True | False | False | - |
| 132 | aliq_pis | numeric(7,4) | True | False | False | - |
| 133 | aliq_cofins | numeric(7,4) | True | False | False | - |
| 134 | seq_cst_entrada | smallint | True | False | False | - |
| 135 | seq_cst_saida | smallint | True | False | False | - |
| 136 | toler_pesagem_pc | numeric(7,4) | True | False | False | - |
| 137 | seq_cst_tp_cred | int | True | False | False | - |
| 138 | seq_cst_base_cred | int | True | False | False | - |
| 139 | seq_cst_nat_receita | int | True | False | False | - |
| 140 | cst_tp_contrib | char(1) | True | False | False | - |
| 141 | excecao_trib_ncm_pis_cofins | bit | True | False | False | - |
| 142 | ModeloID | int | True | False | False | - |
| 143 | EquiFiscal | bit | True | False | False | - |
| 144 | NumeroFCI | varchar(36) | True | False | False | - |
| 145 | PercImportacao | numeric(6,4) | True | False | False | - |
| 146 | envia_pdv_tgt | bit | True | False | False | - |
| 147 | PrazoValidDias | numeric(20,0) | True | False | False | - |
| 148 | ProdutoID | int | False | False | False | - |
| 149 | pis_cof_antec | tinyint | True | False | False | - |
| 150 | CstIpiIDEntrada | smallint | True | False | False | - |
| 151 | CstIpiIDSaida | smallint | True | False | False | - |
| 152 | CstIpiIDDevForn | smallint | True | False | False | - |
| 153 | ProdTpFiscalID | char(2) | False | False | False | - |
| 154 | BonifClassifContabilID | int | True | False | False | - |
| 155 | IpiEnquadIDSaida | smallint | True | False | False | - |
| 156 | IpiEnquadIDEntrada | smallint | True | False | False | - |
| 157 | IpiEnquadIDDevForn | smallint | True | False | False | - |
| 158 | CestID | int | True | False | False | - |
| 159 | CestExcecaoNCM | bit | False | False | False | - |
| 160 | PadraoMedicamento | bit | True | False | False | - |
| 161 | ConsideraLote | bit | True | False | False | - |
| 162 | AgrupaValidadesPicking | bit | False | False | False | - |
| 163 | VendaSomentePromocao | bit | False | False | False | - |
| 164 | BonificacaoSomentePromocao | bit | False | False | False | - |
| 165 | PercentualReducaoBasePisCofins | numeric(7,4) | True | False | False | - |
| 166 | Observacao | varchar(max) | True | False | False | - |
| 167 | RessarcimentoSTExcecao | bit | True | False | False | - |
| 168 | UtilizaValidadeLoteSepa | bit | False | False | False | - |
| 169 | CodigoANP | int | True | False | False | - |
| 170 | CodigoServico | varchar(8) | True | False | False | - |
| 171 | MotivoIsencaoANVISA | varchar(255) | True | False | False | - |
| 172 | bloq_gerv | bit | True | False | False | - |
| 173 | seqCodBarr | varchar(2) | True | False | False | - |
| 174 | DescGeralProd | bit | True | False | False | - |
| 175 | Litro | numeric(7,3) | True | False | False | - |
| 176 | Vasilhame | bit | True | False | False | - |
| 177 | PerfilVasilhameID | int | True | False | False | - |
| 178 | Conservadora | bit | True | False | False | - |
| 179 | BloqEnvioMarketplace | bit | False | False | False | - |
| 180 | ValorPautaPis | numeric(15,4) | True | False | False | - |
| 181 | ValorPautaCofins | numeric(15,4) | True | False | False | - |
| 182 | CodigoANPNFSaida | int | True | False | False | - |
| 183 | Esteril | bit | False | False | False | - |
| 184 | LoteInternoUnico | bit | False | False | False | - |
| 185 | AtualizadoSystax | bit | True | False | False | - |
| 186 | DataUltimaAtualizacaoSystax | date | True | False | False | - |
| 187 | OrigemProdutoId | smallint | True | False | False | - |
| 188 | IndenizacaoMobPrazoExibir | int | True | False | False | - |
| 189 | Descontinuado | bit | True | False | False | - |
| 190 | NumeroSerieAuto | bit | False | False | False | - |
| 191 | ControlarLoteInterno | bit | False | False | False | - |
| 192 | TipoAtualizacaoCurvaABCID | tinyint | True | False | False | - |
| 193 | BloqEnvioEcommerce | bit | True | False | False | - |
| 194 | ControlePalete | bit | False | False | False | - |
| 195 | Subproduto | bit | False | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL Reconstruida

```sql
CREATE TABLE [bronze].[prod_chokdistribuidora] (
    [cd_prod] int NOT NULL,
    [tp_prod] char(2) NOT NULL,
    [descricao] varchar(120) NOT NULL,
    [desc_resum] varchar(20) NOT NULL,
    [cd_barra] varchar(14) NULL,
    [cd_linha] char(4) NOT NULL,
    [cd_cor] char(10) NULL,
    [fardo] bit NULL,
    [inf_volumes] bit NULL,
    [venda] bit NULL,
    [compra] bit NULL,
    [produzido] bit NULL,
    [conjunto] bit NULL,
    [cd_fabric] char(6) NOT NULL,
    [controle_lote] bit NULL,
    [reg_ms] char(20) NULL,
    [unid_est] char(2) NOT NULL,
    [unid_cmp] char(2) NOT NULL,
    [qtde_unid_cmp] float NOT NULL,
    [peso_brt] numeric(7,3) NOT NULL,
    [peso_liq] numeric(7,3) NOT NULL,
    [gramatura] int NULL,
    [comprimento] int NULL,
    [largura] int NULL,
    [num_folhas] int NULL,
    [aliq_ipi] float NULL,
    [aliq_ipi_cortado] numeric(6,4) NULL,
    [cl_fisc] char(2) NULL,
    [perc_ipi_compra] numeric(6,4) NULL,
    [preco] numeric(13,2) NULL,
    [vl_base_produto] numeric(13,2) NULL,
    [importado] bit NULL,
    [dt_cad] smalldatetime NOT NULL,
    [sit_emissao] char(2) NULL,
    [volume] numeric(16,10) NULL,
    [controlado] bit NULL,
    [cd_texto] int NULL,
    [pesado] tinyint NULL,
    [num_lock] int NOT NULL,
    [ativo] bit NULL,
    [cd_prod_clien] varchar(30) NULL,
    [desc_internacional] varchar(120) NULL,
    [cd_ctactb] char(5) NULL,
    [cd_cl_gsas] char(10) NULL,
    [ctr_nu_serie] tinyint NULL,
    [pesado_nf] tinyint NULL,
    [icms_diferido] tinyint NULL,
    [cl_fisc_diferido] char(2) NULL,
    [qtde_base] numeric(13,4) NULL,
    [fracao_min] numeric(4,0) NULL,
    [substrib_icms_compra] tinyint NULL,
    [margem_icms_st_compra] numeric(7,4) NULL,
    [desc_nf] varchar(120) NULL,
    [perc_ii] numeric(7,4) NULL,
    [vl_ipi_cmp_fixo] numeric(17,6) NULL,
    [cd_prod_fabric] varchar(30) NULL,
    [qtde_unid] int NULL,
    [tp_prazo_valid] char(3) NULL,
    [prazo_valid] numeric(9,0) NULL,
    [qtde_min_transf_est] int NULL,
    [enviar_arq_fabr] tinyint NOT NULL,
    [conteudo_unid] char(6) NULL,
    [tp_cd_barra] varchar(5) NULL,
    [tp_cd_barra_compra] varchar(5) NULL,
    [cd_barra_compra] varchar(14) NULL,
    [fator_est_consumo] numeric(7,4) NULL,
    [ind_rel_consumo] char(5) NULL,
    [preco_fixo] tinyint NULL,
    [qtde_multipla] numeric(13,4) NULL,
    [bloq_envio_palm_top] tinyint NULL,
    [cd_grupoest] char(8) NULL,
    [qtde_minima] numeric(7,3) NULL,
    [caixa_fechada] int NULL,
    [arq_txtped] tinyint NULL,
    [calculo_rentabilidade] tinyint NULL,
    [vl_preco_minimo] numeric(15,4) NULL,
    [situacao_especial] tinyint NULL,
    [dt_classe_prd] smalldatetime NULL,
    [id_prod_ctrl] char(3) NULL,
    [obs_prod_ctr] varchar(40) NULL,
    [concentracao] varchar(30) NULL,
    [qtde_lim_prd_ctr] numeric(13,4) NULL,
    [cd_prod_ncm] char(10) NULL,
    [cd_trib_pdv] char(3) NULL,
    [cd_dif] int NULL,
    [ordem_tab_pre] int NULL,
    [exige_doc_anvisa] tinyint NULL,
    [cl_trib_medic] char(1) NULL,
    [enviar_arq_wms] tinyint NULL,
    [altura_vol_est] numeric(10,4) NULL,
    [compr_vol_est] numeric(10,4) NULL,
    [largura_vol_est] numeric(10,4) NULL,
    [altura_vol_cmp] numeric(10,4) NULL,
    [compr_vol_cmp] numeric(10,4) NULL,
    [largura_vol_cmp] numeric(10,4) NULL,
    [altura_vol_pl] numeric(10,4) NULL,
    [compr_vol_pl] numeric(10,4) NULL,
    [largura_vol_pl] numeric(10,4) NULL,
    [bloq_admv] tinyint NULL,
    [exige_alvara_vig_san] tinyint NULL,
    [exige_conf_eletr] tinyint NULL,
    [cd_grp_desp_vda] char(8) NULL,
    [cd_texto_alerta] int NULL,
    [desc_compl_nf] varchar(120) NULL,
    [dt_validade_ms] smalldatetime NULL,
    [volume_subs_ctr] numeric(16,10) NULL,
    [path_imagem] varchar(100) NULL,
    [prz_medio_max] smallint NULL,
    [prazo_valid_direcionado] int NULL,
    [cd_grupo_prd] char(4) NULL,
    [cd_emp] int NULL,
    [subst_trib_prc_max_cmp] tinyint NULL,
    [venda_casada] tinyint NULL,
    [bloq_envia_ped_dir] tinyint NULL,
    [imp_dif_rom_sepa] tinyint NULL,
    [brinde] tinyint NULL,
    [sepa_vol_nao_perm_cx_fe] tinyint NULL,
    [lib_fiscal] bit NULL,
    [excecao_trib_ncm] bit NULL,
    [cd_ex_tipi] char(3) NULL,
    [tp_medic] int NULL,
    [exibe_ori_comp] bit NULL,
    [qtde_dias_valid_minima] int NULL,
    [perc_mg_ct] numeric(7,4) NULL,
    [perc_mg_br] numeric(7,4) NULL,
    [seq_padrao_cd_barra_lote] int NULL,
    [cd_subst] varchar(10) NULL,
    [desc_prod_fabric] varchar(60) NULL,
    [envia_pdv_bmc] bit NULL,
    [envia_pdv_cgm] bit NULL,
    [aliq_pis] numeric(7,4) NULL,
    [aliq_cofins] numeric(7,4) NULL,
    [seq_cst_entrada] smallint NULL,
    [seq_cst_saida] smallint NULL,
    [toler_pesagem_pc] numeric(7,4) NULL,
    [seq_cst_tp_cred] int NULL,
    [seq_cst_base_cred] int NULL,
    [seq_cst_nat_receita] int NULL,
    [cst_tp_contrib] char(1) NULL,
    [excecao_trib_ncm_pis_cofins] bit NULL,
    [ModeloID] int NULL,
    [EquiFiscal] bit NULL,
    [NumeroFCI] varchar(36) NULL,
    [PercImportacao] numeric(6,4) NULL,
    [envia_pdv_tgt] bit NULL,
    [PrazoValidDias] numeric(20,0) NULL,
    [ProdutoID] int NOT NULL,
    [pis_cof_antec] tinyint NULL,
    [CstIpiIDEntrada] smallint NULL,
    [CstIpiIDSaida] smallint NULL,
    [CstIpiIDDevForn] smallint NULL,
    [ProdTpFiscalID] char(2) NOT NULL,
    [BonifClassifContabilID] int NULL,
    [IpiEnquadIDSaida] smallint NULL,
    [IpiEnquadIDEntrada] smallint NULL,
    [IpiEnquadIDDevForn] smallint NULL,
    [CestID] int NULL,
    [CestExcecaoNCM] bit NOT NULL,
    [PadraoMedicamento] bit NULL,
    [ConsideraLote] bit NULL,
    [AgrupaValidadesPicking] bit NOT NULL,
    [VendaSomentePromocao] bit NOT NULL,
    [BonificacaoSomentePromocao] bit NOT NULL,
    [PercentualReducaoBasePisCofins] numeric(7,4) NULL,
    [Observacao] varchar(max) NULL,
    [RessarcimentoSTExcecao] bit NULL,
    [UtilizaValidadeLoteSepa] bit NOT NULL,
    [CodigoANP] int NULL,
    [CodigoServico] varchar(8) NULL,
    [MotivoIsencaoANVISA] varchar(255) NULL,
    [bloq_gerv] bit NULL,
    [seqCodBarr] varchar(2) NULL,
    [DescGeralProd] bit NULL,
    [Litro] numeric(7,3) NULL,
    [Vasilhame] bit NULL,
    [PerfilVasilhameID] int NULL,
    [Conservadora] bit NULL,
    [BloqEnvioMarketplace] bit NOT NULL,
    [ValorPautaPis] numeric(15,4) NULL,
    [ValorPautaCofins] numeric(15,4) NULL,
    [CodigoANPNFSaida] int NULL,
    [Esteril] bit NOT NULL,
    [LoteInternoUnico] bit NOT NULL,
    [AtualizadoSystax] bit NULL,
    [DataUltimaAtualizacaoSystax] date NULL,
    [OrigemProdutoId] smallint NULL,
    [IndenizacaoMobPrazoExibir] int NULL,
    [Descontinuado] bit NULL,
    [NumeroSerieAuto] bit NOT NULL,
    [ControlarLoteInterno] bit NOT NULL,
    [TipoAtualizacaoCurvaABCID] tinyint NULL,
    [BloqEnvioEcommerce] bit NULL,
    [ControlePalete] bit NOT NULL,
    [Subproduto] bit NOT NULL
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
