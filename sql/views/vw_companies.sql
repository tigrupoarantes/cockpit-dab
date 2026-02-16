CREATE OR ALTER VIEW dbo.vw_companies
AS
/*
  Companies/Empresas disponíveis no datalake.

  Observação importante:
  - Neste banco, os identificadores de empresa disponíveis de forma consistente são:
    - cod_empresa
    - nome_empresa (em dbo.dim_vendedor)
  - Não foi encontrado um campo de CNPJ da empresa no schema atual (apenas CPF/CNPJ de cliente/fornecedor).

  Contrato para o Cockpit (MVP):
  - code (string)
  - name (string)
  - cnpj (string|null)

  Campos extras são opcionais e podem ser preenchidos futuramente quando houver tabela/dimensão de empresa.
*/
SELECT
  CAST(e.cod_empresa AS varchar(10))    AS code,
  CAST(e.nome_empresa AS varchar(200))  AS name,
  CAST(e.cnpj_empresa_origem AS varchar(18)) AS cnpj,
  CAST(NULL AS varchar(20))           AS businessType,
  CAST(NULL AS varchar(20))           AS segmentMode
FROM dbo.vw_empresa_dim e;
GO

