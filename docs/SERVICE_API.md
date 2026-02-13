# Serviço Cockpit GA — API (DAB via IIS)

Este documento descreve como consumir a API de leitura do Datalake (SQL Server) publicada via **IIS (HTTPS)** fazendo proxy para o **Microsoft Data API Builder (DAB)**.

> Objetivo: sua aplicação conseguir configurar a conexão (base URL + API Key), testar conectividade e consumir os endpoints com paginação.

## 1) Visão geral

- **Tipo**: API REST **read-only**.
- **Backend**: DAB conectado ao SQL Server.
- **Publicação**: IIS com **HTTPS (443)** e proxy reverso para o DAB.
- **Prefixo de rotas**:
  - Interno (DAB): `/api/*`
  - Público (IIS): `/v1/*` (alias para `/api/*`)

## 2) URL base

### Produção
- Base URL: `https://api.grupoarantes.emp.br/v1`

### Desenvolvimento local
- Base URL: `http://localhost:5000/api`

> Importante: em produção, o IIS valida a API Key. Em ambiente local (rodando DAB direto), tipicamente não há essa validação.

## 3) Autenticação (API Key)

A proteção atual é feita no **IIS** exigindo um header.

- Header obrigatório: `X-API-Key: <SUA_CHAVE>`

Recomendação para o app:
- Armazenar a chave em segredo (vault/secret manager/env var), nunca hardcoded.
- Enviar `X-API-Key` em **todas** as requisições.

## 4) Headers para teste

- Obrigatório:
  - `X-API-Key: <SUA_CHAVE>`
- Recomendado:
  - `Accept: application/json`
- Para requests com body (não usado no MVP, mas padrão HTTP):
  - `Content-Type: application/json; charset=utf-8`

## 5) Endpoints disponíveis

A lista abaixo reflete as entidades configuradas no DAB (ver [dab/dab-config.json](../dab/dab-config.json)).

> Todos os endpoints abaixo são **GET**.

### Healthcheck
- `GET /health`

### Vendas
- `GET /sales_daily`
- `GET /sales_by_sku`
- `GET /venda_prod`

### Cobertura
- `GET /coverage_city`

### Estoque
- `GET /stock_position`

### Produtos
- `GET /produtos`

Exemplo (produção):
- `https://api.grupoarantes.emp.br/v1/health`

Exemplo (local):
- `http://localhost:5000/api/health`

## 6) Paginação

A paginação do DAB REST usa:
- `$first=<N>`: quantidade de itens na página
- `$after=<TOKEN>`: token para próxima página

Exemplo (primeira página):
- `GET /venda_prod?$first=100`

Exemplo (próxima página):
- `GET /venda_prod?$first=100&$after=<TOKEN>`

Resposta:
- Retorna um payload JSON com uma lista de itens.
- Quando houver mais páginas, o DAB inclui um link/token de próxima página (ex.: `nextLink`).

## 7) Exemplos prontos (PowerShell)

### 7.1 Health
```powershell
$base = "https://api.grupoarantes.emp.br/v1"
$headers = @{ "X-API-Key" = "<SUA_CHAVE>"; "Accept" = "application/json" }
Invoke-RestMethod -Method Get -Uri "$base/health" -Headers $headers
```

### 7.2 venda_prod (com paginação)
```powershell
$base = "https://api.grupoarantes.emp.br/v1"
$headers = @{ "X-API-Key" = "<SUA_CHAVE>"; "Accept" = "application/json" }

# Primeira página
$r1 = Invoke-RestMethod -Method Get -Uri "$base/venda_prod?`$first=10" -Headers $headers
$r1.value

# Próxima página (se existir)
# $next = $r1.nextLink
# $r2 = Invoke-RestMethod -Method Get -Uri $next -Headers $headers
```

## 8) Exemplos prontos (curl)

```bash
curl -H "X-API-Key: <SUA_CHAVE>" \
     -H "Accept: application/json" \
     "https://api.grupoarantes.emp.br/v1/health"
```

```bash
curl -H "X-API-Key: <SUA_CHAVE>" \
     -H "Accept: application/json" \
     "https://api.grupoarantes.emp.br/v1/venda_prod?$first=10"
```

## 9) Como configurar no app

Config mínima sugerida:
- `DAB_BASE_URL`:
  - Produção: `https://api.grupoarantes.emp.br/v1`
  - Local: `http://localhost:5000/api`
- `DAB_API_KEY`: valor da chave (somente produção)
- `DAB_TIMEOUT_MS`: ex.: `15000`

Padrão de request:
- Método: `GET`
- Headers: `X-API-Key` + `Accept: application/json`
- Timeout: 15s (ajustável)

## 10) Troubleshooting rápido

- **401 Unauthorized**: header `X-API-Key` ausente ou inválido.
- **404**: caminho errado (em produção use `/v1/...`, em local use `/api/...`).
- **502/503**: IIS/proxy não conseguiu falar com o DAB (backend parado/porta errada).

## 11) Referências do repo

- Config DAB (entidades/rotas): [dab/dab-config.json](../dab/dab-config.json)
- Script de teste local (sem IIS): [scripts/test-endpoints.ps1](../scripts/test-endpoints.ps1)
- Script para rodar o DAB local: [scripts/run-local.ps1](../scripts/run-local.ps1)
