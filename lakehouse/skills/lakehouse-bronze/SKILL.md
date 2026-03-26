---
name: lakehouse-bronze
description: Analisar a camada bronze do data lakehouse. Use quando precisar revisar ingestao, tabelas raw, rastreabilidade, classificacao inicial por industria, cargas base e dependencias que alimentam silver e gold.
---

# Lakehouse Bronze

Foque em ingestao, origem e rastreabilidade da camada `bronze`.

## Prioridades

- identificar tabelas base por distribuidora
- separar objetos compartilhados de objetos especificos de industria
- apontar risco de naming ambiguo ainda na origem
- mapear tabelas bronze que alimentam objetos silver/gold relevantes

## Referencias

- `lakehouse/catalog/manifest.json`
- `lakehouse/bronze/*/index.md`
- `docs/schema_columns.csv`
- `docs/schema_fks.csv`

## Checklist

- confirmar se o objeto e raw/base
- verificar se o nome sugere industria
- identificar dependencias para silver ou gold
- registrar riscos de acoplamento ou mistura de dominios
