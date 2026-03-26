<!-- generated: lakehouse-object -->
# bronze.tipo_pedido_chokdistribuidora

- Tipo: `TABLE`
- Industria: `chokdistribuidora`
- Origem: `database:GA_DATALAKE`
- PKs: Nao identificado no banco
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | tp_ped | char(2) | False | False | False | - |
| 2 | descricao | varchar(30) | False | False | False | - |
| 3 | atualiza_estoque | bit | True | False | False | - |
| 4 | gera_titrec | bit | True | False | False | - |
| 5 | imprime_nf | bit | True | False | False | - |
| 6 | calcula_icm | bit | True | False | False | - |
| 7 | calcula_ipi | bit | True | False | False | - |
| 8 | estat_com | bit | True | False | False | - |
| 9 | principal | bit | True | False | False | - |
| 10 | transf_estoque | bit | True | False | False | - |
| 11 | cd_emp_transf | int | True | False | False | - |
| 12 | cd_local_transf | char(8) | True | False | False | - |
| 13 | calcula_icm_ipi | bit | True | False | False | - |
| 14 | ipi_base_calc_icm | bit | True | False | False | - |
| 15 | consignacao | bit | True | False | False | - |
| 16 | vda_posconsig | bit | True | False | False | - |
| 17 | dev_fornecedor | bit | True | False | False | - |
| 18 | vda_especial | bit | True | False | False | - |
| 19 | num_lock | int | False | False | False | - |
| 20 | ativo | int | False | False | False | - |
| 21 | icms_diferido | bit | True | False | False | - |
| 22 | comissao | bit | True | False | False | - |
| 23 | tp_ped_sr | char(2) | True | False | False | - |
| 24 | vs_principal | bit | True | False | False | - |
| 25 | curva_abc | bit | True | False | False | - |
| 26 | mail_cliente | bit | True | False | False | - |
| 27 | mail_vendedor | bit | True | False | False | - |
| 28 | tp_ped_palm | bit | True | False | False | - |
| 29 | bonificacao | bit | True | False | False | - |
| 30 | gera_meia_nota | bit | True | False | False | - |
| 31 | tp_ped_meia_nota | char(2) | True | False | False | - |
| 32 | perc_nota | numeric(7,4) | True | False | False | - |
| 33 | formpgto_meia_nota | char(2) | True | False | False | - |
| 34 | utiliza_preco_custo | bit | True | False | False | - |
| 35 | utiliza_preco_tp_custo | char(3) | True | False | False | - |
| 36 | destaque_pedido | char(8) | True | False | False | - |
| 37 | lote_manual | bit | True | False | False | - |
| 38 | prod_controlado | bit | True | False | False | - |
| 39 | baixa_lote | char(4) | True | False | False | - |
| 40 | vda_med_dia | bit | True | False | False | - |
| 41 | busca_cfop_excecao | bit | True | False | False | - |
| 42 | gera_verba | bit | True | False | False | - |
| 43 | restr_vda | bit | True | False | False | - |
| 44 | frete_base_calc_icm | bit | True | False | False | - |
| 45 | quebra_it_bonif | bit | True | False | False | - |
| 46 | tp_ped_bonif | char(2) | True | False | False | - |
| 47 | nf_item_preco_cheio | bit | True | False | False | - |
| 48 | imprime_orcamento | bit | True | False | False | - |
| 49 | calcula_icm_subst | bit | True | False | False | - |
| 50 | calcula_icm_ressarc | bit | True | False | False | - |
| 51 | atualiza_estoque_ctb | bit | True | False | False | - |
| 52 | imp_aliq_icm_isentos | bit | True | False | False | - |
| 53 | nao_calc_subst_titrec | bit | True | False | False | - |
| 54 | tp_quebra_meia_nf | char(2) | True | False | False | - |
| 55 | utiliza_preco_tp_custo_sem_icm | bit | True | False | False | - |
| 56 | mail_cliente_cod_mod | int | True | False | False | - |
| 57 | calcula_icm_ressarc_bonif | bit | True | False | False | - |
| 58 | icm_ressarc_soma_nf | bit | True | False | False | - |
| 59 | icm_ressarc_soma_titrec | bit | True | False | False | - |
| 60 | pedido_pf_x_pj | bit | True | False | False | - |
| 61 | venda_balcao | bit | True | False | False | - |
| 62 | somente_etapa_fatu | bit | True | False | False | - |
| 63 | outros_locais_est | bit | True | False | False | - |
| 64 | selec_lote_todos_itens | bit | True | False | False | - |
| 65 | utiliza_preco_custo_bonif | bit | True | False | False | - |
| 66 | utiliza_preco_tp_custo_bonif | char(3) | True | False | False | - |
| 67 | tp_ped_it_bonif | char(2) | True | False | False | - |
| 68 | utiliza_sit_trib_esp | bit | True | False | False | - |
| 69 | suframa | bit | True | False | False | - |
| 70 | servico | bit | True | False | False | - |
| 71 | inventario | bit | True | False | False | - |
| 72 | invent_tp_mov | char(1) | True | False | False | - |
| 73 | servico_tecnico_vend_princ | bit | True | False | False | - |
| 74 | transf_outros_locais_est | bit | True | False | False | - |
| 75 | elimina_filas_gerenciais | bit | True | False | False | - |
| 76 | calc_ipi_frete | bit | True | False | False | - |
| 77 | somente_etapa_fatu_gera_expe | bit | True | False | False | - |
| 78 | destaque_st_totais_nf | bit | True | False | False | - |
| 79 | destaque_st_dados_adic | bit | True | False | False | - |
| 80 | destaque_ipi_totais_nf | bit | True | False | False | - |
| 81 | destaque_ipi_dados_adic | bit | True | False | False | - |
| 82 | utiliza_preco_custo_sem_st | bit | True | False | False | - |
| 83 | gera_nf_compra_autom | bit | True | False | False | - |
| 84 | pedido_nf_entrada | bit | True | False | False | - |
| 85 | destaque_icm_item_st_totais_nf | bit | True | False | False | - |
| 86 | destaque_icm_item_st_dados_adic | bit | True | False | False | - |
| 87 | ressarc_industria | bit | True | False | False | - |
| 88 | outros_locais_est_falta_cd_emp | int | True | False | False | - |
| 89 | outros_locais_est_falta_cd_local | char(8) | True | False | False | - |
| 90 | verifica_limite_venda | bit | True | False | False | - |
| 92 | tp_vl_custo_transf_auto | char(2) | True | False | False | - |
| 93 | prod_bonif_valor_zerado | bit | True | False | False | - |
| 94 | prod_bonif_cst_espec | bit | True | False | False | - |
| 95 | st_aliq_dif | bit | True | False | False | - |
| 96 | isenta_pis_cofins | bit | True | False | False | - |
| 97 | cst_especifica_pis_cofins | smallint | True | False | False | - |
| 98 | TpEntradaTransfAuto | int | True | False | False | - |
| 99 | ConsumidorFinal | bit | True | False | False | - |
| 100 | UtilizaTribEstDest | bit | True | False | False | - |
| 101 | ipi_base_calc_pis_cofins | bit | True | False | False | - |
| 102 | UtilizaRecopi | bit | False | False | False | - |
| 103 | DescGerAutoCli | bit | True | False | False | - |
| 104 | EnvioPdv | bit | False | False | False | - |
| 105 | PermiteAltLogistica | bit | True | False | False | - |
| 106 | PedidoNFEntradaDevCliente | bit | True | False | False | - |
| 107 | TipoNFConsumidorFinal | varchar(10) | True | False | False | - |
| 108 | IdentificaDestinatarioNFCe | bit | True | False | False | - |
| 109 | InformaCpfCnpjNFCe | bit | True | False | False | - |
| 110 | PrecoCheioItens | int | True | False | False | - |
| 111 | VlDespAcesBasePisCofins | bit | True | False | False | - |
| 112 | TransfSitTribCadastroICMS | bit | True | False | False | - |
| 113 | EntregaPorOrdemDoDestinatario | bit | True | False | False | - |
| 114 | CalculoICMSSTConvenio52 | bit | True | False | False | - |
| 115 | TpPedID | int | False | False | False | - |
| 116 | SubtraiICMSBasePisCofins | bit | True | False | False | - |
| 117 | UtilizaLocEstConsig | bit | True | False | False | - |
| 118 | RespeitaQtdeMinimaProduto | bit | False | False | False | - |
| 119 | RespeitaQtdeMultiplaProduto | bit | False | False | False | - |
| 120 | UtilizaICMSEfetivo | bit | True | False | False | - |
| 121 | TipoCSTICMSCompraID | tinyint | True | False | False | - |
| 122 | transferenciaAtacadista | bit | True | False | False | - |
| 123 | ignorarValorMinimoCondPgto | bit | True | False | False | - |
| 124 | utilizaTextoGravacao | bit | True | False | False | - |
| 125 | imp_aliq_icm_itens | bit | True | False | False | - |
| 126 | automatico | bit | True | False | False | - |
| 127 | armazenagem | bit | True | False | False | - |
| 128 | automat_3_casa | bit | True | False | False | - |
| 129 | tp_ped_edi | char(3) | True | False | False | - |
| 130 | UtilizaTransfEst | bit | True | False | False | - |
| 131 | RespeitaQtdeMaxProduto | bit | True | False | False | - |
| 132 | PedidoNFEntradaAtualizaEstoque | bit | True | False | False | - |
| 133 | UtilizaLicitacao | bit | True | False | False | - |
| 134 | PedidoNFEntradaAtualizaEstoqueCtb | bit | True | False | False | - |
| 135 | EscolhaLoteAuto | bit | True | False | False | - |
| 136 | ConsideraRestStMgCtb | bit | True | False | False | - |
| 137 | utilizaFaturamentoAutomatico | bit | True | False | False | - |
| 138 | FaturamentoAutomaticoSomenteEmRoteiro | bit | True | False | False | - |
| 139 | EnviaElanco | bit | True | False | False | - |
| 140 | CalculaDifal | bit | True | False | False | - |
| 141 | QuebraItVasilhame | bit | True | False | False | - |
| 142 | TpPedVasilhame | char(2) | True | False | False | - |
| 143 | IgnorarValidacaoValorMinPedido | bit | True | False | False | - |
| 144 | ValeUnico | bit | True | False | False | - |
| 145 | ValePermanente | bit | True | False | False | - |
| 146 | EntradaSimbOpme | bit | True | False | False | - |
| 147 | ConsumoOpme | bit | True | False | False | - |
| 148 | ReposicaoOpme | bit | True | False | False | - |
| 149 | EntradaSimbolicaMensal | bit | True | False | False | - |
| 150 | SaidaSimbolicaMensal | bit | True | False | False | - |
| 151 | respeitaPrazoValMin | bit | False | False | False | - |
| 152 | RotaPlanTpCor | nvarchar(20) | True | False | False | - |
| 153 | SomenteEtapaFatuGeraCredito | bit | True | False | False | - |
| 154 | PrecoCustoBonifCalculoVerba | char(1) | True | False | False | - |
| 155 | GeraInspecaoOpme | bit | True | False | False | - |
| 156 | TipoOperacaoControleSaldoID | int | True | False | False | - |
| 157 | EtapaOperacaoControleSaldoID | int | True | False | False | - |
| 158 | ModeloComissaoDiferenciado | bit | True | False | False | - |
| 159 | MomentoLancamentoComissao | char(4) | True | False | False | - |
| 160 | PercComissaoFaturamento | numeric(7,4) | True | False | False | - |
| 161 | IgnorarValidacaoICMS | bit | True | False | False | - |
| 162 | PassagemObrigatoria | bit | True | False | False | - |
| 163 | TransferenciaAssociacaoNfRecm | bit | True | False | False | - |
| 164 | MomentoMovimentacaoEstoqueFisicoID | tinyint | True | False | False | - |
| 165 | CdTabelaValorMaximoPedidoComplementar | char(8) | True | False | False | - |
| 166 | CdEmpPedidoComplementar | int | True | False | False | - |
| 167 | NaoGerarEntradasESaidasSimbolicasMensais | bit | True | False | False | - |
| 168 | UtilizaOutraImpressoraNFe | bit | True | False | False | - |
| 169 | OutraImpressoraNFe | varchar(250) | True | False | False | - |
| 170 | SubtraiICMSSTBasePisCofins | bit | True | False | False | - |
| 171 | TransferenciaValorItens | tinyint | True | False | False | - |
| 172 | TransferenciaGerarTituloPagar | bit | True | False | False | - |
| 173 | GeraVasilhames | bit | True | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL Reconstruida

