# De/Para de Views

Atualizado em `2026-03-25` com consulta ao vivo no banco `GA_DATALAKE`.

## Resumo
- Views locais analisadas em `sql/views`: `22`
- Views encontradas no banco (`sys.views`): `25`
- `gold.vw_funcionario` existe no banco: `sim`
- Total de funcionarios em `gold.vw_funcionario`: `1376`

## Existe no repositorio e no banco
- `dbo.vw_companies`
- `dbo.vw_coverage_city`
- `dbo.vw_coverage_city_api`
- `dbo.vw_empresa_dim`
- `dbo.vw_funcionarios`
- `dbo.vw_health`
- `dbo.vw_produtos`
- `dbo.vw_produtos_api`
- `dbo.vw_sales_by_sku`
- `dbo.vw_sales_by_sku_api`
- `dbo.vw_sales_daily`
- `dbo.vw_sales_daily_api`
- `dbo.vw_sales_product_detail`
- `dbo.vw_sales_product_detail_api`
- `dbo.vw_stock_position`
- `dbo.vw_stock_position_api`
- `dbo.vw_venda_prod`
- `dbo.vw_verbas_api`
- `dbo.vw_verbas_long_api`
- `gold.vw_venda_diaria_chokdist`
- `gold.vw_venda_diaria_chokdist_v2`

## Existe so no repositorio
- `dbo.vw_venda_diaria_chokdist_lite`

## Existe so no banco
- `gold.vw_funcionario`
- `gold.vw_pagamento_verba_pivot_mensal`
- `gold.vw_pagamento_verba_sankhya`
- `gold.vw_venda_diaria_g4dist`

## Observacoes
- A view analisada no banco para funcionarios esta em `gold.vw_funcionario` e hoje retorna `1376` linhas.
- No repositorio, a view equivalente disponivel para API e DAB e `dbo.vw_funcionarios`.
- O arquivo `sql/views/vw_venda_prod.original.sql` aponta para o mesmo objeto `dbo.vw_venda_prod` e foi tratado como duplicado de documentacao, sem aumentar a contagem de views locais unicas.
