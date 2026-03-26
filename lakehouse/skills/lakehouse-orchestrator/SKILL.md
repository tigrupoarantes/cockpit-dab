---
name: lakehouse-orchestrator
description: Orquestrar tarefas do data lakehouse com estrutura medalhao. Use quando for preciso interpretar pedidos sobre bronze, silver, gold, naming, inventario, qualidade, lineage ou classificacao por industria/distribuidora e decidir qual skill especializada deve conduzir a analise.
---

# Lakehouse Orchestrator

Atue como ponto frontal unico para o pacote `lakehouse/`.

## Use esta skill para

- identificar se o pedido e de inventario, naming, qualidade ou camada
- rotear o trabalho para `lakehouse-inventory`, `lakehouse-naming`, `lakehouse-bronze`, `lakehouse-silver`, `lakehouse-gold` ou `lakehouse-quality`
- consolidar respostas quando a tarefa atravessar mais de uma camada ou industria

## Fluxo

1. Ler `lakehouse/README.md`.
2. Ler `lakehouse/catalog/manifest.json` e `lakehouse/catalog/classification-overrides.json` quando a tarefa depender da estrutura atual.
3. Classificar o pedido por intencao:
   - inventariar ou localizar objetos: `lakehouse-inventory`
   - validar nomes ou industria: `lakehouse-naming`
   - revisar ingestao/raw: `lakehouse-bronze`
   - revisar modelagem e relacionamentos: `lakehouse-silver`
   - revisar camada analitica/semantica: `lakehouse-gold`
   - reconciliar, auditar ou checar integridade: `lakehouse-quality`
4. Se a tarefa envolver mais de um recorte, responder em ordem:
   - camada
   - industria
   - objeto
   - riscos e proximos passos

## Regras

- Tratar `shared` como industria padrao.
- Nao presumir que todo sufixo e uma industria valida; conferir `classification-overrides.json`.
- Em tarefas compostas, citar explicitamente quais skills especializadas foram usadas como referencia.
- Se o inventario estiver desatualizado, orientar a execucao de `lakehouse/scripts/generate-inventory.ps1`.
