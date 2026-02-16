# Documentação técnica — Cockpit DAB (IIS + Data API Builder)

Data: 2026-02-16  
Repo: `cockpit-dab`  
Objetivo: API REST read-only para o Cockpit consumir views do SQL Server (Datalake) sem replicar dados.

## 1) Arquitetura (como funciona em produção)

- **Público**: IIS 10 (HTTPS) publica a API em `https://api.grupoarantes.emp.br/v1`.
- **Proxy**: IIS (ARR/URL Rewrite) encaminha `/v1/*` → `http://localhost:5000/api/*`.
- **Backend**: Microsoft Data API Builder (DAB) escutando em `http://localhost:5000` com REST em `/api`.
- **Banco**: SQL Server (GA_DATALAKE), fonte dos dados via **views** no schema `dbo` (ex.: `dbo.vw_*`).

Fluxo:

1. Cliente chama `GET https://api.grupoarantes.emp.br/v1/<entidade>`
2. IIS valida header `X-API-Key`
3. IIS faz proxy para o DAB local (`localhost:5000/api/<entidade>`)
4. DAB executa `SELECT` na view correspondente e retorna JSON com paginação (`nextLink`)

## 2) Segurança (estado atual)

- **Validação de API Key** é feita no **IIS** via header `X-API-Key`.
- No DAB, as entidades estão com `permissions` para role `anonymous` (porque o controle está no IIS).
- GraphQL está **desabilitado em runtime** no `dab-config.json`.

## 3) Configuração do DAB

Arquivo: `dab/dab-config.json`

Pontos relevantes:

- `runtime.rest.path = /api`
- `runtime.graphql.enabled = false`
- `data-source.connection-string = @env('DAB_CONNECTION_STRING')`
- Entidades mapeiam **1:1** para views (`source.type = view`, `source.object = dbo.<view>`)
- `key-fields` precisam existir na view e identificar uma linha (senão o DAB pode falhar ao iniciar).

## 4) Operação (watchdog + painel)

### 4.1 Watchdog (não deixar o DAB parar)

- Nome da task: `Cockpit-DAB-Watchdog`
- Script principal: `scripts/dab-watchdog.ps1`
- Instalador: `scripts/install-watchdog-task.ps1`

Funções do watchdog:

- Garante que o DAB está rodando (porta 5000 aberta)
- Faz healthchecks:
  - Local: `http://localhost:5000/api/health`
  - Público (sem chave / com chave, quando aplicável)
- Gera artefatos consumidos pelo painel:
  - `status.json`
  - `catalog.json`

Logs:

- Task watchdog: `logs/dab-watchdog-task.log`
- Runtime do DAB (quando iniciado pelo script): `logs/dab-runtime.log` e `logs/dab-runtime.err.log`

### 4.2 Painel de status

- Instalador: `scripts/install-status-page.ps1`
- URL no servidor: `http://localhost/status/`

Observação: no hostname público pode haver 401 para `/status` por causa da regra de `X-API-Key`.

Arquivos servidos:

- `http://localhost/status/status.json`
- `http://localhost/status/catalog.json`

## 5) Catálogo (SQL x DAB) e onboarding de novas views

### 5.1 Catálogo

- O watchdog consulta `sys.views` (schema `dbo`) e registra as views em `catalog.json`.
- O mesmo arquivo inclui o catálogo de entidades do DAB (lendo `dab/dab-config.json`).
- O diff `viewsNotExposed` indica views existentes no SQL que ainda não viraram entidade no DAB.

### 5.2 Onboarding (publicar uma view nova no DAB)

Script: `scripts/onboard-dab-view.ps1`

Exemplo:

```powershell
cd C:\Github\cockpit-dab
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\onboard-dab-view.ps1 \
  -ViewName vw_sales_product_detail \
  -EntityName sales_product_detail \
  -KeyFields id_venda \
  -RestartDab
```

Checklist do DBA/dev antes de publicar:

- A view está em `dbo` (ex.: `dbo.vw_*`).
- As colunas de `KeyFields` existem e não são nulas (idealmente).
- A entidade aparece no painel e o endpoint responde `200`.

## 6) Runbook rápido (verificar status e recuperar)

- Ver status humano: `http://localhost/status/`
- Ver health local: `http://localhost:5000/api/health`
- Se caiu e não voltou:
  1) Ver `logs/dab-watchdog-task.log`
  2) Ver `logs/dab-runtime.err.log`
  3) Rodar manualmente `scripts/ensure-dab-running.ps1`

## 7) Fonte de verdade para consumo

- Contrato de uso (base URL, headers, endpoints, paginação): `docs/SERVICE_API.md`
