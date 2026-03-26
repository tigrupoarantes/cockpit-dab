<!-- generated: lakehouse-object -->
# bronze.end_cliente_chokdistribuidora

- Tipo: `TABLE`
- Industria: `chokdistribuidora`
- Origem: `database:GA_DATALAKE`
- PKs: Nao identificado no banco
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | cd_clien | int | True | False | False | - |
| 2 | tp_end | char(2) | True | False | False | - |
| 3 | endereco | varchar(140) | True | False | False | - |
| 4 | bairro | varchar(60) | True | False | False | - |
| 5 | municipio | varchar(60) | True | False | False | - |
| 6 | cep | int | True | False | False | - |
| 7 | estado | char(2) | True | False | False | - |
| 8 | loc_guia | varchar(15) | True | False | False | - |
| 9 | local_cob | varchar(30) | True | False | False | - |
| 10 | cd_cep_munic | int | True | False | False | - |
| 11 | logradouro | varchar(60) | True | False | False | - |
| 12 | numero | varchar(15) | True | False | False | - |
| 13 | complemento | varchar(60) | True | False | False | - |
| 14 | cd_pais | char(3) | True | False | False | - |
| 15 | distrito | varchar(60) | True | False | False | - |
| 17 | latitude | numeric(15,12) | True | False | False | - |
| 18 | longitude | numeric(15,12) | True | False | False | - |
| 19 | ponto_cardeal_lat | char(1) | True | False | False | - |
| 20 | grau_lat | int | True | False | False | - |
| 21 | min_lat | int | True | False | False | - |
| 22 | seg_lat | int | True | False | False | - |
| 23 | ponto_cardeal_lon | char(1) | True | False | False | - |
| 24 | grau_lon | int | True | False | False | - |
| 25 | min_lon | int | True | False | False | - |
| 26 | seg_lon | int | True | False | False | - |
| 27 | CodigoProvedorCoordenada | int | True | False | False | - |
| 28 | IncMobLogradouro | varchar(60) | True | False | False | - |
| 29 | IncMobNumero | varchar(15) | True | False | False | - |
| 30 | IncMobComplemento | varchar(60) | True | False | False | - |
| 31 | FonteCoordenadaID | smallint | True | False | False | - |
| 32 | OrigemCoordenadaID | smallint | True | False | False | - |
| 33 | EndCliID | int | True | False | False | - |
| 34 | CodigoPostal | varchar(10) | True | False | False | - |
| 35 | Anonimizado | bit | True | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL Reconstruida

```sql
CREATE TABLE [bronze].[end_cliente_chokdistribuidora] (
    [cd_clien] int NULL,
    [tp_end] char(2) NULL,
    [endereco] varchar(140) NULL,
    [bairro] varchar(60) NULL,
    [municipio] varchar(60) NULL,
    [cep] int NULL,
    [estado] char(2) NULL,
    [loc_guia] varchar(15) NULL,
    [local_cob] varchar(30) NULL,
    [cd_cep_munic] int NULL,
    [logradouro] varchar(60) NULL,
    [numero] varchar(15) NULL,
    [complemento] varchar(60) NULL,
    [cd_pais] char(3) NULL,
    [distrito] varchar(60) NULL,
    [latitude] numeric(15,12) NULL,
    [longitude] numeric(15,12) NULL,
    [ponto_cardeal_lat] char(1) NULL,
    [grau_lat] int NULL,
    [min_lat] int NULL,
    [seg_lat] int NULL,
    [ponto_cardeal_lon] char(1) NULL,
    [grau_lon] int NULL,
    [min_lon] int NULL,
    [seg_lon] int NULL,
    [CodigoProvedorCoordenada] int NULL,
    [IncMobLogradouro] varchar(60) NULL,
    [IncMobNumero] varchar(15) NULL,
    [IncMobComplemento] varchar(60) NULL,
    [FonteCoordenadaID] smallint NULL,
    [OrigemCoordenadaID] smallint NULL,
    [EndCliID] int NULL,
    [CodigoPostal] varchar(10) NULL,
    [Anonimizado] bit NULL
);
```

_Observacao: a DDL acima foi reconstruida a partir de metadados do catalogo do SQL Server._
