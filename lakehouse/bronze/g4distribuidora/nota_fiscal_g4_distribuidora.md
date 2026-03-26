<!-- generated: lakehouse-object -->
# bronze.nota_fiscal_g4_distribuidora

- Tipo: `TABLE`
- Industria: `g4distribuidora`
- Origem: `database:GA_DATALAKE`
- PKs: Nao identificado no banco
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | nu_nf | int | False | False | False | - |
| 2 | desc_nat_oper | varchar(60) | True | False | False | - |
| 3 | insc_subst | varchar(20) | True | False | False | - |
| 4 | cd_clien | int | True | False | False | - |
| 5 | nome | varchar(60) | True | False | False | - |
| 6 | tp_pes | char(1) | True | False | False | - |
| 7 | cgc_cpf | varchar(14) | True | False | False | - |
| 8 | endereco | varchar(140) | True | False | False | - |
| 9 | bairro | varchar(60) | True | False | False | - |
| 10 | cep | int | True | False | False | - |
| 11 | municipio | varchar(60) | True | False | False | - |
| 12 | ddd | varchar(4) | True | False | False | - |
| 13 | nu_tel | bigint | True | False | False | - |
| 14 | estado | char(2) | True | False | False | - |
| 15 | inscricao | varchar(20) | True | False | False | - |
| 16 | cd_emp | int | True | False | False | - |
| 17 | nu_ped | int | True | False | False | - |
| 18 | nu_ped_cli | varchar(35) | True | False | False | - |
| 19 | cd_vend | char(8) | True | False | False | - |
| 20 | dt_ped | smalldatetime | True | False | False | - |
| 21 | dt_emis | smalldatetime | True | False | False | - |
| 22 | dt_ent_saida | smalldatetime | True | False | False | - |
| 23 | hor_saida | smalldatetime | True | False | False | - |
| 24 | cond_pagto | char(30) | True | False | False | - |
| 25 | vl_prod | numeric(13,2) | True | False | False | - |
| 26 | vl_tot_serv | money | True | False | False | - |
| 27 | vl_desc | numeric(13,2) | True | False | False | - |
| 28 | vl_desc_geral | numeric(13,2) | True | False | False | - |
| 29 | vl_desc_fin | numeric(13,2) | True | False | False | - |
| 30 | perc_desc_fin | numeric(6,4) | True | False | False | - |
| 31 | str_dias_desc_fin | varchar(40) | True | False | False | - |
| 32 | aliq_icm | numeric(6,4) | True | False | False | - |
| 33 | vl_icm | numeric(13,2) | True | False | False | - |
| 34 | vl_icm_subst | numeric(13,2) | True | False | False | - |
| 35 | vl_ipi | numeric(13,2) | True | False | False | - |
| 36 | vl_iss | numeric(13,2) | True | False | False | - |
| 37 | vl_desp_aces | numeric(13,2) | True | False | False | - |
| 38 | base_icm | numeric(13,2) | True | False | False | - |
| 39 | base_icm_subst | numeric(13,2) | True | False | False | - |
| 40 | base_iss | numeric(13,2) | True | False | False | - |
| 41 | tp_frete | tinyint | True | False | False | - |
| 42 | vl_frete | numeric(13,2) | True | False | False | - |
| 43 | aliq_icm_frete | numeric(6,4) | True | False | False | - |
| 44 | vl_icm_frete | numeric(13,2) | True | False | False | - |
| 45 | vl_seguro | numeric(13,2) | True | False | False | - |
| 46 | vl_tot_nf | numeric(13,2) | True | False | False | - |
| 47 | rom_min | int | True | False | False | - |
| 48 | nome_trans | varchar(60) | True | False | False | - |
| 49 | tp_pes_trans | char(1) | True | False | False | - |
| 50 | cgc_cpf_trans | varchar(14) | True | False | False | - |
| 51 | end_trans | varchar(140) | True | False | False | - |
| 52 | bairro_trans | varchar(60) | True | False | False | - |
| 53 | munic_trans | varchar(60) | True | False | False | - |
| 54 | estado_trans | varchar(2) | True | False | False | - |
| 55 | insc_trans | varchar(20) | True | False | False | - |
| 56 | qtde_trans | int | True | False | False | - |
| 57 | especie | varchar(15) | True | False | False | - |
| 58 | marca | varchar(15) | True | False | False | - |
| 59 | nu_trans | int | True | False | False | - |
| 60 | peso_brt | numeric(13,3) | True | False | False | - |
| 61 | peso_liq | numeric(13,3) | True | False | False | - |
| 62 | endereco_rod | varchar(140) | True | False | False | - |
| 63 | bairro_rod | varchar(60) | True | False | False | - |
| 64 | cep_rod | int | True | False | False | - |
| 65 | municipio_rod | varchar(60) | True | False | False | - |
| 66 | estado_rod | char(2) | True | False | False | - |
| 67 | loc_guia_rod | varchar(30) | True | False | False | - |
| 68 | endereco_rod_2 | varchar(140) | True | False | False | - |
| 69 | bairro_rod_2 | varchar(60) | True | False | False | - |
| 70 | cep_rod_2 | int | True | False | False | - |
| 71 | municipio_rod_2 | varchar(60) | True | False | False | - |
| 72 | estado_rod_2 | char(2) | True | False | False | - |
| 73 | loc_guia_rod_2 | varchar(30) | True | False | False | - |
| 74 | cgc_entrega | varchar(14) | True | False | False | - |
| 75 | insc_est_entrega | varchar(20) | True | False | False | - |
| 76 | rot_visita | char(8) | True | False | False | - |
| 77 | nu_di | char(12) | True | False | False | - |
| 78 | situacao | char(2) | False | False | False | - |
| 79 | origem_prog | char(1) | True | False | False | - |
| 80 | tipo_nf | char(1) | False | False | False | - |
| 81 | cd_texto | int | True | False | False | - |
| 82 | suframa | tinyint | True | False | False | - |
| 83 | cd_suframa | varchar(20) | True | False | False | - |
| 84 | vl_material | numeric(13,2) | True | False | False | - |
| 85 | vl_mao_obra | numeric(13,2) | True | False | False | - |
| 86 | vl_icm_material | numeric(13,2) | True | False | False | - |
| 87 | nome_gue | varchar(20) | True | False | False | - |
| 88 | desc_equipe | varchar(20) | True | False | False | - |
| 89 | icm_sobre_ipi | tinyint | True | False | False | - |
| 90 | desc_cfop | varchar(10) | True | False | False | - |
| 91 | tp_emp_nf | char(2) | True | False | False | - |
| 92 | vl_adicional_fin | numeric(13,2) | True | False | False | - |
| 93 | perc_desc_geral | numeric(7,4) | True | False | False | - |
| 94 | perc_desc_embutido | numeric(7,4) | True | False | False | - |
| 95 | cd_texto_asplan | int | True | False | False | - |
| 96 | meia_nota | tinyint | True | False | False | - |
| 97 | vl_boleto | numeric(13,2) | True | False | False | - |
| 98 | aliq_icm_boleto | numeric(6,4) | True | False | False | - |
| 99 | vl_icm_boleto | numeric(13,2) | True | False | False | - |
| 100 | cd_rot_prdf | char(8) | True | False | False | - |
| 101 | placa_veic | varchar(12) | True | False | False | - |
| 102 | nome_res | varchar(20) | True | False | False | - |
| 103 | formpgto | char(2) | True | False | False | - |
| 104 | alvara | varchar(20) | True | False | False | - |
| 105 | dt_val_alvara | smalldatetime | True | False | False | - |
| 106 | vl_desconto_isencao_icm | numeric(13,2) | True | False | False | - |
| 107 | vl_repasse | numeric(13,2) | True | False | False | - |
| 108 | vl_desc_troca | numeric(13,2) | True | False | False | - |
| 109 | imp_desc_itens | tinyint | True | False | False | - |
| 110 | uso_tp_vl_itens | tinyint | True | False | False | - |
| 111 | tp_vl_itens | char(3) | True | False | False | - |
| 112 | cd_vend_lc | char(8) | True | False | False | - |
| 113 | nu_nf_emp_fat | int | False | False | False | - |
| 114 | cd_emp_fat | int | True | False | False | - |
| 115 | cd_usr_ped | char(8) | True | False | False | - |
| 116 | formpgto_completa | varchar(30) | True | False | False | - |
| 117 | vl_verba | numeric(13,2) | True | False | False | - |
| 118 | vl_desc_it_bonif | numeric(15,4) | True | False | False | - |
| 119 | dt_entrega | smalldatetime | True | False | False | - |
| 120 | vl_tare | numeric(13,2) | True | False | False | - |
| 121 | vl_desc_icm_preco_cheio | numeric(13,2) | True | False | False | - |
| 122 | nf_preco_cheio_desc_bol | tinyint | True | False | False | - |
| 123 | vl_dif_nf_preco_cheio_desc_bol | numeric(13,2) | True | False | False | - |
| 124 | paletes | varchar(20) | True | False | False | - |
| 125 | vl_subst_ressarc | numeric(13,2) | True | False | False | - |
| 126 | ddd_trans | varchar(4) | True | False | False | - |
| 127 | fone_trans | bigint | True | False | False | - |
| 128 | regiao_rod | varchar(80) | True | False | False | - |
| 129 | sem_red_base_icm | tinyint | True | False | False | - |
| 130 | cd_motor | char(8) | True | False | False | - |
| 131 | nome_motor | varchar(40) | True | False | False | - |
| 132 | tab_preco | char(30) | True | False | False | - |
| 133 | cd_tabela | char(8) | True | False | False | - |
| 134 | vl_dif_red_base | numeric(13,2) | True | False | False | - |
| 135 | origem_pedido | char(1) | True | False | False | - |
| 136 | desc_ram_ativ_cli | varchar(30) | True | False | False | - |
| 137 | vl_tot_it_subst | numeric(13,2) | True | False | False | - |
| 138 | base_pis_cof_antec | numeric(13,2) | True | False | False | - |
| 139 | vl_ad_icm_cli_isento | numeric(13,2) | True | False | False | - |
| 140 | perc_pis | numeric(6,4) | True | False | False | - |
| 141 | perc_cofins | numeric(6,4) | True | False | False | - |
| 142 | qtde_vol_ped_vda | int | True | False | False | - |
| 143 | qtde_vol_ped_vda_ab | int | True | False | False | - |
| 144 | serie | char(3) | True | False | False | - |
| 145 | qtde_vol_ped_vda_fe | int | True | False | False | - |
| 146 | base_icm_it_subst | numeric(13,2) | True | False | False | - |
| 147 | vl_icm_it_subst | numeric(13,2) | True | False | False | - |
| 148 | cd_area | char(8) | True | False | False | - |
| 149 | estrangeiro | tinyint | True | False | False | - |
| 150 | estrangeiro_nu_doc | varchar(30) | True | False | False | - |
| 151 | nota_editor_apur_icm | tinyint | True | False | False | - |
| 152 | tp_abatimento_troca | char(2) | True | False | False | - |
| 153 | tp_entrega | char(2) | True | False | False | - |
| 154 | vl_dif_red_base_vl_calc | numeric(13,2) | True | False | False | - |
| 155 | suframa_desc_pis_cofins | tinyint | True | False | False | - |
| 156 | nu_nf_troca | varchar(100) | True | False | False | - |
| 157 | seq_rot_prdf | int | True | False | False | - |
| 158 | sub_desc_geral_vl_tot_prod | tinyint | True | False | False | - |
| 159 | endereco_cob | varchar(140) | True | False | False | - |
| 160 | municipio_cob | varchar(60) | True | False | False | - |
| 161 | bairro_cob | varchar(60) | True | False | False | - |
| 162 | cep_cob | int | True | False | False | - |
| 163 | estado_cob | char(2) | True | False | False | - |
| 164 | cd_vend_rt | char(8) | True | False | False | - |
| 165 | perc_desc_suframa | numeric(7,4) | True | False | False | - |
| 166 | vl_desc_suframa | numeric(13,2) | True | False | False | - |
| 167 | nf_servico_transp | tinyint | True | False | False | - |
| 168 | cd_cep_munic | int | True | False | False | - |
| 169 | logradouro | varchar(60) | True | False | False | - |
| 170 | numero | varchar(15) | True | False | False | - |
| 171 | complemento | varchar(60) | True | False | False | - |
| 172 | cd_pais | char(3) | True | False | False | - |
| 173 | nfe | bit | True | False | False | - |
| 174 | nfe_situacao | varchar(4) | True | False | False | - |
| 175 | cd_nfe_tp_sist | char(4) | True | False | False | - |
| 176 | nfe_nu_aleatorio | numeric(9,0) | True | False | False | - |
| 177 | nfe_chave_acesso | varchar(44) | True | False | False | - |
| 178 | nfe_chave_acesso_dv | numeric(2,0) | True | False | False | - |
| 179 | contribuinte_icms | bit | True | False | False | - |
| 180 | base_icm_it_s_subst | numeric(13,2) | True | False | False | - |
| 181 | vl_icm_it_s_subst | numeric(13,2) | True | False | False | - |
| 182 | vl_tot_it_s_subst | numeric(13,2) | True | False | False | - |
| 183 | nfe_protocolo | varchar(17) | True | False | False | - |
| 184 | nfe_obs | varchar(254) | True | False | False | - |
| 185 | nfe_lib_cont_fs | bit | True | False | False | - |
| 186 | nfe_lib_cont_sce | bit | True | False | False | - |
| 187 | nfe_lib_cont_scan | bit | True | False | False | - |
| 188 | nfe_contingencia | bit | True | False | False | - |
| 189 | nfe_tp_contingencia | char(4) | True | False | False | - |
| 190 | nfe_pend_retorno | bit | True | False | False | - |
| 191 | nfe_dt_sit_sefaz | datetime | True | False | False | - |
| 192 | modelo | char(2) | True | False | False | - |
| 193 | placa_veic_estado | char(2) | True | False | False | - |
| 194 | nfe_nota_impressa | bit | False | False | False | - |
| 195 | nfe_email_enviado | bit | False | False | False | - |
| 196 | quebra_nf_por_cfop | bit | True | False | False | - |
| 197 | vl_adic_nf | numeric(13,2) | True | False | False | - |
| 198 | seq_tributacao_regime | tinyint | True | False | False | - |
| 200 | export_uf_embarque | char(2) | True | False | False | - |
| 201 | export_local_embarque | varchar(60) | True | False | False | - |
| 202 | import_vl_siscomex | numeric(13,2) | True | False | False | - |
| 203 | suframa_tp_desc | char(1) | True | False | False | - |
| 204 | QtdeImpNuSerie | int | True | False | False | - |
| 205 | AliqTotTributos | numeric(6,4) | True | False | False | - |
| 206 | VlTotTributos | numeric(13,2) | True | False | False | - |
| 207 | SiglaSeparacao | char(3) | True | False | False | - |
| 208 | VlBaseICMDest | numeric(13,2) | True | False | False | - |
| 209 | VlFCPDest | numeric(13,2) | True | False | False | - |
| 210 | VlICMDest | numeric(13,2) | True | False | False | - |
| 211 | VlICMRemetente | numeric(13,2) | True | False | False | - |
| 212 | ConsumidorFinal | bit | True | False | False | - |
| 213 | NFAnteriorRejVlIcms | bit | True | False | False | - |
| 214 | DescricaoVan | varchar(100) | True | False | False | - |
| 215 | ExportLocDespacho | varchar(60) | True | False | False | - |
| 216 | Distrito | varchar(60) | True | False | False | - |
| 217 | DistritoRod | varchar(60) | True | False | False | - |
| 218 | RessarcimentoSTEmpresa | bit | True | False | False | - |
| 219 | RessarcimentoSTMetodoCalculoID | tinyint | True | False | False | - |
| 220 | RessarcimentoSTEmissaoNFAuto | bit | True | False | False | - |
| 221 | RessarcimentoSTNotaFiscalID | bigint | True | False | False | - |
| 222 | ValorFCP | numeric(13,2) | True | False | False | - |
| 223 | ValorFCPST | numeric(13,2) | True | False | False | - |
| 224 | ValorFCPSTRetido | numeric(13,2) | True | False | False | - |
| 225 | TipoValorPreferencialBaseST | char(3) | True | False | False | - |
| 226 | SubtraiICMSBasePisCofins | bit | True | False | False | - |
| 227 | ProcessoAtoConcessorio | varchar(60) | True | False | False | - |
| 228 | OrigemProcesso | tinyint | True | False | False | - |
| 229 | VeiculoTerceiro | bit | True | False | False | - |
| 230 | FinalidadeDevolucaoNFe | tinyint | True | False | False | - |
| 231 | SubtraiValorRepasseTotalNF | bit | True | False | False | - |
| 232 | UtilizaICMSEfetivo | bit | True | False | False | - |
| 233 | ResponsavelTecnicoID | bigint | True | False | False | - |
| 234 | ItNotaLote | bit | True | False | False | - |
| 235 | TipoCalcICMSRetSubst | char(4) | True | False | False | - |
| 236 | DescontoSuframaNoDescontoGeral | bit | True | False | False | - |
| 237 | PercIRRFRetencao | numeric(6,4) | True | False | False | - |
| 238 | ValorIRRFRetencao | numeric(13,2) | True | False | False | - |
| 239 | PercCSLLRetencao | numeric(6,4) | True | False | False | - |
| 240 | ValorCSLLRetencao | numeric(13,2) | True | False | False | - |
| 241 | PercPisRetencao | numeric(6,4) | True | False | False | - |
| 242 | ValorPisRetencao | numeric(13,2) | True | False | False | - |
| 243 | PercCofinsRetencao | numeric(6,4) | True | False | False | - |
| 244 | ValorCofinsRetencao | numeric(13,2) | True | False | False | - |
| 245 | ValorTotalRetencao | numeric(13,2) | True | False | False | - |
| 246 | Intermediador | bit | True | False | False | - |
| 247 | IntermediadorId | int | True | False | False | - |
| 248 | NomeIntermediador | varchar(40) | True | False | False | - |
| 249 | CNPJIntermediador | varchar(14) | True | False | False | - |
| 250 | CNPJOperadoraCC | varchar(14) | True | False | False | - |
| 251 | BandeiraIDCC | int | True | False | False | - |
| 252 | CartaoCredito | bit | True | False | False | - |
| 253 | faturamentoAutomatico | bit | True | False | False | - |
| 254 | OrgaoPublico | bit | True | False | False | - |
| 255 | CalculaDifal | bit | True | False | False | - |
| 256 | NfeLibContEPEC | bit | True | False | False | - |
| 257 | RecebimentoAntecipado | bit | True | False | False | - |
| 258 | ValorFreteTituloPagar | numeric(13,2) | True | False | False | - |
| 259 | SeqPagFrete | int | True | False | False | - |
| 260 | SeqPagFreteAgrupamento | int | True | False | False | - |
| 261 | MovimentacaoEstoqueFisico | bit | True | False | False | - |
| 262 | BloquearReenvioComNovoNumero | bit | True | False | False | - |
| 263 | TipoAtoConcessorio | varchar(2) | True | False | False | - |
| 264 | InformacoesAdicionaisFisco | varchar(2000) | True | False | False | - |
| 265 | SubtraiICMSSTBasePisCofins | bit | True | False | False | - |
| 266 | BloquearReenvioSimples | bit | True | False | False | - |
| 267 | ModalidadeFreteDevolucao | tinyint | True | False | False | - |
| 268 | SubtraiValorRepasseBaseICMS | bit | True | False | False | - |
| 269 | BaseCalculoCBSIBS | numeric(15,2) | True | False | False | - |
| 270 | ValorIBS | numeric(15,2) | True | False | False | - |
| 271 | ValorDiferimentoIBSUF | numeric(15,2) | True | False | False | - |
| 272 | ValorDiferimentoIBSMunicipio | numeric(15,2) | True | False | False | - |
| 273 | ValorDiferimentoCBS | numeric(15,2) | True | False | False | - |
| 274 | ValorIBSUF | numeric(15,2) | True | False | False | - |
| 275 | ValorIBSMunicipio | numeric(15,2) | True | False | False | - |
| 276 | ValorCBS | numeric(15,2) | True | False | False | - |
| 277 | CdClienTitrec | int | True | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL Reconstruida

