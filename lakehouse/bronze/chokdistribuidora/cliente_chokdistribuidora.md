<!-- generated: lakehouse-object -->
# bronze.cliente_chokdistribuidora

- Tipo: `TABLE`
- Industria: `chokdistribuidora`
- Origem: `database:GA_DATALAKE`
- PKs: Nao identificado no banco
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | cd_clien | int | False | False | False | - |
| 2 | tp_cliente | char(2) | False | False | False | - |
| 3 | nome | varchar(60) | False | False | False | - |
| 4 | nome_res | varchar(20) | False | False | False | - |
| 5 | tp_pes | char(1) | True | False | False | - |
| 6 | cgc_cpf | varchar(14) | True | False | False | - |
| 7 | tp_inscr | char(1) | True | False | False | - |
| 8 | inscricao | varchar(20) | True | False | False | - |
| 9 | ram_ativ | char(4) | True | False | False | - |
| 10 | st_cred | char(4) | False | False | False | - |
| 11 | crt | varchar(20) | True | False | False | - |
| 12 | cd_grupocli | char(10) | True | False | False | - |
| 13 | cd_area | char(8) | True | False | False | - |
| 14 | dt_cad | smalldatetime | False | False | False | - |
| 15 | cd_vend | char(8) | True | False | False | - |
| 16 | dt_ult_alt | smalldatetime | True | False | False | - |
| 17 | cd_texto | int | True | False | False | - |
| 18 | dt_maior_acumulo | smalldatetime | True | False | False | - |
| 19 | vl_maior_acumulo | numeric(13,2) | True | False | False | - |
| 20 | dt_maior_compra | smalldatetime | True | False | False | - |
| 21 | dt_prim_compra | smalldatetime | True | False | False | - |
| 22 | vl_maior_compra | numeric(13,2) | True | False | False | - |
| 23 | qtde_compra_mes | numeric(13,2) | True | False | False | - |
| 24 | dt_ult_compra | smalldatetime | True | False | False | - |
| 25 | vl_ult_compra | numeric(13,2) | True | False | False | - |
| 26 | vl_lim_cred | numeric(13,2) | True | False | False | - |
| 27 | dt_ult_contato | smalldatetime | True | False | False | - |
| 28 | cd_rot_prdf | char(8) | True | False | False | - |
| 29 | seq_rot_prdf | int | True | False | False | - |
| 30 | rot_visita | char(8) | True | False | False | - |
| 31 | seq_visita | numeric(7,3) | True | False | False | - |
| 32 | turma_plantao | char(2) | True | False | False | - |
| 33 | med_atraso | int | True | False | False | - |
| 34 | tot_protestos | int | True | False | False | - |
| 35 | cd_texto_cred | int | True | False | False | - |
| 36 | situacao | char(2) | True | False | False | - |
| 37 | nu_dias_protesto | smallint | True | False | False | - |
| 38 | desconto | numeric(7,4) | True | False | False | - |
| 39 | venda_especial | tinyint | True | False | False | - |
| 40 | suframa | tinyint | True | False | False | - |
| 41 | cd_suframa | varchar(20) | True | False | False | - |
| 42 | fornec | tinyint | True | False | False | - |
| 43 | estrangeiro | tinyint | True | False | False | - |
| 44 | cd_texto_alerta | int | True | False | False | - |
| 45 | cd_texto_nf | int | True | False | False | - |
| 46 | web_site | varchar(50) | True | False | False | - |
| 47 | e_mail | varchar(80) | True | False | False | - |
| 48 | tp_frete | char(1) | True | False | False | - |
| 49 | cd_forn | int | True | False | False | - |
| 50 | num_lock | tinyint | False | False | False | - |
| 51 | ativo | bit | True | False | False | - |
| 52 | ean13 | varchar(13) | True | False | False | - |
| 53 | prz_prev_entr | int | True | False | False | - |
| 54 | pot_compra_mes | numeric(13,2) | True | False | False | - |
| 55 | perc_comis | numeric(7,4) | True | False | False | - |
| 56 | tp_ped | char(2) | True | False | False | - |
| 57 | cobra_boleto | tinyint | True | False | False | - |
| 58 | cd_texto_expe | int | True | False | False | - |
| 59 | atualiza_lim_cred | tinyint | True | False | False | - |
| 60 | prod_controlado | tinyint | True | False | False | - |
| 61 | enviar_arq_genexis | tinyint | False | False | False | - |
| 62 | cliente_novo_genexis | tinyint | False | False | False | - |
| 63 | enviar_arq_janssen | tinyint | False | False | False | - |
| 64 | cliente_novo_janssen | tinyint | False | False | False | - |
| 65 | dt_val_prod_controlado | smalldatetime | True | False | False | - |
| 66 | enviar_arq_nestle | tinyint | False | False | False | - |
| 67 | envio_serasa | tinyint | True | False | False | - |
| 68 | cd_grdescli | varchar(4) | True | False | False | - |
| 69 | cd_emp | int | True | False | False | - |
| 70 | cd_clien_col | int | True | False | False | - |
| 71 | senha | varchar(15) | True | False | False | - |
| 72 | toler_juros_qtde_dias | int | True | False | False | - |
| 73 | toler_juros_ate_venc | tinyint | True | False | False | - |
| 74 | cod_clf | varchar(20) | True | False | False | - |
| 75 | cd_tp_freq_visita | char(1) | True | False | False | - |
| 76 | area_livre_comercio | tinyint | True | False | False | - |
| 77 | dias_prorr_venc | tinyint | True | False | False | - |
| 78 | cliente_novo_proceda | tinyint | False | False | False | - |
| 79 | enviar_arq_proceda | tinyint | False | False | False | - |
| 80 | nao_fat_maior_un | tinyint | True | False | False | - |
| 81 | cliente_novo_nestle | tinyint | False | False | False | - |
| 82 | cd_coligacao | char(4) | True | False | False | - |
| 83 | dt_ult_alt_lim_cred | smalldatetime | True | False | False | - |
| 84 | dt_recadastramento | smalldatetime | True | False | False | - |
| 85 | estrangeiro_nu_doc | varchar(30) | True | False | False | - |
| 86 | atu_ult_maior_compra | tinyint | False | False | False | - |
| 87 | envia_arq_masterfoods | tinyint | True | False | False | - |
| 88 | dt_penult_compra | smalldatetime | True | False | False | - |
| 89 | vl_penult_compra | numeric(13,2) | True | False | False | - |
| 90 | enviado_redbull | tinyint | True | False | False | - |
| 91 | consumidor | tinyint | True | False | False | - |
| 92 | perc_aceito_prazo_validade | numeric(5,2) | True | False | False | - |
| 93 | cobra_seguro | tinyint | True | False | False | - |
| 94 | bloq_atu_ult_maior_compra | tinyint | True | False | False | - |
| 95 | perc_desc_fin_auto | numeric(13,4) | True | False | False | - |
| 96 | enviar_arq_pharmadis | bit | True | False | False | - |
| 97 | cliente_novo_pharmadis | bit | True | False | False | - |
| 98 | nc_util_cfg_abat_clien | tinyint | True | False | False | - |
| 99 | nc_tp_abat_clien | char(2) | True | False | False | - |
| 100 | cd_vend_tecnico | char(8) | True | False | False | - |
| 101 | cd_forn_inst | int | True | False | False | - |
| 102 | imp_desc_grd_com | tinyint | True | False | False | - |
| 103 | cnae | char(9) | True | False | False | - |
| 104 | seq_trib_cli | int | True | False | False | - |
| 105 | alt_tab_preco_afv | bit | True | False | False | - |
| 106 | alt_tp_ped_afv | bit | True | False | False | - |
| 107 | seq_rot_prdf_provisorio | bit | True | False | False | - |
| 108 | envia_pdv_bmc | bit | True | False | False | - |
| 109 | qtde_check_out | smallint | True | False | False | - |
| 111 | envia_pdv_cgm | bit | True | False | False | - |
| 112 | nao_excede_peso_prd | bit | True | False | False | - |
| 113 | dt_validade_suframa | datetime | True | False | False | - |
| 114 | RecebeEmailDocVenc | bit | True | False | False | - |
| 115 | CdEmpRemetente | int | True | False | False | - |
| 116 | envia_pdv_tgt | bit | True | False | False | - |
| 117 | AtualizacaoCadastro | bit | True | False | False | - |
| 118 | NestUpdatingFlag | varchar(1) | True | False | False | - |
| 119 | HealthUpdatingFlag | varchar(1) | True | False | False | - |
| 120 | PrecoVenda4Dec | bit | False | False | False | - |
| 121 | PercDescGerAuto | numeric(13,4) | True | False | False | - |
| 122 | RotaPlanEntregaCritica | bit | False | False | False | - |
| 123 | CortarQtdeFracionada | bit | False | False | False | - |
| 124 | ClienteID | int | False | False | False | - |
| 125 | VerificaSomenteLimiteCliente | bit | True | False | False | - |
| 126 | VerificaSomenteLimiteColigacao | bit | True | False | False | - |
| 127 | VerificaSomenteLimiteGrupo | bit | True | False | False | - |
| 128 | TempoDescargaMinutos | int | True | False | False | - |
| 129 | SemVendaSomenteAssociacao | bit | True | False | False | - |
| 130 | DistrImpostoParcTrec | char(4) | False | False | False | - |
| 131 | SepaSubstNovoTitulo | bit | True | False | False | - |
| 132 | SepaSubstValorMinimo | numeric(13,2) | True | False | False | - |
| 133 | SepaSubstPrazoMaximo | int | True | False | False | - |
| 134 | ValorTaxaBoleto | numeric(13,2) | True | False | False | - |
| 135 | NaoRecebeVisitas | bit | True | False | False | - |
| 136 | Iban | varchar(50) | True | False | False | - |
| 137 | OperadoraCartaoCredito | bit | True | False | False | - |
| 138 | MLogSepaDestacaCliente | bit | False | False | False | - |
| 139 | PrazoMinValidProdEmDias | int | True | False | False | - |
| 140 | GrupoEcommercePrincipal | bit | True | False | False | - |
| 141 | SepaSubstQtdeLimMaxParc | int | True | False | False | - |
| 142 | TpDoc | char(1) | True | False | False | - |
| 143 | Anonimizado | bit | True | False | False | - |
| 144 | IndenizacaoPerfilID | int | True | False | False | - |
| 145 | PaleteDedicado | bit | False | False | False | - |
| 146 | IgnorarTituloVencidoNaoPago | bit | True | False | False | - |
| 147 | RegiaoRisco | nvarchar(100) | True | False | False | - |
| 148 | PermitirSaneamentoEndFa | bit | True | False | False | - |
| 149 | DataAtualizaDescRP | datetime | True | False | False | - |
| 150 | DtFundacao | smalldatetime | True | False | False | - |
| 151 | SeqTributacaoRegimeSefaz | tinyint | True | False | False | - |
| 152 | tipoVendaPdvID | int | True | False | False | - |
| 153 | RotaPTpTaxaDescarga | nvarchar(2) | True | False | False | - |
| 154 | RotaPValorTaxaDescarga | numeric(13,2) | True | False | False | - |
| 155 | ConfiguracaoCobrancaPixId | int | True | False | False | - |
| 156 | OrigemClienteID | int | False | False | False | - |
| 157 | DataUltimaAtualizacaoCurvaABC | datetime | True | False | False | - |
| 158 | TipoAtualizacaoCurvaABCID | tinyint | True | False | False | - |
| 159 | TipoImpressaoModelo55ID | smallint | True | False | False | - |
| 160 | tgtedi_punto_operacional | varchar(20) | True | False | False | - |
| 161 | TgtCRM_cd_clien_crm | varchar(30) | True | False | False | - |
| 162 | tgtedi_departamento | varchar(10) | True | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL Reconstruida

