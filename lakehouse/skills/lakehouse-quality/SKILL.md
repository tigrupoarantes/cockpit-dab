---
name: lakehouse-quality
description: Auditar qualidade estrutural do data lakehouse. Use quando precisar reconciliar camadas, revisar integridade, checar classificacao por industria, detectar anomalias de modelagem ou validar se o inventario continua consistente com o schema exportado.
---

# Lakehouse Quality

Audite consistencia estrutural do lakehouse.

## Objetivos

- reconciliar inventario vs snapshots exportados
- detectar objetos sem classificacao esperada
- identificar relacoes ausentes ou naming ambiguo
- verificar se a separacao por camada e industria continua coerente

## Referencias

- `lakehouse/catalog/manifest.json`
- `lakehouse/catalog/manifest.md`
- `docs/schema_columns.csv`
- `docs/schema_fks.csv`

## Checklist

- comparar contagens por schema
- revisar objetos `shared` com sufixos suspeitos
- revisar industrias suportadas vs objetos encontrados
- apontar lacunas para novos overrides ou novas distribuidoras
