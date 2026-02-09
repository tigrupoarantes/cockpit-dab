/*
  Executar como DBA (ou usuário com permissão) no database GA_DATALAKE.

  Objetivo:
  - Criar um schema dedicado para as views expostas pela API
  - Permitir que o usuário de deploy (ex.: datalake_consulta) crie/atualize views nesse schema

  Ajuste o usuário conforme necessário.
*/

IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'api')
BEGIN
  EXEC('CREATE SCHEMA api AUTHORIZATION dbo;');
END
GO

-- Permissões mínimas para criar/alterar views dentro do schema api
GRANT ALTER ON SCHEMA::api TO [datalake_consulta];
GRANT SELECT ON SCHEMA::api TO [datalake_consulta];
GO
