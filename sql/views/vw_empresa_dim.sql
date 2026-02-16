CREATE OR ALTER VIEW dbo.vw_empresa_dim
AS
/*
  Dimensão canônica de empresa (tenant).

  Objetivo (PRD 2): padronizar tenant por CNPJ e reduzir dependência de códigos instáveis.

  IMPORTANTE:
  - No schema atual exportado para este repositório, não foi identificado um campo de CNPJ
    da empresa/tenant (apenas CPF/CNPJ de cliente e fornecedor).
  - Esta view cria a estrutura e permite evolução: assim que existir uma fonte de CNPJ
    (dim/tabela ERP/fiscal), substitua a coluna cnpj_empresa_origem pelo join real.

  Colunas:
  - cod_empresa: chave atual de join com fatos/dimensões
  - cnpj_empresa_origem: CNPJ normalizado (somente dígitos) (placeholder)
  - nome_empresa
*/
SELECT DISTINCT
  v.cod_empresa                                 AS cod_empresa,
  CAST(NULL AS varchar(14))                     AS cnpj_empresa_origem,
  CAST(v.nome_empresa AS varchar(200))          AS nome_empresa
FROM dbo.dim_vendedor v
WHERE v.cod_empresa IS NOT NULL;
GO
