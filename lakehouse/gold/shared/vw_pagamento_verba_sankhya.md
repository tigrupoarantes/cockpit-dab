<!-- generated: lakehouse-object -->
# gold.vw_pagamento_verba_sankhya

- Tipo: `VIEW`
- Industria: `shared`
- Origem: `database:GA_DATALAKE`
- PKs: Nao identificado no banco
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | cod_empresa | smallint | False | False | False | - |
| 2 | razao_social | varchar(40) | False | False | False | - |
| 3 | cod_funcionario | int | False | False | False | - |
| 4 | nome_funcionario | varchar(60) | False | False | False | - |
| 5 | cod_evento | int | False | False | False | - |
| 6 | nome_evento | varchar(100) | False | False | False | - |
| 7 | ano | smallint | False | False | False | - |
| 8 | mes | tinyint | False | False | False | - |
| 9 | nome_mes | varchar(15) | False | False | False | - |
| 10 | data_competencia | date | False | False | False | - |
| 11 | valor | decimal(18,2) | False | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL

```sql

CREATE   VIEW gold.vw_pagamento_verba_sankhya AS
SELECT TOP 10 
    -- Empresa
    e.cod_empresa,
    e.razao_social,

    -- Funcionário
    f.cod_funcionario,
    f.nome_funcionario,

    -- Evento
    ev.cod_evento,
    ev.nome_evento,

    -- Tempo
    c.ano,
    c.mes,
    c.nome_mes,
    c.data AS data_competencia,

    -- Métrica
    fp.valor

FROM silver.fact_pagamento_verba_sankhya fp

INNER JOIN silver.dim_empresa e
    ON fp.sk_empresa = e.sk_empresa

INNER JOIN silver.dim_funcionario f
    ON fp.sk_funcionario = f.sk_funcionario

INNER JOIN silver.dim_evento ev
    ON fp.sk_evento = ev.sk_evento

INNER JOIN silver.dim_calendario c
    ON fp.sk_calendario = c.sk_calendario;
```
