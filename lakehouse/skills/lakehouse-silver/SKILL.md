---
name: lakehouse-silver
description: Analisar a camada silver do data lakehouse. Use quando precisar revisar dimensoes, fatos, chaves substitutas, relacionamentos, conformidade entre industrias e a transicao da bronze para a camada analitica.
---

# Lakehouse Silver

Foque em modelagem intermediaria, integridade e reuso analitico da camada `silver`.

## Prioridades

- distinguir dimensoes, fatos e bridges
- avaliar integridade referencial e dependencias
- verificar se a classificacao por industria esta coerente
- identificar objetos `shared` que servem varias industrias

## Referencias

- `lakehouse/catalog/manifest.json`
- `lakehouse/silver/*/index.md`
- `docs/schema_fks.csv`

## Checklist

- conferir PKs e relacionamentos
- mapear bridges e fatos por industria
- destacar objetos conformados em `shared`
- apontar riscos para consumo em gold
