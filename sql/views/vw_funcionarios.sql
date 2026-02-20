CREATE OR ALTER VIEW dbo.vw_funcionarios
AS
/*
  Cadastro de funcionários "API-ready".
  - Fonte: gold.vw_funcionario
  - Inclui chave técnica estável para uso no DAB
*/
SELECT
  CONVERT(varchar(64), HASHBYTES(
    'SHA2_256',
    CONCAT(
      LTRIM(RTRIM(COALESCE(CAST(f.CPF AS varchar(32)), ''))), '|',
      LTRIM(RTRIM(COALESCE(CAST(f.Cod_Empresa AS varchar(16)), ''))), '|',
      CONVERT(varchar(10), f.Data_Admissao, 23), '|',
      LTRIM(RTRIM(COALESCE(CAST(f.Cargo AS varchar(200)), ''))), '|',
      LTRIM(RTRIM(COALESCE(CAST(f.Funcao AS varchar(200)), ''))), '|',
      LTRIM(RTRIM(COALESCE(CAST(f.Departamento AS varchar(200)), '')))
    )
  ), 2) AS id_funcionario,
  f.CPF AS cpf,
  f.Nome_Funcionario AS nome_funcionario,
  f.Data_Admissao AS data_admissao,
  f.Contabilizacao AS contabilizacao,
  f.Cargo AS cargo,
  f.Categoria AS categoria,
  f.Departamento AS departamento,
  f.Funcao AS funcao,
  f.Cod_Empresa AS cod_empresa,
  f.Nome_Fantasia AS nome_fantasia
FROM [gold].[vw_funcionario] f;
GO
