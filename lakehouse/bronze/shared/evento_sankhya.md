<!-- generated: lakehouse-object -->
# bronze.evento_sankhya

- Tipo: `TABLE`
- Industria: `shared`
- Origem: `database:GA_DATALAKE`
- PKs: Nao identificado no banco
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | CODEVENTO | numeric(5,0) | False | False | False | - |
| 2 | DESCREVENTO | varchar(100) | False | False | False | - |
| 3 | UNIDADE | varchar(1) | False | False | False | - |
| 4 | CODFORM | numeric(5,0) | True | False | False | - |
| 5 | INDICE | float | True | False | False | - |
| 6 | VLREVENTO | float | True | False | False | - |
| 7 | IMPHOLLERIT | varchar(1) | True | False | False | - |
| 8 | INCSOBREMEDIAS | varchar(1) | True | False | False | - |
| 9 | BASEINFREND | varchar(1) | False | False | False | - |
| 10 | BASEMARGCONSIG | varchar(1) | False | False | False | - |
| 11 | PROTEGIDO | varchar(1) | False | False | False | - |
| 12 | BASERAIS | varchar(1) | True | False | False | - |
| 13 | SEQCALCULO | float | True | False | False | - |
| 14 | ACUMULADOR | varchar(1) | False | False | False | - |
| 15 | BASELIQUIDO | varchar(1) | False | False | False | - |
| 16 | FOLHA | varchar(1) | False | False | False | - |
| 17 | FERIAS | varchar(1) | False | False | False | - |
| 18 | RESCISAO | varchar(1) | False | False | False | - |
| 19 | DECTERC | varchar(1) | False | False | False | - |
| 20 | SEMANAL | varchar(1) | False | False | False | - |
| 21 | ADIANTAMENTO | varchar(1) | False | False | False | - |
| 22 | DTALTER | datetime2(7) | False | False | False | - |
| 23 | DOCUMENTACAOBKP | image | True | False | False | - |
| 24 | CODUSU | numeric(5,0) | True | False | False | - |
| 25 | PENSAO | varchar(1) | False | False | False | - |
| 26 | CODCENCUS | numeric(10,0) | False | False | False | - |
| 27 | CODNAT | numeric(10,0) | False | False | False | - |
| 28 | PROVISAOFIN | numeric(5,0) | False | False | False | - |
| 29 | INCORPORA | varchar(1) | False | False | False | - |
| 30 | CODEVERESILICAO | numeric(5,0) | True | False | False | - |
| 31 | RESILICAO | varchar(1) | False | False | False | - |
| 32 | COMPLEMENTORESC | varchar(1) | False | False | False | - |
| 33 | REGCALCULO | varchar(1) | True | False | False | - |
| 34 | TIPEVENTO | numeric(5,0) | False | False | False | - |
| 35 | ATIVO | varchar(1) | False | False | False | - |
| 36 | SANKHYA | varchar(1) | False | False | False | - |
| 37 | IDENTIFICACAO | numeric(5,0) | False | False | False | - |
| 38 | TIPOINSS | numeric(5,0) | False | False | False | - |
| 39 | TIPOIRRF | numeric(5,0) | False | False | False | - |
| 40 | FGTS | varchar(1) | False | False | False | - |
| 41 | FGTSDECTERCEIRO | varchar(1) | False | False | False | - |
| 42 | BASEAUXILIAR | varchar(1) | False | False | False | - |
| 43 | PIS | varchar(1) | False | False | False | - |
| 44 | ISS | varchar(1) | False | False | False | - |
| 45 | INFCOMPLRAIS1 | numeric(5,0) | False | False | False | - |
| 46 | INFCOMPLRAIS2 | numeric(5,0) | False | False | False | - |
| 47 | GRRFMES | varchar(1) | False | False | False | - |
| 48 | GRRFMESANTERIOR | varchar(1) | False | False | False | - |
| 49 | GRRFINDENIZACAO | varchar(1) | False | False | False | - |
| 50 | BASESEFIP | numeric(5,0) | False | False | False | - |
| 51 | FGTSSEFIP | varchar(1) | False | False | False | - |
| 52 | INSSSEFIP | varchar(1) | False | False | False | - |
| 53 | CODEVECORRELATO | numeric(5,0) | True | False | False | - |
| 54 | RUBRICAMTE | numeric(5,0) | True | False | False | - |
| 55 | CODOUTRASMTE | numeric(5,0) | True | False | False | - |
| 56 | INDICEADMEDIAS | float | True | False | False | - |
| 57 | USADOESOCIAL | varchar(1) | False | False | False | - |
| 58 | CODNATRUBRICA | varchar(4) | True | False | False | - |
| 59 | CONTRIBSIND | varchar(1) | False | False | False | - |
| 60 | RUBRICADSR | varchar(1) | False | False | False | - |
| 61 | RUBRICA13 | varchar(1) | False | False | False | - |
| 62 | RUBRICAFERIAS | varchar(1) | False | False | False | - |
| 63 | RUBRICARESCISAO | varchar(1) | False | False | False | - |
| 64 | TEMCOMPLEMENTO | varchar(1) | False | False | False | - |
| 65 | CODEVECOMPLEMENTO | numeric(5,0) | True | False | False | - |
| 66 | COMPLEMENTAR | varchar(1) | False | False | False | - |
| 67 | PLR | varchar(1) | False | False | False | - |
| 68 | INTEGRACTB | varchar(1) | False | False | False | - |
| 69 | DSCSALVAR | varchar(90) | True | False | False | - |
| 70 | FGTSRESCISAO | varchar(1) | False | False | False | - |
| 71 | CODCRIRATEIO | numeric(5,0) | True | False | False | - |
| 72 | GRUPOMEDIAS | varchar(20) | True | False | False | - |
| 73 | PENSAOSALLIQUIDO | varchar(1) | False | False | False | - |
| 74 | PENSAOSALBRUTO | varchar(1) | False | False | False | - |
| 75 | PENSAOSALMINIMO | varchar(1) | False | False | False | - |
| 76 | DOCUMENTACAO | text | True | False | False | - |
| 77 | CODINCCP | varchar(2) | True | False | False | - |
| 78 | CODINCIRRF | varchar(4) | True | False | False | - |
| 79 | CODINCFGTS | varchar(2) | True | False | False | - |
| 80 | CODINCSIND | varchar(2) | True | False | False | - |
| 81 | GRUPOEVENTO | numeric(10,0) | False | False | False | - |
| 82 | PSEUDOCODEVENTO | numeric(10,0) | True | False | False | - |
| 83 | CODMOEDA | numeric(5,0) | True | False | False | - |
| 84 | USACODMOEDA | varchar(1) | False | False | False | - |
| 85 | INDENIZACAOAPI | varchar(1) | False | False | False | - |
| 86 | ATIVOW | varchar(1) | False | False | False | - |
| 87 | CHECKSUM | varchar(64) | True | False | False | - |
| 88 | INTERMITENTE | varchar(1) | False | False | False | - |
| 89 | EVENTOFALTA | varchar(1) | True | False | False | - |
| 90 | EVENTODSR | varchar(1) | True | False | False | - |
| 91 | CODEVERRACPL | numeric(5,0) | True | False | False | - |
| 92 | CODEVEFLRES | varchar(1) | True | False | False | - |
| 93 | CONSPROGFER | varchar(1) | False | False | False | - |
| 94 | DIASCPROGFER | numeric(10,0) | True | False | False | - |
| 95 | DTINATAPARDE | datetime2(7) | True | False | False | - |
| 96 | UTSALBASEARED | varchar(1) | False | False | False | - |
| 97 | CODEVEFLFER | varchar(1) | False | False | False | - |
| 98 | USALEI10820 | varchar(1) | False | False | False | - |
| 99 | IGPMCOMISSAO | numeric(5,0) | True | False | False | - |
| 100 | INPCCOMISSAO | numeric(5,0) | True | False | False | - |
| 101 | REFLEXIVOS | varchar(100) | True | False | False | - |
| 102 | PROVIFERIAS | varchar(1) | True | False | False | - |
| 103 | PROVIDECTERSAL | varchar(1) | True | False | False | - |
| 104 | DTATUALIZACAO | datetime2(7) | True | False | False | - |
| 105 | EVENTORRA | varchar(1) | False | False | False | - |
| 106 | CRIAEVTATUALIZACAO | varchar(1) | False | False | False | - |
| 107 | CARACTERISTICA | varchar(25) | True | False | False | - |
| 108 | CRIADOW | varchar(1) | True | False | False | - |
| 109 | CODINCPIS | varchar(2) | True | False | False | - |
| 110 | PISDECTERCEIRO | varchar(1) | True | False | False | - |
| 111 | HASH | varchar(255) | True | False | False | - |
| 112 | AVULSO | varchar(1) | False | False | False | - |
| 113 | IGNORAENVIOESOCIAL | varchar(1) | True | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL Reconstruida