```sql
CREATE TABLE [bronze].[cliente_chokdistribuidora] (
    [cd_clien] int NOT NULL,
    [tp_cliente] char(2) NOT NULL,
    [nome] varchar(60) NOT NULL,
    [nome_res] varchar(20) NOT NULL,
    [tp_pes] char(1) NULL,
    [cgc_cpf] varchar(14) NULL,
    [tp_inscr] char(1) NULL,
    [inscricao] varchar(20) NULL,
    [ram_ativ] char(4) NULL,
    [st_cred] char(4) NOT NULL,
    [crt] varchar(20) NULL,
    [cd_grupocli] char(10) NULL,
    [cd_area] char(8) NULL,
    [dt_cad] smalldatetime NOT NULL,
    [cd_vend] char(8) NULL,
    [dt_ult_alt] smalldatetime NULL,
    [cd_texto] int NULL,
    [dt_maior_acumulo] smalldatetime NULL,
    [vl_maior_acumulo] numeric(13,2) NULL,
    [dt_maior_compra] smalldatetime NULL,
    [dt_prim_compra] smalldatetime NULL,
    [vl_maior_compra] numeric(13,2) NULL,
    [qtde_compra_mes] numeric(13,2) NULL,
    [dt_ult_compra] smalldatetime NULL,
    [vl_ult_compra] numeric(13,2) NULL,
    [vl_lim_cred] numeric(13,2) NULL,
    [dt_ult_contato] smalldatetime NULL,
    [cd_rot_prdf] char(8) NULL,
    [seq_rot_prdf] int NULL,
    [rot_visita] char(8) NULL,
    [seq_visita] numeric(7,3) NULL,
    [turma_plantao] char(2) NULL,
    [med_atraso] int NULL,
    [tot_protestos] int NULL,
    [cd_texto_cred] int NULL,
    [situacao] char(2) NULL,
    [nu_dias_protesto] smallint NULL,
    [desconto] numeric(7,4) NULL,
    [venda_especial] tinyint NULL,
    [suframa] tinyint NULL,
    [cd_suframa] varchar(20) NULL,
    [fornec] tinyint NULL,
    [estrangeiro] tinyint NULL,
    [cd_texto_alerta] int NULL,
    [cd_texto_nf] int NULL,
    [web_site] varchar(50) NULL,
    [e_mail] varchar(80) NULL,
    [tp_frete] char(1) NULL,
    [cd_forn] int NULL,
    [num_lock] tinyint NOT NULL,
    [ativo] bit NULL,
    [ean13] varchar(13) NULL,
    [prz_prev_entr] int NULL,
    [pot_compra_mes] numeric(13,2) NULL,
    [perc_comis] numeric(7,4) NULL,
    [tp_ped] char(2) NULL,
    [cobra_boleto] tinyint NULL,
    [cd_texto_expe] int NULL,
    [atualiza_lim_cred] tinyint NULL,
    [prod_controlado] tinyint NULL,
    [enviar_arq_genexis] tinyint NOT NULL,
    [cliente_novo_genexis] tinyint NOT NULL,
    [enviar_arq_janssen] tinyint NOT NULL,
    [cliente_novo_janssen] tinyint NOT NULL,
    [dt_val_prod_controlado] smalldatetime NULL,
    [enviar_arq_nestle] tinyint NOT NULL,
    [envio_serasa] tinyint NULL,
    [cd_grdescli] varchar(4) NULL,
    [cd_emp] int NULL,
    [cd_clien_col] int NULL,
    [senha] varchar(15) NULL,
    [toler_juros_qtde_dias] int NULL,
    [toler_juros_ate_venc] tinyint NULL,
    [cod_clf] varchar(20) NULL,
    [cd_tp_freq_visita] char(1) NULL,
    [area_livre_comercio] tinyint NULL,
    [dias_prorr_venc] tinyint NULL,
    [cliente_novo_proceda] tinyint NOT NULL,
    [enviar_arq_proceda] tinyint NOT NULL,
    [nao_fat_maior_un] tinyint NULL,
    [cliente_novo_nestle] tinyint NOT NULL,
    [cd_coligacao] char(4) NULL,
    [dt_ult_alt_lim_cred] smalldatetime NULL,
    [dt_recadastramento] smalldatetime NULL,
    [estrangeiro_nu_doc] varchar(30) NULL,
    [atu_ult_maior_compra] tinyint NOT NULL,
    [envia_arq_masterfoods] tinyint NULL,
    [dt_penult_compra] smalldatetime NULL,
    [vl_penult_compra] numeric(13,2) NULL,
    [enviado_redbull] tinyint NULL,
    [consumidor] tinyint NULL,
    [perc_aceito_prazo_validade] numeric(5,2) NULL,
    [cobra_seguro] tinyint NULL,
    [bloq_atu_ult_maior_compra] tinyint NULL,
    [perc_desc_fin_auto] numeric(13,4) NULL,
    [enviar_arq_pharmadis] bit NULL,
    [cliente_novo_pharmadis] bit NULL,
    [nc_util_cfg_abat_clien] tinyint NULL,
    [nc_tp_abat_clien] char(2) NULL,
    [cd_vend_tecnico] char(8) NULL,
    [cd_forn_inst] int NULL,
    [imp_desc_grd_com] tinyint NULL,
    [cnae] char(9) NULL,
    [seq_trib_cli] int NULL,
    [alt_tab_preco_afv] bit NULL,
    [alt_tp_ped_afv] bit NULL,
    [seq_rot_prdf_provisorio] bit NULL,
    [envia_pdv_bmc] bit NULL,
    [qtde_check_out] smallint NULL,
    [envia_pdv_cgm] bit NULL,
    [nao_excede_peso_prd] bit NULL,
    [dt_validade_suframa] datetime NULL,
    [RecebeEmailDocVenc] bit NULL,
    [CdEmpRemetente] int NULL,
    [envia_pdv_tgt] bit NULL,
    [AtualizacaoCadastro] bit NULL,
    [NestUpdatingFlag] varchar(1) NULL,
    [HealthUpdatingFlag] varchar(1) NULL,
    [PrecoVenda4Dec] bit NOT NULL,
    [PercDescGerAuto] numeric(13,4) NULL,
    [RotaPlanEntregaCritica] bit NOT NULL,
    [CortarQtdeFracionada] bit NOT NULL,
    [ClienteID] int NOT NULL,
    [VerificaSomenteLimiteCliente] bit NULL,
    [VerificaSomenteLimiteColigacao] bit NULL,
    [VerificaSomenteLimiteGrupo] bit NULL,
    [TempoDescargaMinutos] int NULL,
    [SemVendaSomenteAssociacao] bit NULL,
    [DistrImpostoParcTrec] char(4) NOT NULL,
    [SepaSubstNovoTitulo] bit NULL,
    [SepaSubstValorMinimo] numeric(13,2) NULL,
    [SepaSubstPrazoMaximo] int NULL,
    [ValorTaxaBoleto] numeric(13,2) NULL,
    [NaoRecebeVisitas] bit NULL,
    [Iban] varchar(50) NULL,
    [OperadoraCartaoCredito] bit NULL,
    [MLogSepaDestacaCliente] bit NOT NULL,
    [PrazoMinValidProdEmDias] int NULL,
    [GrupoEcommercePrincipal] bit NULL,
    [SepaSubstQtdeLimMaxParc] int NULL,
    [TpDoc] char(1) NULL,
    [Anonimizado] bit NULL,
    [IndenizacaoPerfilID] int NULL,
    [PaleteDedicado] bit NOT NULL,
    [IgnorarTituloVencidoNaoPago] bit NULL,
    [RegiaoRisco] nvarchar(100) NULL,
    [PermitirSaneamentoEndFa] bit NULL,
    [DataAtualizaDescRP] datetime NULL,
    [DtFundacao] smalldatetime NULL,
    [SeqTributacaoRegimeSefaz] tinyint NULL,
    [tipoVendaPdvID] int NULL,
    [RotaPTpTaxaDescarga] nvarchar(2) NULL,
    [RotaPValorTaxaDescarga] numeric(13,2) NULL,
    [ConfiguracaoCobrancaPixId] int NULL,
    [OrigemClienteID] int NOT NULL,
    [DataUltimaAtualizacaoCurvaABC] datetime NULL,
    [TipoAtualizacaoCurvaABCID] tinyint NULL,
    [TipoImpressaoModelo55ID] smallint NULL,
    [tgtedi_punto_operacional] varchar(20) NULL,
    [TgtCRM_cd_clien_crm] varchar(30) NULL,
    [tgtedi_departamento] varchar(10) NULL
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
