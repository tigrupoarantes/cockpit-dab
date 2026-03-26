<!-- generated: lakehouse-object -->
# bronze.funcionario_sankhya

- Tipo: `TABLE`
- Industria: `shared`
- Origem: `database:GA_DATALAKE`
- PKs: Nao identificado no banco
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | CODEMP | numeric(5,0) | False | False | False | - |
| 2 | CODFUNC | numeric(10,0) | False | False | False | - |
| 3 | NOMEFUNC | varchar(100) | False | False | False | - |
| 4 | CODEND | numeric(10,0) | True | False | False | - |
| 5 | NUMEND | varchar(10) | True | False | False | - |
| 6 | COMPLEMENTO | varchar(30) | True | False | False | - |
| 7 | CODBAI | numeric(10,0) | True | False | False | - |
| 8 | CODCID | numeric(10,0) | True | False | False | - |
| 9 | CEP | varchar(8) | True | False | False | - |
| 10 | TELEFONE | varchar(13) | True | False | False | - |
| 11 | NUMCPS | numeric(10,0) | True | False | False | - |
| 12 | UFCPS | numeric(5,0) | True | False | False | - |
| 13 | CPF | varchar(11) | True | False | False | - |
| 14 | PIS | varchar(11) | True | False | False | - |
| 15 | IDENTIDADE | varchar(15) | True | False | False | - |
| 16 | SEXO | varchar(1) | True | False | False | - |
| 17 | ESTADOCIVIL | numeric(5,0) | True | False | False | - |
| 18 | NIVESC | numeric(5,0) | True | False | False | - |
| 19 | ANOCHEGPAIS | numeric(5,0) | True | False | False | - |
| 20 | NOMEMAE | varchar(100) | True | False | False | - |
| 21 | NOMEPAI | varchar(100) | True | False | False | - |
| 22 | DEPENDIRF | numeric(5,0) | True | False | False | - |
| 23 | DEPENDSALFAM | numeric(5,0) | True | False | False | - |
| 24 | MESDIA | numeric(5,0) | True | False | False | - |
| 25 | DTNASC | datetime2(7) | True | False | False | - |
| 26 | DTADM | datetime2(7) | False | False | False | - |
| 27 | DTDEM | datetime2(7) | True | False | False | - |
| 28 | DTAVISOPREVIO | datetime2(7) | True | False | False | - |
| 29 | DTCARTEIRASAUDE | datetime2(7) | True | False | False | - |
| 30 | CODBCO | numeric(5,0) | True | False | False | - |
| 31 | CODAGE | varchar(5) | True | False | False | - |
| 32 | CODCTABCO | varchar(14) | True | False | False | - |
| 33 | CTAFGTS | varchar(10) | True | False | False | - |
| 34 | PRIMEMPREGO | varchar(1) | False | False | False | - |
| 35 | VINCULO | numeric(5,0) | True | False | False | - |
| 36 | TIPSAL | varchar(1) | True | False | False | - |
| 37 | TIPTAB | varchar(2) | True | False | False | - |
| 38 | SALBASE | float | True | False | False | - |
| 39 | SITUACAO | varchar(1) | True | False | False | - |
| 40 | SITSIND | varchar(1) | True | False | False | - |
| 41 | CODSIND | numeric(5,0) | True | False | False | - |
| 42 | CODDEP | numeric(10,0) | True | False | False | - |
| 43 | CODFUNCAO | numeric(10,0) | True | False | False | - |
| 44 | CODCARGO | numeric(10,0) | True | False | False | - |
| 45 | CODCARGAHOR | numeric(5,0) | True | False | False | - |
| 46 | HORASSEM | float | True | False | False | - |
| 47 | AFASTFGTS | varchar(3) | True | False | False | - |
| 48 | AFASTRAIS | numeric(5,0) | True | False | False | - |
| 49 | CAUSAAFAST | numeric(5,0) | True | False | False | - |
| 50 | CODSAQ | numeric(5,0) | True | False | False | - |
| 51 | CONVMED | varchar(1) | False | False | False | - |
| 52 | NUMCARTAOPONTO | numeric(10,0) | True | False | False | - |
| 53 | DEPENDCONVMED | numeric(5,0) | True | False | False | - |
| 54 | PERCCONV | float | True | False | False | - |
| 55 | TIPRECEB | varchar(1) | True | False | False | - |
| 56 | MATRICULA | numeric(12,0) | True | False | False | - |
| 57 | CODADMFGTS | varchar(2) | True | False | False | - |
| 58 | CODADMFGTSII | varchar(2) | True | False | False | - |
| 59 | TRABOUTRAEMP | varchar(1) | False | False | False | - |
| 60 | CIDNASC | numeric(10,0) | True | False | False | - |
| 61 | IMAGEM | image | True | False | False | - |
| 62 | CODCATEG | numeric(5,0) | True | False | False | - |
| 63 | DEFICIENTEFISICO | varchar(1) | True | False | False | - |
| 64 | SENHA | varchar(12) | True | False | False | - |
| 65 | CODPARC | numeric(10,0) | True | False | False | - |
| 66 | DTOPTFGTS | datetime2(7) | False | False | False | - |
| 67 | CODTOMADOR | numeric(10,0) | False | False | False | - |
| 68 | RACAFUNCIONARIO | numeric(5,0) | False | False | False | - |
| 69 | PARTPAT | varchar(1) | False | False | False | - |
| 70 | TITELEITORAL | varchar(12) | True | False | False | - |
| 71 | ZONAELEITORAL | numeric(5,0) | True | False | False | - |
| 72 | NRORESERVISTA | varchar(15) | True | False | False | - |
| 73 | NACIONALPAIS | numeric(5,0) | True | False | False | - |
| 74 | DIACADPIS | numeric(5,0) | True | False | False | - |
| 75 | NROCNH | varchar(20) | True | False | False | - |
| 76 | DTAFASTAMENTO | datetime2(7) | True | False | False | - |
| 77 | PERCADIANTAMENTO | float | True | False | False | - |
| 78 | DTALTER | datetime2(7) | False | False | False | - |
| 79 | CELULAR | varchar(13) | True | False | False | - |
| 80 | RNE | varchar(20) | True | False | False | - |
| 81 | DTVALPAIS | datetime2(7) | True | False | False | - |
| 82 | SITPAIS | varchar(1) | True | False | False | - |
| 83 | DTCPS | datetime2(7) | True | False | False | - |
| 84 | DTRG | datetime2(7) | True | False | False | - |
| 85 | ORGAORG | varchar(6) | True | False | False | - |
| 86 | DTCADPIS | datetime2(7) | True | False | False | - |
| 87 | SECAOELEITORAL | numeric(5,0) | True | False | False | - |
| 88 | DIASFERIAS | numeric(5,0) | True | False | False | - |
| 89 | DTVENCEXP1 | datetime2(7) | True | False | False | - |
| 90 | DTVENCEXP2 | datetime2(7) | True | False | False | - |
| 91 | PRIMEIRACNH | datetime2(7) | True | False | False | - |
| 92 | VENCIMENTOCNH | datetime2(7) | True | False | False | - |
| 93 | CATEGORIACNH | varchar(4) | True | False | False | - |
| 94 | REMUMINIMA | float | False | False | False | - |
| 95 | TIPCONTA | varchar(8) | True | False | False | - |
| 96 | CODUSU | numeric(5,0) | True | False | False | - |
| 97 | EMAIL | varchar(80) | True | False | False | - |
| 98 | TIPDEFICIENCIA | numeric(5,0) | False | False | False | - |
| 99 | CODCIDTRAB | numeric(10,0) | False | False | False | - |
| 100 | CODGRUPOCTBZ | numeric(10,0) | True | False | False | - |
| 101 | SINDICALIZADO | varchar(1) | False | False | False | - |
| 102 | NACIONALIDADE | numeric(5,0) | True | False | False | - |
| 103 | CODEMPORIG | numeric(5,0) | True | False | False | - |
| 104 | CODFUNCORIG | numeric(10,0) | True | False | False | - |
| 105 | DTTRANSFERENCIA | datetime2(7) | True | False | False | - |
| 106 | REGIME | numeric(5,0) | True | False | False | - |
| 107 | TIPPONTO | varchar(1) | False | False | False | - |
| 108 | DIAAPURAPONTO | numeric(5,0) | False | False | False | - |
| 109 | DIRRECIPROCO | varchar(1) | False | False | False | - |
| 110 | CODCONVENIO | numeric(10,0) | True | False | False | - |
| 111 | SERIECPS | varchar(6) | True | False | False | - |
| 112 | PERCINSAL | float | True | False | False | - |
| 113 | PERCPERIC | float | True | False | False | - |
| 114 | POSSUIRRA | varchar(1) | False | False | False | - |
| 115 | QUEMPAGARRA | numeric(5,0) | False | False | False | - |
| 116 | NROPROCESSORRA | varchar(20) | True | False | False | - |
| 117 | DTLAUDORRA | datetime2(7) | True | False | False | - |
| 118 | CAIXAPOSTAL | varchar(12) | True | False | False | - |
| 119 | NRONATURAL | varchar(10) | True | False | False | - |
| 120 | DTNATURAL | datetime2(7) | True | False | False | - |
| 121 | NROPASSAPORTE | varchar(12) | True | False | False | - |
| 122 | EMISSORPPORTE | varchar(12) | True | False | False | - |
| 123 | UFPPORTE | numeric(5,0) | True | False | False | - |
| 124 | DTEMIPPORTE | datetime2(7) | True | False | False | - |
| 125 | DTVALPPORTE | datetime2(7) | True | False | False | - |
| 126 | NRORIC | varchar(15) | True | False | False | - |
| 127 | ORGAORIC | varchar(12) | True | False | False | - |
| 128 | DTEMIRIC | datetime2(7) | True | False | False | - |
| 129 | CODCIDRIC | numeric(10,0) | True | False | False | - |
| 130 | TIPCERTIDAO | varchar(1) | True | False | False | - |
| 131 | NROCERTCIVIL | varchar(50) | True | False | False | - |
| 132 | CARTORIO | varchar(30) | True | False | False | - |
| 133 | NROLIVROREG | varchar(10) | True | False | False | - |
| 134 | DTEMICERTCIVIL | datetime2(7) | True | False | False | - |
| 135 | CODCIDCERTCIVIL | numeric(10,0) | True | False | False | - |
| 136 | PROVISAOFERIAS | varchar(1) | False | False | False | - |
| 137 | PROVISAO13 | varchar(1) | False | False | False | - |
| 138 | NUREQUISICAO | numeric(10,0) | True | False | False | - |
| 139 | DISPENSAPONTO | varchar(1) | False | False | False | - |
| 140 | CODCARREIRA | numeric(10,0) | True | False | False | - |
| 141 | TEMPOPARCIAL | varchar(1) | False | False | False | - |
| 142 | SEMINTEGRAL | varchar(1) | False | False | False | - |
| 143 | NOVOEMPREGO | varchar(1) | False | False | False | - |
| 144 | DTQUITACAO | datetime2(7) | True | False | False | - |
| 145 | DIASAVISOPREVIO | numeric(5,0) | True | False | False | - |
| 146 | COMPSALARIO | numeric(5,0) | False | False | False | - |
| 147 | COMPENSASABADO | varchar(1) | False | False | False | - |
| 148 | NOMEARQHOMOLOGNET | varchar(250) | True | False | False | - |
| 149 | MEI | varchar(1) | False | False | False | - |
| 150 | CODPAISNAC | numeric(5,0) | True | False | False | - |
| 151 | ORGAORNE | varchar(20) | True | False | False | - |
| 152 | DTEXPRNE | datetime2(7) | True | False | False | - |
| 153 | NROC | varchar(14) | True | False | False | - |
| 154 | ORGAOOC | varchar(20) | True | False | False | - |
| 155 | DTEXPOC | datetime2(7) | True | False | False | - |
| 156 | DTVALOC | datetime2(7) | True | False | False | - |
| 157 | ORGAOCNH | varchar(20) | True | False | False | - |
| 158 | DTEXPCNH | datetime2(7) | True | False | False | - |
| 159 | DTCHEGPAIS | datetime2(7) | True | False | False | - |
| 160 | CASADOBR | varchar(1) | False | False | False | - |
| 161 | FILHOSBR | varchar(1) | False | False | False | - |
| 162 | OBSDEFICIENCIA | varchar(255) | True | False | False | - |
| 163 | INDADMISSAO | numeric(5,0) | True | False | False | - |
| 164 | REGIMETRAB | numeric(5,0) | True | False | False | - |
| 165 | REGIMEJOR | numeric(5,0) | True | False | False | - |
| 166 | CODCATEGESOCIAL | numeric(10,0) | True | False | False | - |
| 167 | DTTERMINO | datetime2(7) | True | False | False | - |
| 168 | CONTTRABTEMP | numeric(5,0) | True | False | False | - |
| 169 | CODEMPFUNCSUBST | numeric(5,0) | True | False | False | - |
| 170 | CODFUNCSUBST | numeric(10,0) | True | False | False | - |
| 171 | NUPROCESSOJUD | numeric(10,0) | True | False | False | - |
| 172 | OPTFGTS | numeric(5,0) | True | False | False | - |
| 173 | CNPJEMPANT | varchar(14) | True | False | False | - |
| 174 | MATRICULAEMPANT | varchar(30) | True | False | False | - |
| 175 | DTVINCEMPANT | datetime2(7) | True | False | False | - |
| 176 | OBSEMPANT | varchar(250) | True | False | False | - |
| 177 | CNPJEMPCED | varchar(14) | True | False | False | - |
| 178 | MATRICULAEMPCED | varchar(30) | True | False | False | - |
| 179 | DTADMEMPCED | datetime2(7) | True | False | False | - |
| 180 | INFOONUS | numeric(5,0) | True | False | False | - |
| 181 | DTASO | datetime2(7) | True | False | False | - |
| 182 | MEDICOASO | varchar(60) | True | False | False | - |
| 183 | TELMEDICOASO | varchar(15) | True | False | False | - |
| 184 | CRMMEDICOASO | varchar(8) | True | False | False | - |
| 185 | UFCRMMEDASO | varchar(2) | True | False | False | - |
| 186 | DTINC_ESOCIAL | datetime2(7) | True | False | False | - |
| 187 | DTULTENV_ESOCIAL | datetime2(7) | True | False | False | - |
| 188 | CAGEDADM | varchar(1) | False | False | False | - |
| 189 | SEGDESEMPREGO | varchar(1) | False | False | False | - |
| 190 | DTLOTENIS | datetime2(7) | True | False | False | - |
| 191 | NUMLOTENIS | numeric(5,0) | True | False | False | - |
| 192 | CODEMPRESPNIS | numeric(5,0) | True | False | False | - |
| 193 | NISENVIADO | varchar(1) | False | False | False | - |
| 194 | COMPLEMENTORG | varchar(20) | True | False | False | - |
| 195 | UFRG | numeric(5,0) | True | False | False | - |
| 196 | CODNIVEL | numeric(10,0) | True | False | False | - |
| 197 | STEP | varchar(1) | True | False | False | - |
| 198 | CODEMPFUNCSUP | numeric(5,0) | True | False | False | - |
| 199 | CODFUNCSUP | numeric(10,0) | True | False | False | - |
| 200 | NROFOLHAREG | varchar(5) | True | False | False | - |
| 201 | REMUNERAMESANT | float | True | False | False | - |
| 202 | UFCNH | numeric(5,0) | True | False | False | - |
| 203 | CLASSTRABESTRANG | numeric(5,0) | True | False | False | - |
| 204 | TRABAPOSENT | varchar(1) | False | False | False | - |
| 205 | OBSVARIAVEL | varchar(999) | True | False | False | - |
| 206 | SALBASEANTERIOR | float | True | False | False | - |
| 207 | DTFIMQUARENTENA | datetime2(7) | True | False | False | - |
| 208 | MTVDESLIGTSV | numeric(5,0) | True | False | False | - |
| 209 | NMSOCIAL | varchar(70) | True | False | False | - |
| 210 | INFOCOTA | varchar(1) | False | False | False | - |
| 211 | JUSTCONTR | varchar(4000) | True | False | False | - |
| 212 | TPINCLCONTR | numeric(5,0) | True | False | False | - |
| 213 | SUSPEXPAFAST | varchar(1) | False | False | False | - |
| 214 | TEMDESCASSIST | varchar(1) | False | False | False | - |
| 215 | TPINSCTOMADOR | numeric(5,0) | True | False | False | - |
| 216 | TPINSCESTABVINC | numeric(5,0) | True | False | False | - |
| 217 | NRINSCTOMADOR | varchar(14) | True | False | False | - |
| 218 | CPFSUBSTITUIDO | varchar(11) | True | False | False | - |
| 219 | JUSTPRORR | varchar(4000) | True | False | False | - |
| 220 | NRINSCESTABVINC | varchar(14) | True | False | False | - |
| 221 | CODTPR | numeric(10,0) | True | False | False | - |
| 222 | INDMV | numeric(5,0) | False | False | False | - |
| 223 | ENVESOCIAL | varchar(1) | False | False | False | - |
| 224 | RECIBOESOCIAL | varchar(40) | True | False | False | - |
| 225 | INIVALESOCIAL | datetime2(7) | True | False | False | - |
| 226 | FIMVALESOCIAL | datetime2(7) | True | False | False | - |
| 227 | TEMCONTRIBSINDICAL | varchar(1) | False | False | False | - |
| 228 | APRENDIZGRAVIDA | varchar(1) | False | False | False | - |
| 229 | SITESOCIAL | varchar(1) | True | False | False | - |
| 230 | CODCATEGTRABCEDIDO | numeric(5,0) | True | False | False | - |
| 231 | TPREGTRABCED | numeric(5,0) | True | False | False | - |
| 232 | TPREGPREVCED | numeric(5,0) | True | False | False | - |
| 233 | IDCONSIG | varchar(1) | False | False | False | - |
| 234 | INSCONSIG | varchar(5) | True | False | False | - |
| 235 | NRCONTR | varchar(15) | True | False | False | - |
| 236 | NRCERTOBITO | varchar(32) | True | False | False | - |
| 237 | NUPROCESSOTRAB | numeric(10,0) | True | False | False | - |
| 238 | INDNIF | varchar(1) | True | False | False | - |
| 239 | NIFBENEF | varchar(20) | True | False | False | - |
| 240 | INDCUMPRPARC | numeric(5,0) | True | False | False | - |
| 241 | DTTRANSFDEST | datetime2(7) | True | False | False | - |
| 242 | CODEMPDEST | numeric(5,0) | True | False | False | - |
| 243 | CODFUNCDEST | numeric(10,0) | True | False | False | - |
| 244 | CNPJDESTTRANSF | varchar(14) | True | False | False | - |
| 245 | CODMOTDESLIGTRANSF | varchar(2) | True | False | False | - |
| 246 | REMUNBASE | float | True | False | False | - |
| 247 | SALPROFESSOR | float | True | False | False | - |
| 248 | DISPPEREXP | varchar(1) | False | False | False | - |
| 249 | METERG | varchar(999) | True | False | False | - |
| 250 | OBSERVACAO | varchar(999) | True | False | False | - |
| 251 | DSCATIVDES | varchar(999) | True | False | False | - |
| 252 | JORNADAPROF | float | True | False | False | - |
| 253 | JORNADAESPPROF | varchar(1) | True | False | False | - |
| 254 | DTESOCIAL2205 | datetime2(7) | True | False | False | - |
| 255 | DTESOCIAL2206 | datetime2(7) | True | False | False | - |
| 256 | OBJDET | varchar(255) | True | False | False | - |
| 257 | CPFANT | varchar(11) | True | False | False | - |
| 258 | MATRICANT | numeric(12,0) | True | False | False | - |
| 259 | DTALTCPF | datetime2(7) | True | False | False | - |
| 260 | OBSALTCPF | varchar(255) | True | False | False | - |
| 261 | MATRICULAOLD | varchar(30) | True | False | False | - |
| 262 | CADINI | varchar(1) | True | False | False | - |
| 263 | SEMANASPORMES | float | True | False | False | - |
| 264 | CODGRUPOHORARIO | numeric(10,0) | True | False | False | - |
| 265 | DTINIGRUPOHR | datetime2(7) | True | False | False | - |
| 266 | ORDEMGRUPOHR | numeric(5,0) | True | False | False | - |
| 267 | DIASEMGRUPOHR | numeric(5,0) | True | False | False | - |
| 268 | PERTENCEDP | varchar(1) | False | False | False | - |
| 269 | CONTRATOSUSP | varchar(1) | False | False | False | - |
| 270 | DTVENCEXP1OR | datetime2(7) | True | False | False | - |
| 271 | DTVENCEXP2OR | datetime2(7) | True | False | False | - |
| 272 | LOTACAOESOCIAL | varchar(500) | True | False | False | - |
| 273 | CODMAD | numeric(5,0) | True | False | False | - |
| 274 | CODMADDEM | numeric(5,0) | True | False | False | - |
| 275 | SALAJUSTADOSIND | float | True | False | False | - |
| 276 | REPLIDER | varchar(1) | True | False | False | - |
| 277 | USUVPJSUP | numeric(10,0) | True | False | False | - |
| 278 | TELEGRAMID | numeric(10,0) | True | False | False | - |
| 279 | ADERIMP927 | varchar(1) | True | False | False | - |
| 280 | SALBASECPU | float | True | False | False | - |
| 281 | HORASSEMCPU | float | True | False | False | - |
| 282 | PERREDCPU | float | True | False | False | - |
| 283 | AJUDACOMP | varchar(1) | False | False | False | - |
| 284 | SUSPCONTRATO | varchar(1) | False | False | False | - |
| 285 | AFASTAMENTO | varchar(1) | True | False | False | - |
| 286 | OBSERVACAOMP | varchar(255) | True | False | False | - |
| 287 | SEQCPU | numeric(10,0) | True | False | False | - |
| 288 | DTINICIORED | datetime2(7) | True | False | False | - |
| 289 | DTFIMRED | datetime2(7) | True | False | False | - |
| 290 | DTFIMCONTRINT | datetime2(7) | True | False | False | - |
| 291 | CODLTR | numeric(10,0) | True | False | False | - |
| 292 | AD_IMPORT | varchar(10) | True | False | False | - |
| 293 | AD_DATIMP | datetime2(7) | True | False | False | - |
| 294 | AD_CODUSUIMP | numeric(10,0) | True | False | False | - |
| 295 | SALBASERED | float | True | False | False | - |
| 296 | HORASSEMRED | float | True | False | False | - |
| 297 | AD_UPDCARHOR | varchar(10) | True | False | False | - |
| 298 | AD_DATUPDCARHOR | datetime2(7) | True | False | False | - |
| 299 | INDRETIFESOCIAL2206 | numeric(5,0) | True | False | False | - |
| 300 | APRENDCONTRIND | varchar(1) | False | False | False | - |
| 301 | NRINSCINFOCELETISTA | varchar(15) | True | False | False | - |
| 302 | DSCALT | varchar(150) | True | False | False | - |
| 303 | TRANSFEXTERNA | varchar(1) | False | False | False | - |
| 304 | NUMPROCTSVE | varchar(20) | True | False | False | - |
| 305 | NRPROCTRAB | varchar(20) | True | False | False | - |
| 306 | BLOQUEIABATIDAONLINE | varchar(1) | True | False | False | - |
| 307 | TMPRESIDTRABESTRANG | varchar(1) | True | False | False | - |
| 308 | CONDINGESTRANG | varchar(1) | True | False | False | - |
| 309 | MOTEXPATRIADO | numeric(5,0) | True | False | False | - |
| 310 | DISPENSAMATRICULA | varchar(1) | True | False | False | - |
| 311 | CTPSDIGITAL | varchar(1) | False | False | False | - |
| 312 | INDSITREMUNDESLIG | numeric(5,0) | True | False | False | - |
| 313 | DTFIMREMUN | datetime2(7) | True | False | False | - |
| 314 | ENDFISCEXT | varchar(1) | True | False | False | - |
| 315 | FORMTRIBU | numeric(5,0) | True | False | False | - |
| 316 | RECIBOESOCIAL2205 | varchar(50) | True | False | False | - |
| 317 | CODCATEGESOCIALANT | numeric(5,0) | True | False | False | - |
| 318 | NRPROCTRABANT | varchar(20) | True | False | False | - |
| 319 | CODTPRJUD | numeric(10,0) | True | False | False | - |
| 320 | RECIBOESOCIAL2206 | varchar(50) | True | False | False | - |
| 321 | AFASTRAISANT | numeric(5,0) | True | False | False | - |
| 322 | DTALTS2299 | datetime2(7) | True | False | False | - |
| 323 | MOTDESLIGESOCIAL | varchar(2) | True | False | False | - |
| 324 | MOTDESLIGESOCIALANT | varchar(2) | True | False | False | - |
| 325 | TPINSCAPREND | numeric(5,0) | True | False | False | - |
| 326 | CNPJPRAT | varchar(14) | True | False | False | - |
| 327 | DTALTS2200 | datetime2(7) | True | False | False | - |
| 328 | AFASTFGTSANT | varchar(3) | True | False | False | - |
| 329 | PVD | varchar(1) | True | False | False | - |
| 330 | INDADMISSAOANT | numeric(5,0) | True | False | False | - |
| 331 | NRPROCTRABDESLIG | varchar(20) | True | False | False | - |
| 332 | NATATIVIDADEANT | varchar(1) | True | False | False | - |
| 333 | NRINSCAPREND | varchar(14) | True | False | False | - |
| 334 | DTDEMJUD | datetime2(7) | True | False | False | - |
| 335 | CAUSAAFASTANT | numeric(5,0) | True | False | False | - |
| 336 | DTSENTPROCTRAB | datetime2(7) | True | False | False | - |
| 337 | NATATIVIDADE | varchar(1) | True | False | False | - |
| 338 | CNPJENTQUAL | varchar(14) | True | False | False | - |
| 339 | MATANOTJUD | varchar(30) | True | False | False | - |
| 340 | DTADMJUD | datetime2(7) | True | False | False | - |
| 341 | RECIBOESOCIAL2200 | varchar(50) | True | False | False | - |
| 342 | POSSUIFILHOS | varchar(1) | True | False | False | - |
| 343 | ORIENTACAOSEXUAL | varchar(1) | True | False | False | - |
| 344 | IDENTIDADEGENERO | varchar(1) | True | False | False | - |
| 345 | SITUACAOANT | varchar(1) | True | False | False | - |
| 346 | DTDISPENSAPONTO | datetime2(7) | True | False | False | - |
| 347 | CODLOCALPONTO | numeric(10,0) | True | False | False | - |
| 348 | VALIDADO | varchar(1) | True | False | False | - |
| 349 | TRANSFSEMONUSCEDENTE | varchar(2) | True | False | False | - |
| 350 | TPREFDTVENCEXP2 | varchar(1) | False | False | False | - |
| 351 | TRAVESTITRANSEXUAL | varchar(1) | True | False | False | - |
| 352 | AD_TIPTRANSFPIX | varchar(10) | True | False | False | - |
| 353 | AD_TIPCHAVEPIX | varchar(10) | True | False | False | - |
| 354 | AD_CHAVEPIX | varchar(100) | True | False | False | - |
| 355 | DTENVIOESOCIAL2221 | datetime2(7) | True | False | False | - |
| 356 | ESOCIALINTEGR2240 | varchar(1) | True | False | False | - |
| 357 | DTESOCIAL2221 | datetime2(7) | True | False | False | - |
| 358 | DTENVIOESOCIAL2210 | datetime2(7) | True | False | False | - |
| 359 | RECIBOESOCIAL2210 | varchar(50) | True | False | False | - |
| 360 | ESOCIALINTEGR2221 | varchar(1) | True | False | False | - |
| 361 | DTENVIOESOCIAL2240 | datetime2(7) | True | False | False | - |
| 362 | DTESOCIAL2210 | datetime2(7) | True | False | False | - |
| 363 | ESOCIALINTEGR2210 | varchar(1) | True | False | False | - |
| 364 | RECIBOESOCIAL2220 | varchar(50) | True | False | False | - |
| 365 | DTESOCIAL2220 | datetime2(7) | True | False | False | - |
| 366 | ESOCIALINTEGR2220 | varchar(1) | True | False | False | - |
| 367 | DTESOCIAL2240 | datetime2(7) | True | False | False | - |
| 368 | RECIBOESOCIAL2240 | varchar(50) | True | False | False | - |
| 369 | DTENVIOESOCIAL2220 | datetime2(7) | True | False | False | - |
| 370 | RECIBOESOCIAL2221 | varchar(50) | True | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL Reconstruida

