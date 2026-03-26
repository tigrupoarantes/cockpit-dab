<!-- generated: lakehouse-object -->
# bronze.vendedor_g4_distribuidora

- Tipo: `TABLE`
- Industria: `g4distribuidora`
- Origem: `database:GA_DATALAKE`
- PKs: Nao identificado no banco
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | cd_vend | char(8) | False | False | False | - |
| 2 | cd_emp | int | False | False | False | - |
| 3 | cd_equipe | char(4) | False | False | False | - |
| 4 | nome | varchar(40) | False | False | False | - |
| 5 | nome_gue | varchar(20) | False | False | False | - |
| 6 | categ | char(3) | False | False | False | - |
| 7 | cd_grupo | char(4) | True | False | False | - |
| 8 | ramal_emp | int | True | False | False | - |
| 9 | vda_periodo | numeric(13,2) | True | False | False | - |
| 10 | end_res | varchar(140) | True | False | False | - |
| 11 | bairro_res | varchar(60) | True | False | False | - |
| 12 | munic_res | varchar(60) | True | False | False | - |
| 13 | est_res | char(2) | True | False | False | - |
| 14 | cep_res | int | True | False | False | - |
| 15 | perc_desc | numeric(6,4) | True | False | False | - |
| 16 | seq_crgprd | int | True | False | False | - |
| 17 | num_lock | tinyint | False | False | False | - |
| 18 | ativo | bit | False | False | False | - |
| 19 | cgc | varchar(14) | True | False | False | - |
| 20 | inscricao | varchar(20) | True | False | False | - |
| 21 | perc_ir | numeric(6,4) | True | False | False | - |
| 22 | tp_pes | char(1) | False | False | False | - |
| 23 | cd_vend_res | int | True | False | False | - |
| 24 | e_mail | varchar(60) | True | False | False | - |
| 25 | perc_desc_absoluto | numeric(6,4) | True | False | False | - |
| 26 | perc_desc_adicional | numeric(6,4) | True | False | False | - |
| 27 | vl_troca_mes | numeric(13,2) | True | False | False | - |
| 28 | desc_item | numeric(6,4) | True | False | False | - |
| 29 | qtde_cli_carteira | int | True | False | False | - |
| 30 | vl_limite_verba | numeric(13,2) | True | False | False | - |
| 31 | cd_texto | int | True | False | False | - |
| 32 | vendedor_novo_nestle | tinyint | False | False | False | - |
| 33 | enviar_arq_nestle | tinyint | False | False | False | - |
| 34 | dt_admissao | smalldatetime | True | False | False | - |
| 35 | cd_forn | int | True | False | False | - |
| 36 | enviar_tp_discagem | bit | True | False | False | - |
| 37 | qtde_max_visitas_dia | int | True | False | False | - |
| 38 | rt | bit | True | False | False | - |
| 39 | tecnico | bit | True | False | False | - |
| 40 | cd_cep_munic | int | True | False | False | - |
| 41 | logradouro | varchar(60) | True | False | False | - |
| 42 | numero | varchar(15) | True | False | False | - |
| 43 | complemento | varchar(60) | True | False | False | - |
| 44 | cd_pais | char(3) | True | False | False | - |
| 45 | distrito_res | varchar(60) | True | False | False | - |
| 47 | VendedorID | int | False | False | False | - |
| 48 | MontagemRotVisitaID | tinyint | False | False | False | - |
| 49 | Latitude | numeric(15,12) | True | False | False | - |
| 50 | Longitude | numeric(15,12) | True | False | False | - |
| 51 | EquipeID | int | False | False | False | - |
| 52 | Anonimizado | bit | True | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL Reconstruida

```sql
CREATE TABLE [bronze].[vendedor_g4_distribuidora] (
    [cd_vend] char(8) NOT NULL,
    [cd_emp] int NOT NULL,
    [cd_equipe] char(4) NOT NULL,
    [nome] varchar(40) NOT NULL,
    [nome_gue] varchar(20) NOT NULL,
    [categ] char(3) NOT NULL,
    [cd_grupo] char(4) NULL,
    [ramal_emp] int NULL,
    [vda_periodo] numeric(13,2) NULL,
    [end_res] varchar(140) NULL,
    [bairro_res] varchar(60) NULL,
    [munic_res] varchar(60) NULL,
    [est_res] char(2) NULL,
    [cep_res] int NULL,
    [perc_desc] numeric(6,4) NULL,
    [seq_crgprd] int NULL,
    [num_lock] tinyint NOT NULL,
    [ativo] bit NOT NULL,
    [cgc] varchar(14) NULL,
    [inscricao] varchar(20) NULL,
    [perc_ir] numeric(6,4) NULL,
    [tp_pes] char(1) NOT NULL,
    [cd_vend_res] int NULL,
    [e_mail] varchar(60) NULL,
    [perc_desc_absoluto] numeric(6,4) NULL,
    [perc_desc_adicional] numeric(6,4) NULL,
    [vl_troca_mes] numeric(13,2) NULL,
    [desc_item] numeric(6,4) NULL,
    [qtde_cli_carteira] int NULL,
    [vl_limite_verba] numeric(13,2) NULL,
    [cd_texto] int NULL,
    [vendedor_novo_nestle] tinyint NOT NULL,
    [enviar_arq_nestle] tinyint NOT NULL,
    [dt_admissao] smalldatetime NULL,
    [cd_forn] int NULL,
    [enviar_tp_discagem] bit NULL,
    [qtde_max_visitas_dia] int NULL,
    [rt] bit NULL,
    [tecnico] bit NULL,
    [cd_cep_munic] int NULL,
    [logradouro] varchar(60) NULL,
    [numero] varchar(15) NULL,
    [complemento] varchar(60) NULL,
    [cd_pais] char(3) NULL,
    [distrito_res] varchar(60) NULL,
    [VendedorID] int NOT NULL,
    [MontagemRotVisitaID] tinyint NOT NULL,
    [Latitude] numeric(15,12) NULL,
    [Longitude] numeric(15,12) NULL,
    [EquipeID] int NOT NULL,
    [Anonimizado] bit NULL
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
