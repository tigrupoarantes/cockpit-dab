# Especificação técnica — Cockpit App ↔ Supabase Edge Function (DAB Proxy) ↔ DAB (IIS)

Objetivo: especificar, de forma determinística, como o app do Cockpit deve consumir a API do Data API Builder (DAB) **via** uma Edge Function (server-to-server), evitando expor `X-API-Key` no cliente e mantendo uma allowlist de rotas.

Este documento é intencionalmente "IA falando com IA": descreve invariantes, contrato de entrada/saída, e um algoritmo de construção de URL/paginação que não depende de suposições implícitas.

## 1) Visão geral da arquitetura

Fluxo (produção):

1) App do Cockpit chama a Edge Function `dab-proxy` (Supabase) com `POST`.
2) Edge Function valida o usuário (JWT do Supabase).
3) Edge Function lê a configuração ativa na tabela `api_connections`.
4) Edge Function faz `GET` para a API do DAB publicada no IIS.
5) Edge Function retorna o JSON do DAB **sem remodelar** (pass-through controlado).

Pontos críticos:
- O IIS valida `X-API-Key` na borda. O DAB está com role `anonymous` para `read` (controle no IIS).
- O DAB REST base normalmente é `/api` no backend local (`http://localhost:5000/api`). Em produção, o IIS publica como `/v1` (`https://api.grupoarantes.emp.br/v1`).

## 2) Endpoints válidos (entidades do DAB)

Base path do DAB:
- Produção (via IIS): `https://api.grupoarantes.emp.br/v1`
- Local (sem IIS): `http://localhost:5000/api`

Entidades REST esperadas (paths):
- `health`
- `companies`
- `venda_prod`
- `sales_daily`
- `sales_by_sku`
- `coverage_city`
- `stock_position`
- `produtos`
- `sales_product_detail`

Observação importante (origem do erro 404 que vocês viram):
- `vw_produtos_api` é o nome de uma **view** no SQL Server, mas não é (e não deve ser) o nome do endpoint.
- O endpoint correto é `produtos`.
- No DAB desta stack, a entity `produtos` aponta para `dbo.vw_produtos_api`.

## 3) Contrato HTTP da Edge Function

### 3.1 Método
- `POST` obrigatório.
- `OPTIONS` deve responder CORS preflight.

### 3.2 Headers do request
Obrigatório:
- `Authorization: Bearer <jwt_do_usuario_supabase>`
- `Content-Type: application/json`

CORS:
- O preflight precisa incluir `Access-Control-Allow-Methods: POST, OPTIONS`.

### 3.3 Body (entrada)

Formato:

```json
{
  "path": "produtos",
  "query": { "$first": 10 },
  "nextLink": null
}
```

Campos:
- `path` (string): nome lógico da entidade (ex.: `produtos`).
- `query` (obj opcional): mapa de query params para a primeira página. Valores aceitos: string/number.
- `nextLink` (string opcional): cursor/URL da próxima página (ver seção 5).

Regras:
- Ou você envia `path` (primeira página), ou você envia `nextLink` (paginação). Se `nextLink` existir, `path` pode ser ignorado.

### 3.4 Resposta (saída)
- Status `200` com o JSON retornado pelo DAB.
- Em erro, retornar JSON com `{ error, detail?, status? }` e status HTTP coerente.

## 4) Tabela `api_connections` (fonte de credenciais)

A Edge Function lê 1 registro ativo (`is_active=true`) e usa os campos abaixo:

Campos mínimos:
- `api_base_url`: ex.: `https://api.grupoarantes.emp.br/v1`
- `auth_type`: `api_key` (padrão desta stack)
- `auth_header`: `X-API-Key`
- `api_key`: valor do segredo
- `extra_headers` (opcional): JSON com headers adicionais

Regras:
- `api_base_url` deve ser normalizado removendo barras finais (`/`).
- Nunca logar `api_key`.

## 5) Paginação do DAB (nextLink relativo)

O DAB nesta stack está configurado com `next-link-relative=true`.

Isso implica:
- `nextLink` tende a vir como **relativo**, por exemplo:
  - `/api/produtos?$after=...&$first=...`
  - (ou, dependendo de versão/config, pode vir com outra forma; o ponto é: não presuma absoluto)

