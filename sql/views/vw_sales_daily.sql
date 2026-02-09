CREATE OR ALTER VIEW dbo.vw_sales_daily
AS
/*
  MVP: Vendas por dia por tenant.

  Requisitos:
  - Deve expor tenant_id
  - Deve expor uma data de referência (dt_ref)
  - Deve ser eficiente (pré-agregado)

  TODO: ajustar FROM/JOIN conforme tabelas fato/dim reais do datalake.
*/
SELECT
  CAST(NULL AS int)           AS tenant_id,
  CAST(NULL AS date)          AS dt_ref,
  CAST(NULL AS decimal(18,2)) AS vl_venda,
  CAST(NULL AS int)           AS qt_pedidos
WHERE 1 = 0;
GO
