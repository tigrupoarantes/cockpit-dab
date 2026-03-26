---
name: lakehouse-inventory
description: Inventariar objetos do data lakehouse por schema e industria. Use quando precisar gerar, atualizar ou consultar catalogos de bronze, silver e gold, navegar por distribuidora, localizar tabelas/views ou manter o manifesto do lakehouse.
---

# Lakehouse Inventory

Mantenha o catalogo estrutural do lakehouse.

## Fontes principais

- `docs/schema_columns.csv`
- `docs/schema_fks.csv`
- `lakehouse/catalog/classification-overrides.json`
- `lakehouse/scripts/generate-inventory.ps1`

## Fluxo

1. Ler os snapshots de schema.
2. Classificar cada objeto em `bronze`, `silver` ou `gold`.
3. Classificar a industria em `shared`, `chokdistribuidora` ou `g4distribuidora`, tratando `g4_distribuidora` como alias canonico de `g4distribuidora`.
4. Atualizar:
   - `lakehouse/catalog/manifest.json`
   - `lakehouse/catalog/manifest.md`
   - `lakehouse/<schema>/<industria>/index.md`

## Regras

- Usar `shared` como fallback.
- Preservar o inventario em nivel de objeto, nao de coluna isolada.
- Registrar quantidade de colunas, PKs e relacionamentos por objeto.
- Quando um objeto tiver override, confiar no override.
