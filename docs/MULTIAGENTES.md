# Multiagentes do Projeto

Este repositório já usa a pasta `.claude/commands/` como base para agentes especializados. A célula inicial de trabalho fica assim:

## Agentes disponíveis

### `dev`
- Arquivo: `.claude/commands/dev.md`
- Foco: views SQL, `dab/dab-config.json`, onboarding de endpoints, performance de queries e implementação funcional.

### `seguranca`
- Arquivo: `.claude/commands/seguranca.md`
- Foco: controle de acesso, risco de exposição de dados, hardening de IIS/DAB, LGPD, credenciais e auditoria.

### `integracoes`
- Arquivo: `.claude/commands/integracoes.md`
- Foco: consumo correto da API, OData, paginação, `nextLink`, exemplos para integradores e contratos externos.

### `infra`
- Arquivo: `.claude/commands/infra.md`
- Foco: IIS, watchdog, disponibilidade, logs, startup do DAB, troubleshooting operacional e deploy.

### `melhorias`
- Arquivo: `.claude/commands/melhorias.md`
- Foco: backlog técnico, otimização contínua, inconsistências entre docs/config/código e priorização de evolução.

## Orquestração recomendada

Use os agentes em sequência curta, não em paralelo indiscriminado.

### 1. Mudança funcional em endpoint/view
- `dev` define a alteração
- `integracoes` valida contrato, paginação e consumo
- `seguranca` revisa exposição de dados se houver novos campos
- `infra` entra apenas se houver impacto em deploy, IIS ou operação

### 2. Incidente em produção
- `infra` faz diagnóstico operacional
- `dev` investiga view, config DAB ou script envolvido
- `integracoes` valida comportamento percebido pelo consumidor
- `seguranca` entra se houver 401/403, vazamento ou desvio de borda

### 3. Novo integrador externo
- `integracoes` define contrato e exemplos
- `dev` garante que a view e a entidade DAB suportam o caso
- `seguranca` revisa risco do endpoint e dos campos

### 4. Otimização e dívida técnica
- `melhorias` monta backlog priorizado
- `dev` executa mudanças de código/view/config
- `infra` ajusta operação quando necessário

## Regras práticas

- Toda mudança em `dab/dab-config.json` deve passar por `dev` e considerar impacto de rota, `key-fields` e paginação.
- Toda exposição de campos de RH, financeiro ou identificadores pessoais deve passar por `seguranca`.
- Toda documentação de consumo em `docs/` deve ser revisada por `integracoes` quando houver mudança contratual.
- Toda alteração que exija restart, watchdog, IIS ou troubleshooting operacional deve envolver `infra`.
- Toda inconsistência recorrente entre código, docs e operação entra no backlog do `melhorias`.

## Próximo passo sugerido

Se quisermos amadurecer essa estrutura, o próximo passo é criar um agente adicional de `qa/review` para revisar regressões, cobertura de testes operacionais e coerência entre endpoint, view e documentação.
