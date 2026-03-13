CREATE OR ALTER VIEW dbo.vw_verbas_api
AS
SELECT
  CONVERT(varchar(64), HASHBYTES('SHA2_256', CONCAT(
    ISNULL(CAST(src.razao_social AS nvarchar(4000)), N''), N'|',
    ISNULL(CAST(src.cpf AS nvarchar(4000)), N''), N'|',
    ISNULL(CAST(src.nome_funcionario AS nvarchar(4000)), N''), N'|',
    ISNULL(CAST(src.tipo_verba AS nvarchar(4000)), N''), N'|',
    ISNULL(CAST(src.ano AS nvarchar(30)), N'')
  )), 2) AS id_verba,
  src.razao_social,
  src.cpf,
  src.nome_funcionario,
  src.tipo_verba,
  src.ano,
  src.Janeiro,
  src.Fevereiro,
  src.Marco,
  src.Abril,
  src.Maio,
  src.Junho,
  src.Julho,
  src.Agosto,
  src.Setembro,
  src.Outrubro,
  src.Novembro,
  src.Dezembro
FROM gold.vw_pagamento_verba_pivot_mensal AS src;
GO