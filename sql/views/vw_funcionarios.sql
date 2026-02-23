CREATE OR ALTER VIEW dbo.vw_funcionarios
AS
/*
  Cadastro de funcionários "API-ready".
  - Fonte: silver.dim_* (camada semântica)
  - Inclui chave técnica estável para uso no DAB
*/
SELECT
  CONVERT(varchar(64), HASHBYTES(
    'SHA2_256',
    CONCAT(
      LTRIM(RTRIM(COALESCE(CAST(f.cpf AS varchar(32)), ''))), '|',
      LTRIM(RTRIM(COALESCE(CAST(e.cod_empresa AS varchar(16)), ''))), '|',
      CONVERT(varchar(10), f.data_admissao, 23), '|',
      LTRIM(RTRIM(COALESCE(CAST(c.nome_cargo AS varchar(200)), ''))), '|',
      LTRIM(RTRIM(COALESCE(CAST(fc.nome_funcao AS varchar(200)), ''))), '|',
      LTRIM(RTRIM(COALESCE(CAST(d.nome_departamento AS varchar(200)), '')))
    )
  ), 2) AS id_funcionario,
  f.cpf AS cpf,
  f.nome_funcionario AS nome_funcionario,
  f.email AS email,
  CASE f.sexo
    WHEN 'M' THEN N'MASCULINO'
    WHEN 'F' THEN N'FEMININO'
    ELSE N'INDEFINIDO'
  END AS sexo,
  f.data_nascimento AS data_nascimento,
  DATEDIFF(YEAR, f.data_nascimento, GETDATE())
  - CASE
      WHEN DATEADD(YEAR, DATEDIFF(YEAR, f.data_nascimento, GETDATE()), f.data_nascimento) > GETDATE()
      THEN 1
      ELSE 0
    END AS idade,
  f.data_admissao AS data_admissao,
  CASE f.primeiro_emprego
    WHEN 1 THEN N'SIM'
    ELSE N'NÃO'
  END AS primeiro_emprego,
  CASE f.cod_contabilizacao
    WHEN 10 THEN N'DESCONSIDERAR'
    WHEN 9  THEN N'CHOK AGRO'
    WHEN 3  THEN N'CHOK DISTRIBUIDORA'
    WHEN 4  THEN N'BROKER J. ARANTES'
    WHEN 5  THEN N'LOJAS CHOKDOCE'
    WHEN 8  THEN N'ESCRITORIO CENTRAL'
    WHEN 11 THEN N'G4 DISTRIBUIDORA'
    ELSE N'INDEFINIDO'
  END AS contabilizacao,
  c.nome_cargo AS cargo,
  cat.nome_categoria AS categoria,
  d.nome_departamento AS departamento,
  fc.nome_funcao AS funcao,
  e.cod_empresa AS cod_empresa,
  e.nome_fantasia AS nome_fantasia
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
  ON f.sk_funcao = fc.sk_funcao;
GO
