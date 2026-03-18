SELECT TOP 100
    data, numero_pedido, sku, descricao_produto,
    qtde_vendida, preco_unitario_prod,
    nome_vendedor, cod_vendedor,
    razao_social, municipio, estado,
    categoria, familia, fabricante
FROM gold.vw_venda_diaria_chokdist
WHERE data >= CAST('2026-02-01' AS date)
  AND data <= CAST('2026-02-28' AS date)
ORDER BY data, numero_pedido