```sql
CREATE TABLE [bronze].[evento_sankhya] (
    [CODEVENTO] numeric(5,0) NOT NULL,
    [DESCREVENTO] varchar(100) NOT NULL,
    [UNIDADE] varchar(1) NOT NULL,
    [CODFORM] numeric(5,0) NULL,
    [INDICE] float NULL,
    [VLREVENTO] float NULL,
    [IMPHOLLERIT] varchar(1) NULL,
    [INCSOBREMEDIAS] varchar(1) NULL,
    [BASEINFREND] varchar(1) NOT NULL,
    [BASEMARGCONSIG] varchar(1) NOT NULL,
    [PROTEGIDO] varchar(1) NOT NULL,
    [BASERAIS] varchar(1) NULL,
    [SEQCALCULO] float NULL,
    [ACUMULADOR] varchar(1) NOT NULL,
    [BASELIQUIDO] varchar(1) NOT NULL,
    [FOLHA] varchar(1) NOT NULL,
    [FERIAS] varchar(1) NOT NULL,
    [RESCISAO] varchar(1) NOT NULL,
    [DECTERC] varchar(1) NOT NULL,
    [SEMANAL] varchar(1) NOT NULL,
    [ADIANTAMENTO] varchar(1) NOT NULL,
    [DTALTER] datetime2(7) NOT NULL,
    [DOCUMENTACAOBKP] image NULL,
    [CODUSU] numeric(5,0) NULL,
    [PENSAO] varchar(1) NOT NULL,
    [CODCENCUS] numeric(10,0) NOT NULL,
    [CODNAT] numeric(10,0) NOT NULL,
    [PROVISAOFIN] numeric(5,0) NOT NULL,
    [INCORPORA] varchar(1) NOT NULL,
    [CODEVERESILICAO] numeric(5,0) NULL,
    [RESILICAO] varchar(1) NOT NULL,
    [COMPLEMENTORESC] varchar(1) NOT NULL,
    [REGCALCULO] varchar(1) NULL,
    [TIPEVENTO] numeric(5,0) NOT NULL,
    [ATIVO] varchar(1) NOT NULL,
    [SANKHYA] varchar(1) NOT NULL,
    [IDENTIFICACAO] numeric(5,0) NOT NULL,
    [TIPOINSS] numeric(5,0) NOT NULL,
    [TIPOIRRF] numeric(5,0) NOT NULL,
    [FGTS] varchar(1) NOT NULL,
    [FGTSDECTERCEIRO] varchar(1) NOT NULL,
    [BASEAUXILIAR] varchar(1) NOT NULL,
    [PIS] varchar(1) NOT NULL,
    [ISS] varchar(1) NOT NULL,
    [INFCOMPLRAIS1] numeric(5,0) NOT NULL,
    [INFCOMPLRAIS2] numeric(5,0) NOT NULL,
    [GRRFMES] varchar(1) NOT NULL,
    [GRRFMESANTERIOR] varchar(1) NOT NULL,
    [GRRFINDENIZACAO] varchar(1) NOT NULL,
    [BASESEFIP] numeric(5,0) NOT NULL,
    [FGTSSEFIP] varchar(1) NOT NULL,
    [INSSSEFIP] varchar(1) NOT NULL,
    [CODEVECORRELATO] numeric(5,0) NULL,
    [RUBRICAMTE] numeric(5,0) NULL,
    [CODOUTRASMTE] numeric(5,0) NULL,
    [INDICEADMEDIAS] float NULL,
    [USADOESOCIAL] varchar(1) NOT NULL,
    [CODNATRUBRICA] varchar(4) NULL,
    [CONTRIBSIND] varchar(1) NOT NULL,
    [RUBRICADSR] varchar(1) NOT NULL,
    [RUBRICA13] varchar(1) NOT NULL,
    [RUBRICAFERIAS] varchar(1) NOT NULL,
    [RUBRICARESCISAO] varchar(1) NOT NULL,
    [TEMCOMPLEMENTO] varchar(1) NOT NULL,
    [CODEVECOMPLEMENTO] numeric(5,0) NULL,
    [COMPLEMENTAR] varchar(1) NOT NULL,
    [PLR] varchar(1) NOT NULL,
    [INTEGRACTB] varchar(1) NOT NULL,
    [DSCSALVAR] varchar(90) NULL,
    [FGTSRESCISAO] varchar(1) NOT NULL,
    [CODCRIRATEIO] numeric(5,0) NULL,
    [GRUPOMEDIAS] varchar(20) NULL,
    [PENSAOSALLIQUIDO] varchar(1) NOT NULL,
    [PENSAOSALBRUTO] varchar(1) NOT NULL,
    [PENSAOSALMINIMO] varchar(1) NOT NULL,
    [DOCUMENTACAO] text NULL,
    [CODINCCP] varchar(2) NULL,
    [CODINCIRRF] varchar(4) NULL,
    [CODINCFGTS] varchar(2) NULL,
    [CODINCSIND] varchar(2) NULL,
    [GRUPOEVENTO] numeric(10,0) NOT NULL,
    [PSEUDOCODEVENTO] numeric(10,0) NULL,
    [CODMOEDA] numeric(5,0) NULL,
    [USACODMOEDA] varchar(1) NOT NULL,
    [INDENIZACAOAPI] varchar(1) NOT NULL,
    [ATIVOW] varchar(1) NOT NULL,
    [CHECKSUM] varchar(64) NULL,
    [INTERMITENTE] varchar(1) NOT NULL,
    [EVENTOFALTA] varchar(1) NULL,
    [EVENTODSR] varchar(1) NULL,
    [CODEVERRACPL] numeric(5,0) NULL,
    [CODEVEFLRES] varchar(1) NULL,
    [CONSPROGFER] varchar(1) NOT NULL,
    [DIASCPROGFER] numeric(10,0) NULL,
    [DTINATAPARDE] datetime2(7) NULL,
    [UTSALBASEARED] varchar(1) NOT NULL,
    [CODEVEFLFER] varchar(1) NOT NULL,
    [USALEI10820] varchar(1) NOT NULL,
    [IGPMCOMISSAO] numeric(5,0) NULL,
    [INPCCOMISSAO] numeric(5,0) NULL,
    [REFLEXIVOS] varchar(100) NULL,
    [PROVIFERIAS] varchar(1) NULL,
    [PROVIDECTERSAL] varchar(1) NULL,
    [DTATUALIZACAO] datetime2(7) NULL,
    [EVENTORRA] varchar(1) NOT NULL,
    [CRIAEVTATUALIZACAO] varchar(1) NOT NULL,
    [CARACTERISTICA] varchar(25) NULL,
    [CRIADOW] varchar(1) NULL,
    [CODINCPIS] varchar(2) NULL,
    [PISDECTERCEIRO] varchar(1) NULL,
    [HASH] varchar(255) NULL,
    [AVULSO] varchar(1) NOT NULL,
    [IGNORAENVIOESOCIAL] varchar(1) NULL
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