```sql
CREATE TABLE [bronze].[tipo_pedido_chokdistribuidora] (
    [tp_ped] char(2) NOT NULL,
    [descricao] varchar(30) NOT NULL,
    [atualiza_estoque] bit NULL,
    [gera_titrec] bit NULL,
    [imprime_nf] bit NULL,
    [calcula_icm] bit NULL,
    [calcula_ipi] bit NULL,
    [estat_com] bit NULL,
    [principal] bit NULL,
    [transf_estoque] bit NULL,
    [cd_emp_transf] int NULL,
    [cd_local_transf] char(8) NULL,
    [calcula_icm_ipi] bit NULL,
    [ipi_base_calc_icm] bit NULL,
    [consignacao] bit NULL,
    [vda_posconsig] bit NULL,
    [dev_fornecedor] bit NULL,
    [vda_especial] bit NULL,
    [num_lock] int NOT NULL,
    [ativo] int NOT NULL,
    [icms_diferido] bit NULL,
    [comissao] bit NULL,
    [tp_ped_sr] char(2) NULL,
    [vs_principal] bit NULL,
    [curva_abc] bit NULL,
    [mail_cliente] bit NULL,
    [mail_vendedor] bit NULL,
    [tp_ped_palm] bit NULL,
    [bonificacao] bit NULL,
    [gera_meia_nota] bit NULL,
    [tp_ped_meia_nota] char(2) NULL,
    [perc_nota] numeric(7,4) NULL,
    [formpgto_meia_nota] char(2) NULL,
    [utiliza_preco_custo] bit NULL,
    [utiliza_preco_tp_custo] char(3) NULL,
    [destaque_pedido] char(8) NULL,
    [lote_manual] bit NULL,
    [prod_controlado] bit NULL,
    [baixa_lote] char(4) NULL,
    [vda_med_dia] bit NULL,
    [busca_cfop_excecao] bit NULL,
    [gera_verba] bit NULL,
    [restr_vda] bit NULL,
    [frete_base_calc_icm] bit NULL,
    [quebra_it_bonif] bit NULL,
    [tp_ped_bonif] char(2) NULL,
    [nf_item_preco_cheio] bit NULL,
    [imprime_orcamento] bit NULL,
    [calcula_icm_subst] bit NULL,
    [calcula_icm_ressarc] bit NULL,
    [atualiza_estoque_ctb] bit NULL,
    [imp_aliq_icm_isentos] bit NULL,
    [nao_calc_subst_titrec] bit NULL,
    [tp_quebra_meia_nf] char(2) NULL,
    [utiliza_preco_tp_custo_sem_icm] bit NULL,
    [mail_cliente_cod_mod] int NULL,
    [calcula_icm_ressarc_bonif] bit NULL,
    [icm_ressarc_soma_nf] bit NULL,
    [icm_ressarc_soma_titrec] bit NULL,
    [pedido_pf_x_pj] bit NULL,
    [venda_balcao] bit NULL,
    [somente_etapa_fatu] bit NULL,
    [outros_locais_est] bit NULL,
    [selec_lote_todos_itens] bit NULL,
    [utiliza_preco_custo_bonif] bit NULL,
    [utiliza_preco_tp_custo_bonif] char(3) NULL,
    [tp_ped_it_bonif] char(2) NULL,
    [utiliza_sit_trib_esp] bit NULL,
    [suframa] bit NULL,
    [servico] bit NULL,
    [inventario] bit NULL,
    [invent_tp_mov] char(1) NULL,
    [servico_tecnico_vend_princ] bit NULL,
    [transf_outros_locais_est] bit NULL,
    [elimina_filas_gerenciais] bit NULL,
    [calc_ipi_frete] bit NULL,
    [somente_etapa_fatu_gera_expe] bit NULL,
    [destaque_st_totais_nf] bit NULL,
    [destaque_st_dados_adic] bit NULL,
    [destaque_ipi_totais_nf] bit NULL,
    [destaque_ipi_dados_adic] bit NULL,
    [utiliza_preco_custo_sem_st] bit NULL,
    [gera_nf_compra_autom] bit NULL,
    [pedido_nf_entrada] bit NULL,
    [destaque_icm_item_st_totais_nf] bit NULL,
    [destaque_icm_item_st_dados_adic] bit NULL,
    [ressarc_industria] bit NULL,
    [outros_locais_est_falta_cd_emp] int NULL,
    [outros_locais_est_falta_cd_local] char(8) NULL,
    [verifica_limite_venda] bit NULL,
    [tp_vl_custo_transf_auto] char(2) NULL,
    [prod_bonif_valor_zerado] bit NULL,
    [prod_bonif_cst_espec] bit NULL,
    [st_aliq_dif] bit NULL,
    [isenta_pis_cofins] bit NULL,
    [cst_especifica_pis_cofins] smallint NULL,
    [TpEntradaTransfAuto] int NULL,
    [ConsumidorFinal] bit NULL,
    [UtilizaTribEstDest] bit NULL,
    [ipi_base_calc_pis_cofins] bit NULL,
    [UtilizaRecopi] bit NOT NULL,
    [DescGerAutoCli] bit NULL,
    [EnvioPdv] bit NOT NULL,
    [PermiteAltLogistica] bit NULL,
    [PedidoNFEntradaDevCliente] bit NULL,
    [TipoNFConsumidorFinal] varchar(10) NULL,
    [IdentificaDestinatarioNFCe] bit NULL,
    [InformaCpfCnpjNFCe] bit NULL,
    [PrecoCheioItens] int NULL,
    [VlDespAcesBasePisCofins] bit NULL,
    [TransfSitTribCadastroICMS] bit NULL,
    [EntregaPorOrdemDoDestinatario] bit NULL,
    [CalculoICMSSTConvenio52] bit NULL,
    [TpPedID] int NOT NULL,
    [SubtraiICMSBasePisCofins] bit NULL,
    [UtilizaLocEstConsig] bit NULL,
    [RespeitaQtdeMinimaProduto] bit NOT NULL,
    [RespeitaQtdeMultiplaProduto] bit NOT NULL,
    [UtilizaICMSEfetivo] bit NULL,
    [TipoCSTICMSCompraID] tinyint NULL,
    [transferenciaAtacadista] bit NULL,
    [ignorarValorMinimoCondPgto] bit NULL,
    [utilizaTextoGravacao] bit NULL,
    [imp_aliq_icm_itens] bit NULL,
    [automatico] bit NULL,
    [armazenagem] bit NULL,
    [automat_3_casa] bit NULL,
    [tp_ped_edi] char(3) NULL,
    [UtilizaTransfEst] bit NULL,
    [RespeitaQtdeMaxProduto] bit NULL,
    [PedidoNFEntradaAtualizaEstoque] bit NULL,
    [UtilizaLicitacao] bit NULL,
    [PedidoNFEntradaAtualizaEstoqueCtb] bit NULL,
    [EscolhaLoteAuto] bit NULL,
    [ConsideraRestStMgCtb] bit NULL,
    [utilizaFaturamentoAutomatico] bit NULL,
    [FaturamentoAutomaticoSomenteEmRoteiro] bit NULL,
    [EnviaElanco] bit NULL,
    [CalculaDifal] bit NULL,
    [QuebraItVasilhame] bit NULL,
    [TpPedVasilhame] char(2) NULL,
    [IgnorarValidacaoValorMinPedido] bit NULL,
    [ValeUnico] bit NULL,
    [ValePermanente] bit NULL,
    [EntradaSimbOpme] bit NULL,
    [ConsumoOpme] bit NULL,
    [ReposicaoOpme] bit NULL,
    [EntradaSimbolicaMensal] bit NULL,
    [SaidaSimbolicaMensal] bit NULL,
    [respeitaPrazoValMin] bit NOT NULL,
    [RotaPlanTpCor] nvarchar(20) NULL,
    [SomenteEtapaFatuGeraCredito] bit NULL,
    [PrecoCustoBonifCalculoVerba] char(1) NULL,
    [GeraInspecaoOpme] bit NULL,
    [TipoOperacaoControleSaldoID] int NULL,
    [EtapaOperacaoControleSaldoID] int NULL,
    [ModeloComissaoDiferenciado] bit NULL,
    [MomentoLancamentoComissao] char(4) NULL,
    [PercComissaoFaturamento] numeric(7,4) NULL,
    [IgnorarValidacaoICMS] bit NULL,
    [PassagemObrigatoria] bit NULL,
    [TransferenciaAssociacaoNfRecm] bit NULL,
    [MomentoMovimentacaoEstoqueFisicoID] tinyint NULL,
    [CdTabelaValorMaximoPedidoComplementar] char(8) NULL,
    [CdEmpPedidoComplementar] int NULL,
    [NaoGerarEntradasESaidasSimbolicasMensais] bit NULL,
    [UtilizaOutraImpressoraNFe] bit NULL,
    [OutraImpressoraNFe] varchar(250) NULL,
    [SubtraiICMSSTBasePisCofins] bit NULL,
    [TransferenciaValorItens] tinyint NULL,
    [TransferenciaGerarTituloPagar] bit NULL,
    [GeraVasilhames] bit NULL
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
