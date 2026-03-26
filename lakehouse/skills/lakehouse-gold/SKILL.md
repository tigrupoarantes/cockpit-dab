---
name: lakehouse-gold
description: Analisar a camada gold do data lakehouse. Use quando precisar revisar views analiticas, semantica de consumo, objetos por distribuidora, superficies shared e a exposicao de dados para API, BI ou casos operacionais.
---

# Lakehouse Gold

Foque na camada semantica e analitica `gold`.

## Prioridades

- identificar views e fatos prontos para consumo
- separar objetos shared de objetos especificos de distribuidora
- revisar coerencia entre silver e gold
- apontar riscos para exposicao em APIs ou ferramentas analiticas

## Referencias

- `lakehouse/catalog/manifest.json`
- `lakehouse/gold/*/index.md`
- `sql/views/`

## Checklist

- validar se o objeto tem perfil analitico ou semantico
- revisar naming e industria
- mapear dependencias principais em silver
- registrar impacto para consumidores
