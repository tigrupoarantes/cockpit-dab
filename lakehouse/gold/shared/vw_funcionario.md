<!-- generated: lakehouse-object -->
# gold.vw_funcionario

- Tipo: `VIEW`
- Industria: `shared`
- Origem: `database:GA_DATALAKE`
- PKs: Nao identificado no banco
- Relacionamentos: 0

## Colunas

| ordem | coluna | tipo | nullable | identity | computed | default |
|---:|---|---|---|---|---|---|
| 1 | Situacao | tinyint | True | False | False | - |
| 2 | CPF | varchar(11) | False | False | False | - |
| 3 | Nome_Funcionario | varchar(60) | False | False | False | - |
| 4 | Email | varchar(100) | True | False | False | - |
| 5 | Sexo | varchar(10) | False | False | False | - |
| 6 | Data_Nascimento | date | True | False | False | - |
| 7 | Idade | int | True | False | False | - |
| 8 | Data_Admissao | date | True | False | False | - |
| 9 | Data_Demissao | date | True | False | False | - |
| 10 | Primeiro_Emprego | varchar(3) | False | False | False | - |
| 11 | Contabilizacao | varchar(18) | False | False | False | - |
| 12 | Cargo | varchar(40) | True | False | False | - |
| 13 | Categoria | varchar(40) | True | False | False | - |
| 14 | Departamento | varchar(40) | True | False | False | - |
| 15 | Funcao | varchar(40) | True | False | False | - |
| 16 | Cod_Empresa | smallint | True | False | False | - |
| 17 | Nome_Fantasia | varchar(40) | True | False | False | - |

## Relacionamentos

| fk | coluna | referencia |
|---|---|---|
| - | - | - |

## DDL

```sql

CREATE VIEW gold.vw_funcionario AS
WITH base AS
(
    SELECT 
        f.situacao AS Situacao
        , f.cpf AS CPF
        , f.nome_funcionario AS Nome_Funcionario
        , f.email AS Email
        , CASE f.sexo 
            WHEN 'M' THEN 'MASCULINO'
            WHEN 'F' THEN 'FEMININO'
            ELSE 'INDEFINIDO'
          END AS Sexo
        , f.data_nascimento AS Data_Nascimento
        , DATEDIFF(YEAR, f.data_nascimento, GETDATE()) 
          - CASE 
                WHEN DATEADD(YEAR, DATEDIFF(YEAR, f.data_nascimento, GETDATE()), f.data_nascimento) > GETDATE() 
                THEN 1 
                ELSE 0 
            END AS Idade
        , f.data_admissao AS Data_Admissao
        , f.data_demissao AS Data_Demissao
        , CASE f.primeiro_emprego
            WHEN 1 THEN 'SIM'
            ELSE 'NÃO'
          END AS Primeiro_Emprego
        , CASE f.cod_contabilizacao
            WHEN 9  THEN 'CHOK AGRO'
            WHEN 3  THEN 'CHOK DISTRIBUIDORA'
            WHEN 4  THEN 'BROKER J. ARANTES'
            WHEN 5  THEN 'LOJAS CHOKDOCE'
            WHEN 8  THEN 'ESCRITORIO CENTRAL'
            WHEN 11 THEN 'G4 DISTRIBUIDORA'
            ELSE 'INDEFINIDO'
          END AS Contabilizacao
        , c.nome_cargo AS Cargo
        , cat.nome_categoria AS Categoria
        , d.nome_departamento AS Departamento
        , fc.nome_funcao AS Funcao
        , e.cod_empresa AS Cod_Empresa
        , e.nome_fantasia AS Nome_Fantasia
        , ROW_NUMBER() OVER (
            PARTITION BY f.cpf
            ORDER BY 
                CASE WHEN f.situacao = 1 THEN 0 ELSE 1 END,
                CASE WHEN f.data_demissao IS NULL THEN 0 ELSE 1 END,
                f.data_demissao DESC,
                f.data_admissao DESC
          ) AS rn
    FROM silver.dim_funcionario AS f
    LEFT JOIN silver.dim_empresa AS e
        ON f.sk_empresa = e.sk_empresa
    LEFT JOIN silver.dim_cargo AS c
        ON f.sk_cargo = c.sk_cargo
    LEFT JOIN silver.dim_categoria AS cat
        ON f.sk_categoria = cat.sk_categoria
    LEFT JOIN silver.dim_departamento AS d
        ON f.sk_departamento = d.sk_departamento
    LEFT JOIN silver.dim_funcao AS fc
        ON f.sk_funcao = fc.sk_funcao
    WHERE 
        f.cod_contabilizacao NOT IN (0, 6, 7, 10)
        AND e.cod_empresa IN (2,3,5,6,7,8,9,10,11,12,14,15,16,18,26,28)
        AND (
            f.data_demissao >= '2025-01-01'
            OR f.data_demissao IS NULL
        )
        AND f.situacao NOT IN (8)
        
)
SELECT
    Situacao,
    CPF,
    Nome_Funcionario,
    Email,
    Sexo,
    Data_Nascimento,
    Idade,
    Data_Admissao,
    Data_Demissao,
    Primeiro_Emprego,
    Contabilizacao,
    Cargo,
    Categoria,
    Departamento,
    Funcao,
    Cod_Empresa,
    Nome_Fantasia
FROM base
WHERE rn = 1;
```
