<!-- generated: lakehouse-object -->
# gold.vw_pagamento_verba_pivot_mensal

- Tipo: `VIEW`
- Industria: `shared`
- Origem: `database:GA_DATALAKE`
- PKs: Nao identificado no banco
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | razao_social | varchar(40) | True | False | False | - |
| 2 | cpf | varchar(11) | True | False | False | - |
| 3 | nome_funcionario | varchar(60) | True | False | False | - |
| 4 | tipo_verba | varchar(32) | False | False | False | - |
| 5 | ano | smallint | False | False | False | - |
| 6 | Janeiro | decimal(38,2) | True | False | False | - |
| 7 | Fevereiro | decimal(38,2) | True | False | False | - |
| 8 | Marco | decimal(38,2) | True | False | False | - |
| 9 | Abril | decimal(38,2) | True | False | False | - |
| 10 | Maio | decimal(38,2) | True | False | False | - |
| 11 | Junho | decimal(38,2) | True | False | False | - |
| 12 | Julho | decimal(38,2) | True | False | False | - |
| 13 | Agosto | decimal(38,2) | True | False | False | - |
| 14 | Setembro | decimal(38,2) | True | False | False | - |
| 15 | Outubro | decimal(38,2) | True | False | False | - |
| 16 | Novembro | decimal(38,2) | True | False | False | - |
| 17 | Dezembro | decimal(38,2) | True | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL

```sql

CREATE   VIEW gold.vw_pagamento_verba_pivot_mensal AS
WITH base AS (
    SELECT
        e.razao_social,
        f.cpf,
        f.nome_funcionario,
        c.ano,
        c.mes,
        e.sk_empresa,
        ev.cod_evento,
        fp.valor
    FROM silver.fact_pagamento_verba_sankhya fp
    LEFT JOIN silver.dim_empresa e
        ON fp.sk_empresa = e.sk_empresa
    LEFT JOIN silver.dim_funcionario f
        ON fp.sk_funcionario = f.sk_funcionario
        --AND f.situacao = 1 
    LEFT JOIN silver.dim_evento ev
        ON fp.sk_evento = ev.sk_evento
    INNER JOIN silver.dim_calendario c
        ON fp.sk_calendario = c.sk_calendario
),

classificacao AS (
    SELECT
        razao_social,
        cpf,
        nome_funcionario,
        ano,
        mes,
        CASE 
            WHEN sk_empresa = 15 
                THEN 'PJ'
            ELSE
                CASE 
                    WHEN cod_evento IN (1,10095,7,540,541,10088,10001,10035,10027,10063, 61,87,51,91, 10102,23)
                        THEN 'SALDO_SALARIO'
                    --WHEN cod_evento IN (10102,23)
                     --   THEN 'COMPLEMENTO_SALARIAL'
                    WHEN cod_evento IN (30,10044)
                        THEN 'COMISSAO_DSR'
                    WHEN cod_evento IN (31)
                        THEN 'BONUS'
                    WHEN cod_evento IN (10087,10114)
                        THEN 'PREMIO'
                    --WHEN cod_evento IN (61,87,51,91)
                   --     THEN 'ADCNOT_HORAEXTRA_DSR'
                    WHEN cod_evento IN (10000)
                        THEN 'VERBA_INDENIZATORIA'
                    WHEN cod_evento IN (10054)
                        THEN 'ADIANTAMENTO_VERBA_INDENIZATORIA'
                    --WHEN cod_evento IN (10096)
                      --  THEN 'VALE_ALIMENTACAO'
                    --WHEN cod_evento IN (10008,10009)
                        --THEN 'DESC_PLANO_SAUDE'
                    --WHEN cod_evento IN (10098)
                     --   THEN 'PLANO_SAUDE_EMPRESA'
                    --WHEN cod_evento IN (10097)
                    --    THEN 'SEGURO_VIDA'
                   -- WHEN cod_evento IN (10100)
                    --    THEN 'SST'
                    --WHEN cod_evento IN (995,996)
                    --    THEN 'FGTS'
                    ELSE 'OUTROS'
                END
            END AS tipo_verba,
        valor
    FROM base
),

agregado AS (
    SELECT
        razao_social,
        cpf,
        nome_funcionario,
        tipo_verba,
        ano,
        mes,
        SUM(valor) AS valor
    FROM classificacao
    GROUP BY
        razao_social,
        cpf,
        nome_funcionario,
        tipo_verba,
        ano,
        mes
)

SELECT
    razao_social,
    cpf,
    nome_funcionario,
    tipo_verba,
    ano,
    SUM(CASE WHEN mes = 1  THEN valor ELSE 0 END) AS Janeiro,
    SUM(CASE WHEN mes = 2  THEN valor ELSE 0 END) AS Fevereiro,
    SUM(CASE WHEN mes = 3  THEN valor ELSE 0 END) AS Marco,
    SUM(CASE WHEN mes = 4  THEN valor ELSE 0 END) AS Abril,
    SUM(CASE WHEN mes = 5  THEN valor ELSE 0 END) AS Maio,
    SUM(CASE WHEN mes = 6  THEN valor ELSE 0 END) AS Junho,
    SUM(CASE WHEN mes = 7  THEN valor ELSE 0 END) AS Julho,
    SUM(CASE WHEN mes = 8  THEN valor ELSE 0 END) AS Agosto,
    SUM(CASE WHEN mes = 9  THEN valor ELSE 0 END) AS Setembro,
    SUM(CASE WHEN mes = 10  THEN valor ELSE 0 END) AS Outubro,
    SUM(CASE WHEN mes = 11 THEN valor ELSE 0 END) AS Novembro,
    SUM(CASE WHEN mes = 12 THEN valor ELSE 0 END) AS Dezembro
FROM agregado
WHERE tipo_verba NOT IN ('OUTROS','PJ')
GROUP BY
    razao_social,
    cpf,
    nome_funcionario,
    tipo_verba,
    ano
```
