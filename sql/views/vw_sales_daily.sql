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
  v.tenant_id                                        AS tenant_id,
  v.dt_ref                                           AS dt_ref,
  CAST(SUM(v.qt_vendida * v.vl_unit_venda) AS numeric(18,4)) AS vl_venda,
  COUNT(DISTINCT v.numero_pedido)                    AS qt_pedidos
FROM dbo.vw_sales_product_detail v
GROUP BY
  v.tenant_id,
  v.dt_ref;
GO