### 5.1 Regra de ouro
Ao paginar, a Edge Function deve aceitar `nextLink` em 3 formatos:

1) Absoluto (`https://...`)
2) Relativo com `/` (`/v1/produtos?...` ou `/api/produtos?...`)
3) Relativo sem `/` (`produtos?...`)

### 5.2 Algoritmo de resolução de URL
Dados:
- `baseUrl`: o `api_base_url` da conexão ativa
- `nextLink`: o `nextLink` recebido do DAB

Construa `targetUrl` assim:

- Se `nextLink` começa com `http://` ou `https://`: use como está.
- Senão, faça `targetUrl = baseUrl + '/' + nextLink` com normalização:
  - remover barras duplicadas
  - garantir exatamente 1 `/` entre base e path

Exemplo robusto:
- `baseUrl=https://api.grupoarantes.emp.br/v1`
- `nextLink=/v1/produtos?$after=...`

Neste caso, você deve detectar que o `nextLink` já inclui o prefixo `/v1` e evitar duplicar. Estratégia simples:
- Se `nextLink` já começa com `/v1/`, então use `https://api.grupoarantes.emp.br` como host base.
- Se `nextLink` já começa com `/api/`, então use `http://localhost:5000` como host base (para ambiente local).

Na prática (produção), a forma mais segura é: **persistir no app o host base** (ex.: `https://api.grupoarantes.emp.br`) e também o path base (`/v1`). Se não for possível, no mínimo, trate `nextLink` relativo como relativo ao mesmo host de `api_base_url`.

## 6) Allowlist de paths (segurança)

A Edge Function deve bloquear qualquer `path` fora da allowlist.

Allowlist recomendada (alinhada ao DAB config atual):
- `health`
- `companies`
- `venda_prod`
- `sales_daily`
- `sales_by_sku`
- `coverage_city`
- `stock_position`
- `produtos`
- `sales_product_detail`

Importante:
- Remover `vw_produtos_api` da allowlist (não é entidade).
- Remover `stock_lots` da allowlist se não existir entity no DAB (evita 404 e confusão).

## 7) Construção de headers para chamar o DAB

O DAB (via IIS) exige `X-API-Key`.

Headers mínimos para o `fetch`:
- `Accept: application/json`
- `X-API-Key: <segredo>`

Regras:
- Se `auth_type=api_key`: usar `auth_header` (default `X-API-Key`).
- Se `extra_headers` existir, mesclar (sem sobrescrever a chave de auth).

## 8) Troubleshooting determinístico (o que cada status significa)

- `404 EntityNotFound` com mensagem `Invalid Entity path: <x>`
  - Causa: `path` não existe no DAB config.
  - Ação: corrigir o `path` no app (ex.: usar `produtos`) ou adicionar entity no DAB.

- `401` vindo do IIS
  - Causa: `X-API-Key` ausente/inválido.
  - Ação: revisar `api_connections` (auth_type/header/key).

- `502/504` na Edge Function
  - Causa: DAB indisponível, DNS, timeout, proxy.
  - Ação: verificar `https://api.grupoarantes.emp.br/v1/health` com header `X-API-Key`.

- “não retorna nada” no browser
  - Causa comum: CORS preflight falhando.
  - Ação: garantir `Access-Control-Allow-Methods: POST, OPTIONS` no `OPTIONS`.

## 9) Exemplos de payloads (para testes automatizados)

### 9.1 Produtos (primeira página)
Request:

```json
{ "path": "produtos", "query": { "$first": 10 } }
```

### 9.2 Estoque (posição)
Request:

```json
{ "path": "stock_position", "query": { "$first": 10 } }
```

### 9.3 Paginação
Request (repassar `nextLink` recebido do DAB):

```json
{ "nextLink": "/v1/produtos?$after=...&$first=10" }
```

## 10) Fonte de verdade no repo

- Config DAB (entidades/rotas): `dab/dab-config.json`
- Contrato da API e exemplos: `docs/SERVICE_API.md`
- Sanity test local: `scripts/test-endpoints.ps1`
