<!-- generated: lakehouse-object -->
# bronze.empresa_sankhya

- Tipo: `TABLE`
- Industria: `shared`
- Origem: `database:GA_DATALAKE`
- PKs: Nao identificado no banco
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | CODEMP | numeric(5,0) | False | False | False | - |
| 2 | NOMEFANTASIA | varchar(40) | True | False | False | - |
| 3 | RAZAOSOCIAL | varchar(40) | True | False | False | - |
| 4 | RAZAOABREV | varchar(15) | False | False | False | - |
| 5 | CODEMPMATRIZ | numeric(5,0) | True | False | False | - |
| 6 | CODEND | numeric(10,0) | True | False | False | - |
| 7 | NUMEND | varchar(6) | True | False | False | - |
| 8 | COMPLEMENTO | varchar(10) | True | False | False | - |
| 9 | CODBAI | numeric(10,0) | False | False | False | - |
| 10 | CODCID | numeric(10,0) | True | False | False | - |
| 11 | CEP | varchar(8) | True | False | False | - |
| 12 | TELEFONE | varchar(13) | True | False | False | - |
| 13 | FAX | varchar(13) | True | False | False | - |
| 14 | TELEX | varchar(12) | True | False | False | - |
| 15 | EMAIL | varchar(80) | True | False | False | - |
| 16 | HOMEPAGE | varchar(255) | True | False | False | - |
| 17 | NUMPROPR | numeric(5,0) | True | False | False | - |
| 18 | PRINCTITULAR | varchar(40) | True | False | False | - |
| 19 | CGC | varchar(14) | True | False | False | - |
| 20 | INSCESTAD | varchar(16) | True | False | False | - |
| 21 | INSCMUN | varchar(16) | True | False | False | - |
| 22 | CODMUN | numeric(10,0) | True | False | False | - |
| 23 | NATESTAB | numeric(5,0) | True | False | False | - |
| 24 | NATJUR | numeric(5,0) | True | False | False | - |
| 25 | RAMOATIV | varchar(40) | True | False | False | - |
| 26 | ATIVECON | numeric(10,0) | True | False | False | - |
| 27 | REGJUNTACOM | varchar(12) | True | False | False | - |
| 28 | DTREGJUNTA | datetime2(7) | True | False | False | - |
| 29 | LOGOMARCA | image | True | False | False | - |
| 30 | FINANCEIRO | varchar(1) | False | False | False | - |
| 31 | ESTOQUE | varchar(1) | False | False | False | - |
| 32 | CARGAS | varchar(1) | False | False | False | - |
| 33 | COMISSOES | varchar(1) | False | False | False | - |
| 34 | PRODUCAO | varchar(1) | False | False | False | - |
| 35 | SUPDECISAO | varchar(1) | False | False | False | - |
| 36 | LIVROSFISCAIS | varchar(1) | False | False | False | - |
| 37 | CONTABILIDADE | datetime2(7) | True | False | False | - |
| 38 | FOLHAPAGTO | varchar(1) | False | False | False | - |
| 39 | CODCNL | varchar(10) | True | False | False | - |
| 40 | SIMPLES | varchar(1) | True | False | False | - |
| 41 | CODPARC | numeric(10,0) | True | False | False | - |
| 42 | LIMCURVA_B | float | True | False | False | - |
| 43 | LIMCURVA_C | float | True | False | False | - |
| 44 | EMPAGRUPARGOL | numeric(5,0) | True | False | False | - |
| 45 | SERIENFDES | varchar(4) | True | False | False | - |
| 46 | MODELONFDES | varchar(2) | True | False | False | - |
| 47 | COOPERATIVA | varchar(1) | False | False | False | - |
| 48 | DTCONVSOC | datetime2(7) | True | False | False | - |
| 49 | DUPLIV | varchar(1) | False | False | False | - |
| 50 | CPFRESP | varchar(11) | True | False | False | - |
| 51 | CODREGTRIB | numeric(5,0) | True | False | False | - |
| 52 | TIPOSN | numeric(10,0) | True | False | False | - |
| 53 | CODPARCDIV | numeric(10,0) | False | False | False | - |
| 54 | MD5PAF | varchar(32) | True | False | False | - |
| 55 | RAZAOSOCIALCOMPLETA | varchar(250) | True | False | False | - |
| 56 | SERVIDORSMTP | varchar(80) | True | False | False | - |
| 57 | TIPOSMTP | varchar(1) | False | False | False | - |
| 58 | USUARIOSMTP | varchar(80) | True | False | False | - |
| 59 | SENHASMTP | varchar(80) | True | False | False | - |
| 60 | PORTASMTP | numeric(5,0) | False | False | False | - |
| 61 | SEGURANCASMTP | varchar(1) | False | False | False | - |
| 62 | LATITUDE | varchar(255) | True | False | False | - |
| 63 | LONGITUDE | varchar(255) | True | False | False | - |
| 64 | SIMPLESNACNAUF | varchar(1) | False | False | False | - |
| 65 | DMACODINSP | varchar(2) | True | False | False | - |
| 66 | DMAESPECIAL | varchar(1) | False | False | False | - |
| 67 | DTENCERBALAN | datetime2(7) | True | False | False | - |
| 68 | CODQUALASSIN | varchar(3) | True | False | False | - |
| 69 | CODPARCRESP | numeric(10,0) | True | False | False | - |
| 70 | SITESPECIALRESP | varchar(2) | True | False | False | - |
| 71 | EXIGEISSQN | varchar(2) | True | False | False | - |
| 72 | REGESPTRIBUT | varchar(2) | True | False | False | - |
| 73 | RNTRC | varchar(8) | True | False | False | - |
| 74 | CLASSTRIB | numeric(5,0) | True | False | False | - |
| 75 | CNAEPREPON | numeric(10,0) | True | False | False | - |
| 76 | INDCOOP | numeric(5,0) | False | False | False | - |
| 77 | INDCONSTR | numeric(5,0) | False | False | False | - |
| 78 | INFOOBRA | numeric(5,0) | True | False | False | - |
| 79 | CODUSU | numeric(5,0) | True | False | False | - |
| 80 | DHALTER | datetime2(7) | False | False | False | - |
| 81 | ACDINTISENMULTA | numeric(5,0) | True | False | False | - |
| 82 | CODPARCEMPSOFT | numeric(10,0) | True | False | False | - |
| 83 | CODCTTPARCEMPSOFT | numeric(10,0) | True | False | False | - |
| 84 | INDSITESP | numeric(5,0) | False | False | False | - |
| 85 | TIPTRANSMNFSE | varchar(1) | False | False | False | - |
| 86 | COREMPRESA | numeric(10,0) | True | False | False | - |
| 87 | QTDACESSOS | numeric(10,0) | True | False | False | - |
| 88 | ENVESOCIAL | varchar(1) | False | False | False | - |
| 89 | RECIBOESOCIAL | varchar(40) | True | False | False | - |
| 90 | INIVALESOCIAL | datetime2(7) | True | False | False | - |
| 91 | FIMVALESOCIAL | datetime2(7) | True | False | False | - |
| 92 | INDOPCCP | numeric(5,0) | True | False | False | - |
| 93 | NUVERSAO | numeric(19,0) | True | False | False | - |
| 94 | USARAZAOSOCIAL | varchar(1) | True | False | False | - |
| 95 | DTABERTURA | datetime2(7) | True | False | False | - |
| 96 | EMPIDENOTAS | varchar(50) | True | False | False | - |
| 97 | PRODUTORRURAL | varchar(1) | True | False | False | - |
| 98 | COTM | varchar(20) | True | False | False | - |
| 99 | DHCONSITIMEND | datetime2(7) | True | False | False | - |
| 100 | NUREST | varchar(25) | True | False | False | - |
| 101 | NUMTAF | varchar(12) | True | False | False | - |
| 102 | CNPJPREFEITURA | varchar(14) | True | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL Reconstruida