```sql
CREATE TABLE [bronze].[nota_fiscal_g4_distribuidora] (
    [nu_nf] int NOT NULL,
    [desc_nat_oper] varchar(60) NULL,
    [insc_subst] varchar(20) NULL,
    [cd_clien] int NULL,
    [nome] varchar(60) NULL,
    [tp_pes] char(1) NULL,
    [cgc_cpf] varchar(14) NULL,
    [endereco] varchar(140) NULL,
    [bairro] varchar(60) NULL,
    [cep] int NULL,
    [municipio] varchar(60) NULL,
    [ddd] varchar(4) NULL,
    [nu_tel] bigint NULL,
    [estado] char(2) NULL,
    [inscricao] varchar(20) NULL,
    [cd_emp] int NULL,
    [nu_ped] int NULL,
    [nu_ped_cli] varchar(35) NULL,
    [cd_vend] char(8) NULL,
    [dt_ped] smalldatetime NULL,
    [dt_emis] smalldatetime NULL,
    [dt_ent_saida] smalldatetime NULL,
    [hor_saida] smalldatetime NULL,
    [cond_pagto] char(30) NULL,
    [vl_prod] numeric(13,2) NULL,
    [vl_tot_serv] money NULL,
    [vl_desc] numeric(13,2) NULL,
    [vl_desc_geral] numeric(13,2) NULL,
    [vl_desc_fin] numeric(13,2) NULL,
    [perc_desc_fin] numeric(6,4) NULL,
    [str_dias_desc_fin] varchar(40) NULL,
    [aliq_icm] numeric(6,4) NULL,
    [vl_icm] numeric(13,2) NULL,
    [vl_icm_subst] numeric(13,2) NULL,
    [vl_ipi] numeric(13,2) NULL,
    [vl_iss] numeric(13,2) NULL,
    [vl_desp_aces] numeric(13,2) NULL,
    [base_icm] numeric(13,2) NULL,
    [base_icm_subst] numeric(13,2) NULL,
    [base_iss] numeric(13,2) NULL,
    [tp_frete] tinyint NULL,
    [vl_frete] numeric(13,2) NULL,
    [aliq_icm_frete] numeric(6,4) NULL,
    [vl_icm_frete] numeric(13,2) NULL,
    [vl_seguro] numeric(13,2) NULL,
    [vl_tot_nf] numeric(13,2) NULL,
    [rom_min] int NULL,
    [nome_trans] varchar(60) NULL,
    [tp_pes_trans] char(1) NULL,
    [cgc_cpf_trans] varchar(14) NULL,
    [end_trans] varchar(140) NULL,
    [bairro_trans] varchar(60) NULL,
    [munic_trans] varchar(60) NULL,
    [estado_trans] varchar(2) NULL,
    [insc_trans] varchar(20) NULL,
    [qtde_trans] int NULL,
    [especie] varchar(15) NULL,
    [marca] varchar(15) NULL,
    [nu_trans] int NULL,
    [peso_brt] numeric(13,3) NULL,
    [peso_liq] numeric(13,3) NULL,
    [endereco_rod] varchar(140) NULL,
    [bairro_rod] varchar(60) NULL,
    [cep_rod] int NULL,
    [municipio_rod] varchar(60) NULL,
    [estado_rod] char(2) NULL,
    [loc_guia_rod] varchar(30) NULL,
    [endereco_rod_2] varchar(140) NULL,
    [bairro_rod_2] varchar(60) NULL,
    [cep_rod_2] int NULL,
    [municipio_rod_2] varchar(60) NULL,
    [estado_rod_2] char(2) NULL,
    [loc_guia_rod_2] varchar(30) NULL,
    [cgc_entrega] varchar(14) NULL,
    [insc_est_entrega] varchar(20) NULL,
    [rot_visita] char(8) NULL,
    [nu_di] char(12) NULL,
    [situacao] char(2) NOT NULL,
    [origem_prog] char(1) NULL,
    [tipo_nf] char(1) NOT NULL,
    [cd_texto] int NULL,
    [suframa] tinyint NULL,
    [cd_suframa] varchar(20) NULL,
    [vl_material] numeric(13,2) NULL,
    [vl_mao_obra] numeric(13,2) NULL,
    [vl_icm_material] numeric(13,2) NULL,
    [nome_gue] varchar(20) NULL,
    [desc_equipe] varchar(20) NULL,
    [icm_sobre_ipi] tinyint NULL,
    [desc_cfop] varchar(10) NULL,
    [tp_emp_nf] char(2) NULL,
    [vl_adicional_fin] numeric(13,2) NULL,
    [perc_desc_geral] numeric(7,4) NULL,
    [perc_desc_embutido] numeric(7,4) NULL,
    [cd_texto_asplan] int NULL,
    [meia_nota] tinyint NULL,
    [vl_boleto] numeric(13,2) NULL,
    [aliq_icm_boleto] numeric(6,4) NULL,
    [vl_icm_boleto] numeric(13,2) NULL,
    [cd_rot_prdf] char(8) NULL,
    [placa_veic] varchar(12) NULL,
    [nome_res] varchar(20) NULL,
    [formpgto] char(2) NULL,
    [alvara] varchar(20) NULL,
    [dt_val_alvara] smalldatetime NULL,
    [vl_desconto_isencao_icm] numeric(13,2) NULL,
    [vl_repasse] numeric(13,2) NULL,
    [vl_desc_troca] numeric(13,2) NULL,
    [imp_desc_itens] tinyint NULL,
    [uso_tp_vl_itens] tinyint NULL,
    [tp_vl_itens] char(3) NULL,
    [cd_vend_lc] char(8) NULL,
    [nu_nf_emp_fat] int NOT NULL,
    [cd_emp_fat] int NULL,
    [cd_usr_ped] char(8) NULL,
    [formpgto_completa] varchar(30) NULL,
    [vl_verba] numeric(13,2) NULL,
    [vl_desc_it_bonif] numeric(15,4) NULL,
    [dt_entrega] smalldatetime NULL,
    [vl_tare] numeric(13,2) NULL,
    [vl_desc_icm_preco_cheio] numeric(13,2) NULL,
    [nf_preco_cheio_desc_bol] tinyint NULL,
    [vl_dif_nf_preco_cheio_desc_bol] numeric(13,2) NULL,
    [paletes] varchar(20) NULL,
    [vl_subst_ressarc] numeric(13,2) NULL,
    [ddd_trans] varchar(4) NULL,
    [fone_trans] bigint NULL,
    [regiao_rod] varchar(80) NULL,
    [sem_red_base_icm] tinyint NULL,
    [cd_motor] char(8) NULL,
    [nome_motor] varchar(40) NULL,
    [tab_preco] char(30) NULL,
    [cd_tabela] char(8) NULL,
    [vl_dif_red_base] numeric(13,2) NULL,
    [origem_pedido] char(1) NULL,
    [desc_ram_ativ_cli] varchar(30) NULL,
    [vl_tot_it_subst] numeric(13,2) NULL,
    [base_pis_cof_antec] numeric(13,2) NULL,
    [vl_ad_icm_cli_isento] numeric(13,2) NULL,
    [perc_pis] numeric(6,4) NULL,
    [perc_cofins] numeric(6,4) NULL,
    [qtde_vol_ped_vda] int NULL,
    [qtde_vol_ped_vda_ab] int NULL,
    [serie] char(3) NULL,
    [qtde_vol_ped_vda_fe] int NULL,
    [base_icm_it_subst] numeric(13,2) NULL,
    [vl_icm_it_subst] numeric(13,2) NULL,
    [cd_area] char(8) NULL,
    [estrangeiro] tinyint NULL,
    [estrangeiro_nu_doc] varchar(30) NULL,
    [nota_editor_apur_icm] tinyint NULL,
    [tp_abatimento_troca] char(2) NULL,
    [tp_entrega] char(2) NULL,
    [vl_dif_red_base_vl_calc] numeric(13,2) NULL,
    [suframa_desc_pis_cofins] tinyint NULL,
    [nu_nf_troca] varchar(100) NULL,
    [seq_rot_prdf] int NULL,
    [sub_desc_geral_vl_tot_prod] tinyint NULL,
    [endereco_cob] varchar(140) NULL,
    [municipio_cob] varchar(60) NULL,
    [bairro_cob] varchar(60) NULL,
    [cep_cob] int NULL,
    [estado_cob] char(2) NULL,
    [cd_vend_rt] char(8) NULL,
    [perc_desc_suframa] numeric(7,4) NULL,
    [vl_desc_suframa] numeric(13,2) NULL,
    [nf_servico_transp] tinyint NULL,
    [cd_cep_munic] int NULL,
    [logradouro] varchar(60) NULL,
    [numero] varchar(15) NULL,
    [complemento] varchar(60) NULL,
    [cd_pais] char(3) NULL,
    [nfe] bit NULL,
    [nfe_situacao] varchar(4) NULL,
    [cd_nfe_tp_sist] char(4) NULL,
    [nfe_nu_aleatorio] numeric(9,0) NULL,
    [nfe_chave_acesso] varchar(44) NULL,
    [nfe_chave_acesso_dv] numeric(2,0) NULL,
    [contribuinte_icms] bit NULL,
    [base_icm_it_s_subst] numeric(13,2) NULL,
    [vl_icm_it_s_subst] numeric(13,2) NULL,
    [vl_tot_it_s_subst] numeric(13,2) NULL,
    [nfe_protocolo] varchar(17) NULL,
    [nfe_obs] varchar(254) NULL,
    [nfe_lib_cont_fs] bit NULL,
    [nfe_lib_cont_sce] bit NULL,
    [nfe_lib_cont_scan] bit NULL,
    [nfe_contingencia] bit NULL,
    [nfe_tp_contingencia] char(4) NULL,
    [nfe_pend_retorno] bit NULL,
    [nfe_dt_sit_sefaz] datetime NULL,
    [modelo] char(2) NULL,
    [placa_veic_estado] char(2) NULL,
    [nfe_nota_impressa] bit NOT NULL,
    [nfe_email_enviado] bit NOT NULL,
    [quebra_nf_por_cfop] bit NULL,
    [vl_adic_nf] numeric(13,2) NULL,
    [seq_tributacao_regime] tinyint NULL,
    [export_uf_embarque] char(2) NULL,
    [export_local_embarque] varchar(60) NULL,
    [import_vl_siscomex] numeric(13,2) NULL,
    [suframa_tp_desc] char(1) NULL,
    [QtdeImpNuSerie] int NULL,
    [AliqTotTributos] numeric(6,4) NULL,
    [VlTotTributos] numeric(13,2) NULL,
    [SiglaSeparacao] char(3) NULL,
    [VlBaseICMDest] numeric(13,2) NULL,
    [VlFCPDest] numeric(13,2) NULL,
    [VlICMDest] numeric(13,2) NULL,
    [VlICMRemetente] numeric(13,2) NULL,
    [ConsumidorFinal] bit NULL,
    [NFAnteriorRejVlIcms] bit NULL,
    [DescricaoVan] varchar(100) NULL,
    [ExportLocDespacho] varchar(60) NULL,
    [Distrito] varchar(60) NULL,
    [DistritoRod] varchar(60) NULL,
    [RessarcimentoSTEmpresa] bit NULL,
    [RessarcimentoSTMetodoCalculoID] tinyint NULL,
    [RessarcimentoSTEmissaoNFAuto] bit NULL,
    [RessarcimentoSTNotaFiscalID] bigint NULL,
    [ValorFCP] numeric(13,2) NULL,
    [ValorFCPST] numeric(13,2) NULL,
    [ValorFCPSTRetido] numeric(13,2) NULL,
    [TipoValorPreferencialBaseST] char(3) NULL,
    [SubtraiICMSBasePisCofins] bit NULL,
    [ProcessoAtoConcessorio] varchar(60) NULL,
    [OrigemProcesso] tinyint NULL,
    [VeiculoTerceiro] bit NULL,
    [FinalidadeDevolucaoNFe] tinyint NULL,
    [SubtraiValorRepasseTotalNF] bit NULL,
    [UtilizaICMSEfetivo] bit NULL,
    [ResponsavelTecnicoID] bigint NULL,
    [ItNotaLote] bit NULL,
    [TipoCalcICMSRetSubst] char(4) NULL,
    [DescontoSuframaNoDescontoGeral] bit NULL,
    [PercIRRFRetencao] numeric(6,4) NULL,
    [ValorIRRFRetencao] numeric(13,2) NULL,
    [PercCSLLRetencao] numeric(6,4) NULL,
    [ValorCSLLRetencao] numeric(13,2) NULL,
    [PercPisRetencao] numeric(6,4) NULL,
    [ValorPisRetencao] numeric(13,2) NULL,
    [PercCofinsRetencao] numeric(6,4) NULL,
    [ValorCofinsRetencao] numeric(13,2) NULL,
    [ValorTotalRetencao] numeric(13,2) NULL,
    [Intermediador] bit NULL,
    [IntermediadorId] int NULL,
    [NomeIntermediador] varchar(40) NULL,
    [CNPJIntermediador] varchar(14) NULL,
    [CNPJOperadoraCC] varchar(14) NULL,
    [BandeiraIDCC] int NULL,
    [CartaoCredito] bit NULL,
    [faturamentoAutomatico] bit NULL,
    [OrgaoPublico] bit NULL,
    [CalculaDifal] bit NULL,
    [NfeLibContEPEC] bit NULL,
    [RecebimentoAntecipado] bit NULL,
    [ValorFreteTituloPagar] numeric(13,2) NULL,
    [SeqPagFrete] int NULL,
    [SeqPagFreteAgrupamento] int NULL,
    [MovimentacaoEstoqueFisico] bit NULL,
    [BloquearReenvioComNovoNumero] bit NULL,
    [TipoAtoConcessorio] varchar(2) NULL,
    [InformacoesAdicionaisFisco] varchar(2000) NULL,
    [SubtraiICMSSTBasePisCofins] bit NULL,
    [BloquearReenvioSimples] bit NULL,
    [ModalidadeFreteDevolucao] tinyint NULL,
    [SubtraiValorRepasseBaseICMS] bit NULL,
    [BaseCalculoCBSIBS] numeric(15,2) NULL,
    [ValorIBS] numeric(15,2) NULL,
    [ValorDiferimentoIBSUF] numeric(15,2) NULL,
    [ValorDiferimentoIBSMunicipio] numeric(15,2) NULL,
    [ValorDiferimentoCBS] numeric(15,2) NULL,
    [ValorIBSUF] numeric(15,2) NULL,
    [ValorIBSMunicipio] numeric(15,2) NULL,
    [ValorCBS] numeric(15,2) NULL,
    [CdClienTitrec] int NULL
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
