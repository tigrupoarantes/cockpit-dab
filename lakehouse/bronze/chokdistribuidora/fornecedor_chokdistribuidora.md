<!-- generated: lakehouse-object -->
# bronze.fornecedor_chokdistribuidora

- Tipo: `TABLE`
- Industria: `chokdistribuidora`
- Origem: `database:GA_DATALAKE`
- PKs: Nao identificado no banco
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | cd_forn | int | False | False | False | - |
| 2 | tp_forn | char(1) | True | False | False | - |
| 3 | ram_ativ | char(4) | True | False | False | - |
| 4 | raz_soc | varchar(60) | False | False | False | - |
| 5 | nome_fant | varchar(20) | True | False | False | - |
| 6 | tp_pes | char(1) | True | False | False | - |
| 7 | cgc_cpf | varchar(14) | True | False | False | - |
| 8 | tp_inscr | char(1) | True | False | False | - |
| 9 | inscricao | varchar(20) | True | False | False | - |
| 10 | cd_conta_principal | char(15) | True | False | False | - |
| 11 | dt_cad | smalldatetime | False | False | False | - |
| 12 | dt_ult_alt | smalldatetime | True | False | False | - |
| 13 | cliente | tinyint | True | False | False | - |
| 14 | num_lock | tinyint | False | False | False | - |
| 15 | ativo | bit | True | False | False | - |
| 16 | cd_forn_aux | varchar(30) | True | False | False | - |
| 17 | web_site | varchar(50) | True | False | False | - |
| 18 | e_mail | varchar(80) | True | False | False | - |
| 19 | ean_13 | varchar(13) | True | False | False | - |
| 20 | cd_forma_pgto | char(4) | True | False | False | - |
| 21 | cd_texto | int | True | False | False | - |
| 22 | perc_desc_fin | numeric(6,4) | True | False | False | - |
| 23 | cnae | char(9) | True | False | False | - |
| 24 | nfe_obriga_ped_comp | bit | True | False | False | - |
| 25 | referencia_padrao | varchar(30) | True | False | False | - |
| 27 | nf_serv_edicao_retencoes | bit | True | False | False | - |
| 28 | ProdutorRural | bit | True | False | False | - |
| 29 | EdiImsCompraCaixaPostal | varchar(35) | True | False | False | - |
| 30 | nfe_tp_vl_itens | varchar(1) | False | False | False | - |
| 31 | FornecID | int | False | False | False | - |
| 32 | CancAutoPedCompraQtdeDias | smallint | True | False | False | - |
| 33 | CodTranspFrenetIntegracao | nvarchar(15) | True | False | False | - |
| 34 | Anonimizado | bit | True | False | False | - |
| 35 | TipoVencimentoGeraTituloAutoCTeID | tinyint | True | False | False | - |
| 36 | DiaVencEmissPrimQuinzGeraTituloAutoCTe | int | True | False | False | - |
| 37 | DiaVencEmissSegQuinzGeraTituloAutoCTe | int | True | False | False | - |
| 38 | DiaVencFixoGeraTituloAutoCTe | int | True | False | False | - |
| 39 | QtdeDiasVencAPartirEmissaoGeraTituloAutoCTe | int | True | False | False | - |
| 40 | SeqTributacaoRegime | tinyint | True | False | False | - |
| 41 | LeadTimeEntrega | int | True | False | False | - |
| 42 | RegimeEspecialMG | bit | True | False | False | - |
| 43 | ValorMinPedidoCompra | numeric(13,2) | True | False | False | - |
| 44 | ImpressoraFavorita | varchar(250) | True | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL Reconstruida

```sql
CREATE TABLE [bronze].[fornecedor_chokdistribuidora] (
    [cd_forn] int NOT NULL,
    [tp_forn] char(1) NULL,
    [ram_ativ] char(4) NULL,
    [raz_soc] varchar(60) NOT NULL,
    [nome_fant] varchar(20) NULL,
    [tp_pes] char(1) NULL,
    [cgc_cpf] varchar(14) NULL,
    [tp_inscr] char(1) NULL,
    [inscricao] varchar(20) NULL,
    [cd_conta_principal] char(15) NULL,
    [dt_cad] smalldatetime NOT NULL,
    [dt_ult_alt] smalldatetime NULL,
    [cliente] tinyint NULL,
    [num_lock] tinyint NOT NULL,
    [ativo] bit NULL,
    [cd_forn_aux] varchar(30) NULL,
    [web_site] varchar(50) NULL,
    [e_mail] varchar(80) NULL,
    [ean_13] varchar(13) NULL,
    [cd_forma_pgto] char(4) NULL,
    [cd_texto] int NULL,
    [perc_desc_fin] numeric(6,4) NULL,
    [cnae] char(9) NULL,
    [nfe_obriga_ped_comp] bit NULL,
    [referencia_padrao] varchar(30) NULL,
    [nf_serv_edicao_retencoes] bit NULL,
    [ProdutorRural] bit NULL,
    [EdiImsCompraCaixaPostal] varchar(35) NULL,
    [nfe_tp_vl_itens] varchar(1) NOT NULL,
    [FornecID] int NOT NULL,
    [CancAutoPedCompraQtdeDias] smallint NULL,
    [CodTranspFrenetIntegracao] nvarchar(15) NULL,
    [Anonimizado] bit NULL,
    [TipoVencimentoGeraTituloAutoCTeID] tinyint NULL,
    [DiaVencEmissPrimQuinzGeraTituloAutoCTe] int NULL,
    [DiaVencEmissSegQuinzGeraTituloAutoCTe] int NULL,
    [DiaVencFixoGeraTituloAutoCTe] int NULL,
    [QtdeDiasVencAPartirEmissaoGeraTituloAutoCTe] int NULL,
    [SeqTributacaoRegime] tinyint NULL,
    [LeadTimeEntrega] int NULL,
    [RegimeEspecialMG] bit NULL,
    [ValorMinPedidoCompra] numeric(13,2) NULL,
    [ImpressoraFavorita] varchar(250) NULL
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