```sql
CREATE TABLE [bronze].[funcionario_sankhya] (
    [CODEMP] numeric(5,0) NOT NULL,
    [CODFUNC] numeric(10,0) NOT NULL,
    [NOMEFUNC] varchar(100) NOT NULL,
    [CODEND] numeric(10,0) NULL,
    [NUMEND] varchar(10) NULL,
    [COMPLEMENTO] varchar(30) NULL,
    [CODBAI] numeric(10,0) NULL,
    [CODCID] numeric(10,0) NULL,
    [CEP] varchar(8) NULL,
    [TELEFONE] varchar(13) NULL,
    [NUMCPS] numeric(10,0) NULL,
    [UFCPS] numeric(5,0) NULL,
    [CPF] varchar(11) NULL,
    [PIS] varchar(11) NULL,
    [IDENTIDADE] varchar(15) NULL,
    [SEXO] varchar(1) NULL,
    [ESTADOCIVIL] numeric(5,0) NULL,
    [NIVESC] numeric(5,0) NULL,
    [ANOCHEGPAIS] numeric(5,0) NULL,
    [NOMEMAE] varchar(100) NULL,
    [NOMEPAI] varchar(100) NULL,
    [DEPENDIRF] numeric(5,0) NULL,
    [DEPENDSALFAM] numeric(5,0) NULL,
    [MESDIA] numeric(5,0) NULL,
    [DTNASC] datetime2(7) NULL,
    [DTADM] datetime2(7) NOT NULL,
    [DTDEM] datetime2(7) NULL,
    [DTAVISOPREVIO] datetime2(7) NULL,
    [DTCARTEIRASAUDE] datetime2(7) NULL,
    [CODBCO] numeric(5,0) NULL,
    [CODAGE] varchar(5) NULL,
    [CODCTABCO] varchar(14) NULL,
    [CTAFGTS] varchar(10) NULL,
    [PRIMEMPREGO] varchar(1) NOT NULL,
    [VINCULO] numeric(5,0) NULL,
    [TIPSAL] varchar(1) NULL,
    [TIPTAB] varchar(2) NULL,
    [SALBASE] float NULL,
    [SITUACAO] varchar(1) NULL,
    [SITSIND] varchar(1) NULL,
    [CODSIND] numeric(5,0) NULL,
    [CODDEP] numeric(10,0) NULL,
    [CODFUNCAO] numeric(10,0) NULL,
    [CODCARGO] numeric(10,0) NULL,
    [CODCARGAHOR] numeric(5,0) NULL,
    [HORASSEM] float NULL,
    [AFASTFGTS] varchar(3) NULL,
    [AFASTRAIS] numeric(5,0) NULL,
    [CAUSAAFAST] numeric(5,0) NULL,
    [CODSAQ] numeric(5,0) NULL,
    [CONVMED] varchar(1) NOT NULL,
    [NUMCARTAOPONTO] numeric(10,0) NULL,
    [DEPENDCONVMED] numeric(5,0) NULL,
    [PERCCONV] float NULL,
    [TIPRECEB] varchar(1) NULL,
    [MATRICULA] numeric(12,0) NULL,
    [CODADMFGTS] varchar(2) NULL,
    [CODADMFGTSII] varchar(2) NULL,
    [TRABOUTRAEMP] varchar(1) NOT NULL,
    [CIDNASC] numeric(10,0) NULL,
    [IMAGEM] image NULL,
    [CODCATEG] numeric(5,0) NULL,
    [DEFICIENTEFISICO] varchar(1) NULL,
    [SENHA] varchar(12) NULL,
    [CODPARC] numeric(10,0) NULL,
    [DTOPTFGTS] datetime2(7) NOT NULL,
    [CODTOMADOR] numeric(10,0) NOT NULL,
    [RACAFUNCIONARIO] numeric(5,0) NOT NULL,
    [PARTPAT] varchar(1) NOT NULL,
    [TITELEITORAL] varchar(12) NULL,
    [ZONAELEITORAL] numeric(5,0) NULL,
    [NRORESERVISTA] varchar(15) NULL,
    [NACIONALPAIS] numeric(5,0) NULL,
    [DIACADPIS] numeric(5,0) NULL,
    [NROCNH] varchar(20) NULL,
    [DTAFASTAMENTO] datetime2(7) NULL,
    [PERCADIANTAMENTO] float NULL,
    [DTALTER] datetime2(7) NOT NULL,
    [CELULAR] varchar(13) NULL,
    [RNE] varchar(20) NULL,
    [DTVALPAIS] datetime2(7) NULL,
    [SITPAIS] varchar(1) NULL,
    [DTCPS] datetime2(7) NULL,
    [DTRG] datetime2(7) NULL,
    [ORGAORG] varchar(6) NULL,
    [DTCADPIS] datetime2(7) NULL,
    [SECAOELEITORAL] numeric(5,0) NULL,
    [DIASFERIAS] numeric(5,0) NULL,
    [DTVENCEXP1] datetime2(7) NULL,
    [DTVENCEXP2] datetime2(7) NULL,
    [PRIMEIRACNH] datetime2(7) NULL,
    [VENCIMENTOCNH] datetime2(7) NULL,
    [CATEGORIACNH] varchar(4) NULL,
    [REMUMINIMA] float NOT NULL,
    [TIPCONTA] varchar(8) NULL,
    [CODUSU] numeric(5,0) NULL,
    [EMAIL] varchar(80) NULL,
    [TIPDEFICIENCIA] numeric(5,0) NOT NULL,
    [CODCIDTRAB] numeric(10,0) NOT NULL,
    [CODGRUPOCTBZ] numeric(10,0) NULL,
    [SINDICALIZADO] varchar(1) NOT NULL,
    [NACIONALIDADE] numeric(5,0) NULL,
    [CODEMPORIG] numeric(5,0) NULL,
    [CODFUNCORIG] numeric(10,0) NULL,
    [DTTRANSFERENCIA] datetime2(7) NULL,
    [REGIME] numeric(5,0) NULL,
    [TIPPONTO] varchar(1) NOT NULL,
    [DIAAPURAPONTO] numeric(5,0) NOT NULL,
    [DIRRECIPROCO] varchar(1) NOT NULL,
    [CODCONVENIO] numeric(10,0) NULL,
    [SERIECPS] varchar(6) NULL,
    [PERCINSAL] float NULL,
    [PERCPERIC] float NULL,
    [POSSUIRRA] varchar(1) NOT NULL,
    [QUEMPAGARRA] numeric(5,0) NOT NULL,
    [NROPROCESSORRA] varchar(20) NULL,
    [DTLAUDORRA] datetime2(7) NULL,
    [CAIXAPOSTAL] varchar(12) NULL,
    [NRONATURAL] varchar(10) NULL,
    [DTNATURAL] datetime2(7) NULL,
    [NROPASSAPORTE] varchar(12) NULL,
    [EMISSORPPORTE] varchar(12) NULL,
    [UFPPORTE] numeric(5,0) NULL,
    [DTEMIPPORTE] datetime2(7) NULL,
    [DTVALPPORTE] datetime2(7) NULL,
    [NRORIC] varchar(15) NULL,
    [ORGAORIC] varchar(12) NULL,
    [DTEMIRIC] datetime2(7) NULL,
    [CODCIDRIC] numeric(10,0) NULL,
    [TIPCERTIDAO] varchar(1) NULL,
    [NROCERTCIVIL] varchar(50) NULL,
    [CARTORIO] varchar(30) NULL,
    [NROLIVROREG] varchar(10) NULL,
    [DTEMICERTCIVIL] datetime2(7) NULL,
    [CODCIDCERTCIVIL] numeric(10,0) NULL,
    [PROVISAOFERIAS] varchar(1) NOT NULL,
    [PROVISAO13] varchar(1) NOT NULL,
    [NUREQUISICAO] numeric(10,0) NULL,
    [DISPENSAPONTO] varchar(1) NOT NULL,
    [CODCARREIRA] numeric(10,0) NULL,
    [TEMPOPARCIAL] varchar(1) NOT NULL,
    [SEMINTEGRAL] varchar(1) NOT NULL,
    [NOVOEMPREGO] varchar(1) NOT NULL,
    [DTQUITACAO] datetime2(7) NULL,
    [DIASAVISOPREVIO] numeric(5,0) NULL,
    [COMPSALARIO] numeric(5,0) NOT NULL,
    [COMPENSASABADO] varchar(1) NOT NULL,
    [NOMEARQHOMOLOGNET] varchar(250) NULL,
    [MEI] varchar(1) NOT NULL,
    [CODPAISNAC] numeric(5,0) NULL,
    [ORGAORNE] varchar(20) NULL,
    [DTEXPRNE] datetime2(7) NULL,
    [NROC] varchar(14) NULL,
    [ORGAOOC] varchar(20) NULL,
    [DTEXPOC] datetime2(7) NULL,
    [DTVALOC] datetime2(7) NULL,
    [ORGAOCNH] varchar(20) NULL,
    [DTEXPCNH] datetime2(7) NULL,
    [DTCHEGPAIS] datetime2(7) NULL,
    [CASADOBR] varchar(1) NOT NULL,
    [FILHOSBR] varchar(1) NOT NULL,
    [OBSDEFICIENCIA] varchar(255) NULL,
    [INDADMISSAO] numeric(5,0) NULL,
    [REGIMETRAB] numeric(5,0) NULL,
    [REGIMEJOR] numeric(5,0) NULL,
    [CODCATEGESOCIAL] numeric(10,0) NULL,
    [DTTERMINO] datetime2(7) NULL,
    [CONTTRABTEMP] numeric(5,0) NULL,
    [CODEMPFUNCSUBST] numeric(5,0) NULL,
    [CODFUNCSUBST] numeric(10,0) NULL,
    [NUPROCESSOJUD] numeric(10,0) NULL,
    [OPTFGTS] numeric(5,0) NULL,
    [CNPJEMPANT] varchar(14) NULL,
    [MATRICULAEMPANT] varchar(30) NULL,
    [DTVINCEMPANT] datetime2(7) NULL,
    [OBSEMPANT] varchar(250) NULL,
    [CNPJEMPCED] varchar(14) NULL,
    [MATRICULAEMPCED] varchar(30) NULL,
    [DTADMEMPCED] datetime2(7) NULL,
    [INFOONUS] numeric(5,0) NULL,
    [DTASO] datetime2(7) NULL,
    [MEDICOASO] varchar(60) NULL,
    [TELMEDICOASO] varchar(15) NULL,
    [CRMMEDICOASO] varchar(8) NULL,
    [UFCRMMEDASO] varchar(2) NULL,
    [DTINC_ESOCIAL] datetime2(7) NULL,
    [DTULTENV_ESOCIAL] datetime2(7) NULL,
    [CAGEDADM] varchar(1) NOT NULL,
    [SEGDESEMPREGO] varchar(1) NOT NULL,
    [DTLOTENIS] datetime2(7) NULL,
    [NUMLOTENIS] numeric(5,0) NULL,
    [CODEMPRESPNIS] numeric(5,0) NULL,
    [NISENVIADO] varchar(1) NOT NULL,
    [COMPLEMENTORG] varchar(20) NULL,
    [UFRG] numeric(5,0) NULL,
    [CODNIVEL] numeric(10,0) NULL,
    [STEP] varchar(1) NULL,
    [CODEMPFUNCSUP] numeric(5,0) NULL,
    [CODFUNCSUP] numeric(10,0) NULL,
    [NROFOLHAREG] varchar(5) NULL,
    [REMUNERAMESANT] float NULL,
    [UFCNH] numeric(5,0) NULL,
    [CLASSTRABESTRANG] numeric(5,0) NULL,
    [TRABAPOSENT] varchar(1) NOT NULL,
    [OBSVARIAVEL] varchar(999) NULL,
    [SALBASEANTERIOR] float NULL,
    [DTFIMQUARENTENA] datetime2(7) NULL,
    [MTVDESLIGTSV] numeric(5,0) NULL,
    [NMSOCIAL] varchar(70) NULL,
    [INFOCOTA] varchar(1) NOT NULL,
    [JUSTCONTR] varchar(4000) NULL,
    [TPINCLCONTR] numeric(5,0) NULL,
    [SUSPEXPAFAST] varchar(1) NOT NULL,
    [TEMDESCASSIST] varchar(1) NOT NULL,
    [TPINSCTOMADOR] numeric(5,0) NULL,
    [TPINSCESTABVINC] numeric(5,0) NULL,
    [NRINSCTOMADOR] varchar(14) NULL,
    [CPFSUBSTITUIDO] varchar(11) NULL,
    [JUSTPRORR] varchar(4000) NULL,
    [NRINSCESTABVINC] varchar(14) NULL,
    [CODTPR] numeric(10,0) NULL,
    [INDMV] numeric(5,0) NOT NULL,
    [ENVESOCIAL] varchar(1) NOT NULL,
    [RECIBOESOCIAL] varchar(40) NULL,
    [INIVALESOCIAL] datetime2(7) NULL,
    [FIMVALESOCIAL] datetime2(7) NULL,
    [TEMCONTRIBSINDICAL] varchar(1) NOT NULL,
    [APRENDIZGRAVIDA] varchar(1) NOT NULL,
    [SITESOCIAL] varchar(1) NULL,
    [CODCATEGTRABCEDIDO] numeric(5,0) NULL,
    [TPREGTRABCED] numeric(5,0) NULL,
    [TPREGPREVCED] numeric(5,0) NULL,
    [IDCONSIG] varchar(1) NOT NULL,
    [INSCONSIG] varchar(5) NULL,
    [NRCONTR] varchar(15) NULL,
    [NRCERTOBITO] varchar(32) NULL,
    [NUPROCESSOTRAB] numeric(10,0) NULL,
    [INDNIF] varchar(1) NULL,
    [NIFBENEF] varchar(20) NULL,
    [INDCUMPRPARC] numeric(5,0) NULL,
    [DTTRANSFDEST] datetime2(7) NULL,
    [CODEMPDEST] numeric(5,0) NULL,
    [CODFUNCDEST] numeric(10,0) NULL,
    [CNPJDESTTRANSF] varchar(14) NULL,
    [CODMOTDESLIGTRANSF] varchar(2) NULL,
    [REMUNBASE] float NULL,
    [SALPROFESSOR] float NULL,
    [DISPPEREXP] varchar(1) NOT NULL,
    [METERG] varchar(999) NULL,
    [OBSERVACAO] varchar(999) NULL,
    [DSCATIVDES] varchar(999) NULL,
    [JORNADAPROF] float NULL,
    [JORNADAESPPROF] varchar(1) NULL,
    [DTESOCIAL2205] datetime2(7) NULL,
    [DTESOCIAL2206] datetime2(7) NULL,
    [OBJDET] varchar(255) NULL,
    [CPFANT] varchar(11) NULL,
    [MATRICANT] numeric(12,0) NULL,
    [DTALTCPF] datetime2(7) NULL,
    [OBSALTCPF] varchar(255) NULL,
    [MATRICULAOLD] varchar(30) NULL,
    [CADINI] varchar(1) NULL,
    [SEMANASPORMES] float NULL,
    [CODGRUPOHORARIO] numeric(10,0) NULL,
    [DTINIGRUPOHR] datetime2(7) NULL,
    [ORDEMGRUPOHR] numeric(5,0) NULL,
    [DIASEMGRUPOHR] numeric(5,0) NULL,
    [PERTENCEDP] varchar(1) NOT NULL,
    [CONTRATOSUSP] varchar(1) NOT NULL,
    [DTVENCEXP1OR] datetime2(7) NULL,
    [DTVENCEXP2OR] datetime2(7) NULL,
    [LOTACAOESOCIAL] varchar(500) NULL,
    [CODMAD] numeric(5,0) NULL,
    [CODMADDEM] numeric(5,0) NULL,
    [SALAJUSTADOSIND] float NULL,
    [REPLIDER] varchar(1) NULL,
    [USUVPJSUP] numeric(10,0) NULL,
    [TELEGRAMID] numeric(10,0) NULL,
    [ADERIMP927] varchar(1) NULL,
    [SALBASECPU] float NULL,
    [HORASSEMCPU] float NULL,
    [PERREDCPU] float NULL,
    [AJUDACOMP] varchar(1) NOT NULL,
    [SUSPCONTRATO] varchar(1) NOT NULL,
    [AFASTAMENTO] varchar(1) NULL,
    [OBSERVACAOMP] varchar(255) NULL,
    [SEQCPU] numeric(10,0) NULL,
    [DTINICIORED] datetime2(7) NULL,
    [DTFIMRED] datetime2(7) NULL,
    [DTFIMCONTRINT] datetime2(7) NULL,
    [CODLTR] numeric(10,0) NULL,
    [AD_IMPORT] varchar(10) NULL,
    [AD_DATIMP] datetime2(7) NULL,
    [AD_CODUSUIMP] numeric(10,0) NULL,
    [SALBASERED] float NULL,
    [HORASSEMRED] float NULL,
    [AD_UPDCARHOR] varchar(10) NULL,
    [AD_DATUPDCARHOR] datetime2(7) NULL,
    [INDRETIFESOCIAL2206] numeric(5,0) NULL,
    [APRENDCONTRIND] varchar(1) NOT NULL,
    [NRINSCINFOCELETISTA] varchar(15) NULL,
    [DSCALT] varchar(150) NULL,
    [TRANSFEXTERNA] varchar(1) NOT NULL,
    [NUMPROCTSVE] varchar(20) NULL,
    [NRPROCTRAB] varchar(20) NULL,
    [BLOQUEIABATIDAONLINE] varchar(1) NULL,
    [TMPRESIDTRABESTRANG] varchar(1) NULL,
    [CONDINGESTRANG] varchar(1) NULL,
    [MOTEXPATRIADO] numeric(5,0) NULL,
    [DISPENSAMATRICULA] varchar(1) NULL,
    [CTPSDIGITAL] varchar(1) NOT NULL,
    [INDSITREMUNDESLIG] numeric(5,0) NULL,
    [DTFIMREMUN] datetime2(7) NULL,
    [ENDFISCEXT] varchar(1) NULL,
    [FORMTRIBU] numeric(5,0) NULL,
    [RECIBOESOCIAL2205] varchar(50) NULL,
    [CODCATEGESOCIALANT] numeric(5,0) NULL,
    [NRPROCTRABANT] varchar(20) NULL,
    [CODTPRJUD] numeric(10,0) NULL,
    [RECIBOESOCIAL2206] varchar(50) NULL,
    [AFASTRAISANT] numeric(5,0) NULL,
    [DTALTS2299] datetime2(7) NULL,
    [MOTDESLIGESOCIAL] varchar(2) NULL,
    [MOTDESLIGESOCIALANT] varchar(2) NULL,
    [TPINSCAPREND] numeric(5,0) NULL,
    [CNPJPRAT] varchar(14) NULL,
    [DTALTS2200] datetime2(7) NULL,
    [AFASTFGTSANT] varchar(3) NULL,
    [PVD] varchar(1) NULL,
    [INDADMISSAOANT] numeric(5,0) NULL,
    [NRPROCTRABDESLIG] varchar(20) NULL,
    [NATATIVIDADEANT] varchar(1) NULL,
    [NRINSCAPREND] varchar(14) NULL,
    [DTDEMJUD] datetime2(7) NULL,
    [CAUSAAFASTANT] numeric(5,0) NULL,
    [DTSENTPROCTRAB] datetime2(7) NULL,
    [NATATIVIDADE] varchar(1) NULL,
    [CNPJENTQUAL] varchar(14) NULL,
    [MATANOTJUD] varchar(30) NULL,
    [DTADMJUD] datetime2(7) NULL,
    [RECIBOESOCIAL2200] varchar(50) NULL,
    [POSSUIFILHOS] varchar(1) NULL,
    [ORIENTACAOSEXUAL] varchar(1) NULL,
    [IDENTIDADEGENERO] varchar(1) NULL,
    [SITUACAOANT] varchar(1) NULL,
    [DTDISPENSAPONTO] datetime2(7) NULL,
    [CODLOCALPONTO] numeric(10,0) NULL,
    [VALIDADO] varchar(1) NULL,
    [TRANSFSEMONUSCEDENTE] varchar(2) NULL,
    [TPREFDTVENCEXP2] varchar(1) NOT NULL,
    [TRAVESTITRANSEXUAL] varchar(1) NULL,
    [AD_TIPTRANSFPIX] varchar(10) NULL,
    [AD_TIPCHAVEPIX] varchar(10) NULL,
    [AD_CHAVEPIX] varchar(100) NULL,
    [DTENVIOESOCIAL2221] datetime2(7) NULL,
    [ESOCIALINTEGR2240] varchar(1) NULL,
    [DTESOCIAL2221] datetime2(7) NULL,
    [DTENVIOESOCIAL2210] datetime2(7) NULL,
    [RECIBOESOCIAL2210] varchar(50) NULL,
    [ESOCIALINTEGR2221] varchar(1) NULL,
    [DTENVIOESOCIAL2240] datetime2(7) NULL,
    [DTESOCIAL2210] datetime2(7) NULL,
    [ESOCIALINTEGR2210] varchar(1) NULL,
    [RECIBOESOCIAL2220] varchar(50) NULL,
    [DTESOCIAL2220] datetime2(7) NULL,
    [ESOCIALINTEGR2220] varchar(1) NULL,
    [DTESOCIAL2240] datetime2(7) NULL,
    [RECIBOESOCIAL2240] varchar(50) NULL,
    [DTENVIOESOCIAL2220] datetime2(7) NULL,
    [RECIBOESOCIAL2221] varchar(50) NULL
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
