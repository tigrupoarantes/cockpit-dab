CREATE OR ALTER VIEW dbo.vw_coverage_city
AS
/*
  MVP: Cobertura/positivação por cidade/região.

  Requisitos:
  - tenant_id
  - dt_ref (quando aplicável)
  - cidade/região
  - métricas (clientes ativos/positivados etc.)

  TODO: ajustar FROM/JOIN conforme tabelas fato/dim reais do datalake.
*/
SELECT
  CAST(NULL AS int)          AS tenant_id,
  CAST(NULL AS date)         AS dt_ref,
  CAST(NULL AS varchar(120)) AS ds_cidade,
  CAST(NULL AS varchar(120)) AS ds_regiao,
  CAST(NULL AS int)          AS qt_clientes,
  CAST(NULL AS int)          AS qt_positivados
WHERE 1 = 0;
GO
