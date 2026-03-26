---
name: lakehouse-naming
description: Validar naming e classificacao de objetos do data lakehouse. Use quando precisar interpretar sufixos como `_chokdistribuidora`, `_g4distribuidora` e `_g4_distribuidora`, detectar excecoes, definir overrides ou padronizar nomenclatura por camada e industria.
---

# Lakehouse Naming

Aplique as regras de classificacao e naming do pacote `lakehouse/`.

## Regras centrais

- Objetos que terminam com `_chokdistribuidora` pertencem a `chokdistribuidora`.
- Objetos que terminam com `_g4distribuidora` ou `_g4_distribuidora` pertencem a `g4distribuidora`.
- Objetos sem sufixo de industria ficam em `shared`.
- Objetos com sufixo tecnico, legado ou de sistema ficam em `shared`, a menos que exista override.

## Fontes de verdade

- `lakehouse/README.md`
- `lakehouse/catalog/classification-overrides.json`
- `lakehouse/catalog/manifest.json`

## Tarefas

- validar se um nome segue o padrao esperado
- explicar por que um objeto foi classificado em determinada industria
- sugerir novos overrides quando houver falso positivo ou falso negativo
- diferenciar sufixo de industria de sufixo tecnico