```sql
CREATE TABLE [bronze].[empresa_sankhya] (
    [CODEMP] numeric(5,0) NOT NULL,
    [NOMEFANTASIA] varchar(40) NULL,
    [RAZAOSOCIAL] varchar(40) NULL,
    [RAZAOABREV] varchar(15) NOT NULL,
    [CODEMPMATRIZ] numeric(5,0) NULL,
    [CODEND] numeric(10,0) NULL,
    [NUMEND] varchar(6) NULL,
    [COMPLEMENTO] varchar(10) NULL,
    [CODBAI] numeric(10,0) NOT NULL,
    [CODCID] numeric(10,0) NULL,
    [CEP] varchar(8) NULL,
    [TELEFONE] varchar(13) NULL,
    [FAX] varchar(13) NULL,
    [TELEX] varchar(12) NULL,
    [EMAIL] varchar(80) NULL,
    [HOMEPAGE] varchar(255) NULL,
    [NUMPROPR] numeric(5,0) NULL,
    [PRINCTITULAR] varchar(40) NULL,
    [CGC] varchar(14) NULL,
    [INSCESTAD] varchar(16) NULL,
    [INSCMUN] varchar(16) NULL,
    [CODMUN] numeric(10,0) NULL,
    [NATESTAB] numeric(5,0) NULL,
    [NATJUR] numeric(5,0) NULL,
    [RAMOATIV] varchar(40) NULL,
    [ATIVECON] numeric(10,0) NULL,
    [REGJUNTACOM] varchar(12) NULL,
    [DTREGJUNTA] datetime2(7) NULL,
    [LOGOMARCA] image NULL,
    [FINANCEIRO] varchar(1) NOT NULL,
    [ESTOQUE] varchar(1) NOT NULL,
    [CARGAS] varchar(1) NOT NULL,
    [COMISSOES] varchar(1) NOT NULL,
    [PRODUCAO] varchar(1) NOT NULL,
    [SUPDECISAO] varchar(1) NOT NULL,
    [LIVROSFISCAIS] varchar(1) NOT NULL,
    [CONTABILIDADE] datetime2(7) NULL,
    [FOLHAPAGTO] varchar(1) NOT NULL,
    [CODCNL] varchar(10) NULL,
    [SIMPLES] varchar(1) NULL,
    [CODPARC] numeric(10,0) NULL,
    [LIMCURVA_B] float NULL,
    [LIMCURVA_C] float NULL,
    [EMPAGRUPARGOL] numeric(5,0) NULL,
    [SERIENFDES] varchar(4) NULL,
    [MODELONFDES] varchar(2) NULL,
    [COOPERATIVA] varchar(1) NOT NULL,
    [DTCONVSOC] datetime2(7) NULL,
    [DUPLIV] varchar(1) NOT NULL,
    [CPFRESP] varchar(11) NULL,
    [CODREGTRIB] numeric(5,0) NULL,
    [TIPOSN] numeric(10,0) NULL,
    [CODPARCDIV] numeric(10,0) NOT NULL,
    [MD5PAF] varchar(32) NULL,
    [RAZAOSOCIALCOMPLETA] varchar(250) NULL,
    [SERVIDORSMTP] varchar(80) NULL,
    [TIPOSMTP] varchar(1) NOT NULL,
    [USUARIOSMTP] varchar(80) NULL,
    [SENHASMTP] varchar(80) NULL,
    [PORTASMTP] numeric(5,0) NOT NULL,
    [SEGURANCASMTP] varchar(1) NOT NULL,
    [LATITUDE] varchar(255) NULL,
    [LONGITUDE] varchar(255) NULL,
    [SIMPLESNACNAUF] varchar(1) NOT NULL,
    [DMACODINSP] varchar(2) NULL,
    [DMAESPECIAL] varchar(1) NOT NULL,
    [DTENCERBALAN] datetime2(7) NULL,
    [CODQUALASSIN] varchar(3) NULL,
    [CODPARCRESP] numeric(10,0) NULL,
    [SITESPECIALRESP] varchar(2) NULL,
    [EXIGEISSQN] varchar(2) NULL,
    [REGESPTRIBUT] varchar(2) NULL,
    [RNTRC] varchar(8) NULL,
    [CLASSTRIB] numeric(5,0) NULL,
    [CNAEPREPON] numeric(10,0) NULL,
    [INDCOOP] numeric(5,0) NOT NULL,
    [INDCONSTR] numeric(5,0) NOT NULL,
    [INFOOBRA] numeric(5,0) NULL,
    [CODUSU] numeric(5,0) NULL,
    [DHALTER] datetime2(7) NOT NULL,
    [ACDINTISENMULTA] numeric(5,0) NULL,
    [CODPARCEMPSOFT] numeric(10,0) NULL,
    [CODCTTPARCEMPSOFT] numeric(10,0) NULL,
    [INDSITESP] numeric(5,0) NOT NULL,
    [TIPTRANSMNFSE] varchar(1) NOT NULL,
    [COREMPRESA] numeric(10,0) NULL,
    [QTDACESSOS] numeric(10,0) NULL,
    [ENVESOCIAL] varchar(1) NOT NULL,
    [RECIBOESOCIAL] varchar(40) NULL,
    [INIVALESOCIAL] datetime2(7) NULL,
    [FIMVALESOCIAL] datetime2(7) NULL,
    [INDOPCCP] numeric(5,0) NULL,
    [NUVERSAO] numeric(19,0) NULL,
    [USARAZAOSOCIAL] varchar(1) NULL,
    [DTABERTURA] datetime2(7) NULL,
    [EMPIDENOTAS] varchar(50) NULL,
    [PRODUTORRURAL] varchar(1) NULL,
    [COTM] varchar(20) NULL,
    [DHCONSITIMEND] datetime2(7) NULL,
    [NUREST] varchar(25) NULL,
    [NUMTAF] varchar(12) NULL,
    [CNPJPREFEITURA] varchar(14) NULL
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
