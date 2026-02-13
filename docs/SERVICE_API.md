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

## 1.1) Formato de resposta (DAB REST)

Os endpoints REST do DAB retornam, em geral, um payload no formato:

```json
{
  "value": [
    { "...": "..." }
  ],
  "nextLink": "/api/<entidade>?$after=<token>&$first=<n>"
}
```

- `value`: lista de linhas retornadas pela view.
- `nextLink`: aparece quando há mais páginas (ver paginação).

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

Retorno esperado (exemplo):

```json
{
  "value": [
    {
      "id": 1,
      "is_ok": true,
      "server_name": "...",
      "database_name": "...",
      "login_name": "...",
      "dt_utc": "2026-02-13T12:34:56.789Z"
    }
  ]
}
```

### Vendas
- `GET /sales_daily`
- `GET /sales_by_sku`
- `GET /venda_prod`

Status atual:
- `venda_prod`: retorna dados (view `dbo.vw_venda_prod` → wrapper da canônica `dbo.vw_sales_product_detail`).
- `sales_daily` e `sales_by_sku`: **stub** (compila, mas retorna 0 linhas até mapeamento final do schema).

### Cobertura
- `GET /coverage_city`

Status atual:
- `coverage_city`: **stub** (0 linhas).

### Estoque
- `GET /stock_position`

Status atual:
- `stock_position`: **stub** (0 linhas).

### Produtos
- `GET /produtos`

### Empresas
- `GET /companies`

Retorna a lista de empresas detectadas no datalake.

Campos (MVP):
- `code`: código da empresa (ex.: `"2"`)
- `name`: nome da empresa
- `cnpj`: **atualmente `null`** (não foi encontrado CNPJ de empresa no schema atual)

Exemplo (produção):
- `https://api.grupoarantes.emp.br/v1/companies`

Status atual:
- `produtos`: **stub** (0 linhas).

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

## 9.1) Integração com Cockpit GA (Supabase)

Pelo desenho do Cockpit, as chamadas para a API DAB devem ser **server-to-server** via **Edge Functions**.

### Mapeamento para `api_connections`

O Cockpit possui a tabela `api_connections` com configuração flexível de auth. Para a API atual (IIS exigindo `X-API-Key`), use:

- `api_base_url`: `https://api.grupoarantes.emp.br/v1`
- `auth_type`: `api_key`
- `api_key`: `<SUA_CHAVE>`
- `auth_header`: `X-API-Key`
- `extra_headers` (opcional):
  - `{ "Accept": "application/json" }`

### Observação importante sobre Bearer

O contrato do Cockpit menciona `Authorization: Bearer <token>`. **Hoje, o gateway no IIS está validando `X-API-Key`**.

Se vocês quiserem padronizar em Bearer no app, existem duas opções:
- Ajustar o app para enviar `X-API-Key` (sem mudar o servidor).
- Ou alterar a regra do IIS para validar `Authorization` (aí atualizamos esta doc e a configuração recomendada).

## 9.2) Endpoint “/companies”

O documento do Cockpit menciona `GET /companies` como obrigatório.

**Estado atual do serviço DAB**: `GET /companies` foi implementado com base na view `dbo.vw_companies`.

Limitações atuais:
- O schema atual do datalake expõe `cod_empresa` + `nome_empresa` de forma consistente.
- Não foi identificado um campo de **CNPJ da empresa** no banco atual (apenas CPF/CNPJ de cliente/fornecedor). Por isso `cnpj` vem como `null`.

Se o CNPJ for obrigatório para identificação, precisamos que o datalake disponibilize uma tabela/dimensão de empresa (ex.: `dim_empresa`) com `cod_empresa` → `cnpj`.

## 10) Troubleshooting rápido

- **401 Unauthorized**: header `X-API-Key` ausente ou inválido.
- **404**: caminho errado (em produção use `/v1/...`, em local use `/api/...`).
- **502/503**: IIS/proxy não conseguiu falar com o DAB (backend parado/porta errada).

## 11) Referências do repo

- Config DAB (entidades/rotas): [dab/dab-config.json](../dab/dab-config.json)
- Script de teste local (sem IIS): [scripts/test-endpoints.ps1](../scripts/test-endpoints.ps1)
- Script para rodar o DAB local: [scripts/run-local.ps1](../scripts/run-local.ps1)
