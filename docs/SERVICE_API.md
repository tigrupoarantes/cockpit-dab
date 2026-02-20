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

Nota (Cockpit GA): algumas telas de configuração/teste **anexam automaticamente** caminhos como `/health`, e em alguns casos também um prefixo (ex.: `/v1`). Se o “Testar Conexão” estiver retornando **404**, valide no DevTools/Network qual URL exata ele chamou e ajuste o `api_base_url` para evitar duplicação (ex.: `/v1/v1/health` ou `/v1/api/health`).

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

## 4.1) Como testar a API “por aqui” (sem travar no X-API-Key)

Existem **dois jeitos** de testar, dependendo se você quer passar pelo IIS (produção) ou falar direto com o DAB (local).

### Opção A — Teste local (recomendado para debug rápido)

No servidor/PC onde o DAB está rodando, use a base local **sem IIS** (normalmente não exige `X-API-Key`):

- Base: `http://localhost:5000/api`

Exemplos:

```powershell
Invoke-RestMethod -Uri "http://localhost:5000/api/health" -TimeoutSec 15
Invoke-RestMethod -Uri "http://localhost:5000/api/companies" -TimeoutSec 15
```

Script pronto:

```powershell
cd C:\Github\cockpit-dab
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\test-endpoints.ps1 \
  -BaseUrl http://localhost:5000/api
```

### Opção B — Teste via IIS (produção / mesma rota que o app usa)

Quando você testa via IIS (`/v1`), **o IIS exige `X-API-Key`**.

- Base: `https://api.grupoarantes.emp.br/v1`

Exemplos:

```powershell
$base = "https://api.grupoarantes.emp.br/v1"
$headers = @{ "X-API-Key" = "<SUA_CHAVE>"; "Accept" = "application/json" }
Invoke-RestMethod -Uri "$base/health" -Headers $headers -TimeoutSec 15
Invoke-RestMethod -Uri "$base/companies" -Headers $headers -TimeoutSec 15
```

Ou usando o script (sem hardcode — passe a chave por parâmetro ou por variável de ambiente):

```powershell
cd C:\Github\cockpit-dab
$env:DAB_API_KEY = "<SUA_CHAVE>"
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\test-endpoints.ps1 \
  -BaseUrl https://api.grupoarantes.emp.br/v1 \
  -ApiKey $env:DAB_API_KEY
```

### Por que não testar “dentro do index.html” com a chave?

Porque a página `iis/status/index.html` é **estática**. Se você colocar a `X-API-Key` ali, ela fica exposta para qualquer pessoa que consiga abrir o `/status`.

Se você precisa ver “como vem a leitura” no navegador:

- Prefira testar endpoints locais (`http://localhost:5000/api/...`) via PowerShell/curl.
- Ou use DevTools → Network e “Copy as cURL” para reproduzir a chamada com headers (sem persistir a chave em arquivo).

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
- `sales_daily` e `sales_by_sku`: retornam dados.

### Cobertura
- `GET /coverage_city`

Status atual:
- `coverage_city`: retorna dados.

### Estoque
- `GET /stock_position`

Status atual:
- `stock_position`: retorna dados.

### Produtos
- `GET /produtos`

Status atual:
- `produtos`: retorna dados (entidade `produtos` no DAB aponta para a view `dbo.vw_produtos_api`).

### Funcionários
- `GET /funcionarios`

Status atual:
- `funcionarios`: retorna dados (entidade `funcionarios` no DAB aponta para a view `dbo.vw_funcionarios`, derivada de `gold.vw_funcionario`).

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
- `produtos`: retorna dados.

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

Observação:
- Nesta instalação, o DAB está configurado com `next-link-relative=true`. Ou seja, quando vier `nextLink`, ele tende a ser **relativo** (ex.: `/api/produtos?...`).

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

## 10.0) Monitoramento (Painel de Status)

Existe um painel simples para verificar se o DAB está rodando e se os health-checks estão respondendo.

- **No próprio servidor IIS (recomendado):** `http://localhost/status/`
- **Pela rede (IP do servidor):** `http://192.168.1.39/status/`

Observação: o hostname público `https://api.grupoarantes.emp.br/` tem uma regra de `X-API-Key` no IIS. Por isso, acessar `https://api.grupoarantes.emp.br/status/` pode retornar **401** (isso é esperado). Para uso interno, prefira `http://localhost/status/` ou `http://<IP>/status/`.

### Watchdog (não deixar o DAB parar após reboot)

Para manter o DAB ativo após reinício do servidor, instale:

```powershell
cd C:\Github\cockpit-dab
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\install-status-page.ps1
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\install-watchdog-task.ps1
```

Isso cria a Scheduled Task `Cockpit-DAB-Watchdog` (executa como `SYSTEM`) e mantém um loop de monitoramento, atualizando `status.json` a cada ~30s e (re)iniciando o DAB caso necessário.

### Como expor uma nova view no DAB

Quando o DBA criar uma nova view no datalake, ela vai aparecer no painel em **“Views novas (no SQL, fora do DAB)”**.

Para expor a view via DAB, use o script:

```powershell
cd C:\Github\cockpit-dab
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\onboard-dab-view.ps1 \
  -ViewName vw_sales_product_detail \
  -EntityName sales_product_detail \
  -KeyFields tenant_id,dt_ref,id_sku \
  -RestartDab
```

Importante: `KeyFields` precisa ser um conjunto de colunas que exista na view e identifique uma linha de forma única (senão o DAB pode falhar ao iniciar).

Checklist rápido para erro **404** no Cockpit:
- Abra DevTools → Network e copie a URL chamada ao clicar em “Testar Conexão”.
- Se aparecer `/v1/v1/...`, remova o sufixo `/v1` do `api_base_url`.
- Se aparecer `/v1/api/...`, use `api_base_url=https://api.grupoarantes.emp.br` (sem `/v1`).

## 10.1) Compatibilidade de rotas (IIS)

Se o Cockpit (ou alguma Edge Function) estiver chamando caminhos diferentes do padrão (`/v1/<entidade>`), você pode tornar o IIS mais permissivo adicionando aliases.

Casos comuns que geram **404**:
- Chamando apenas a base `.../v1` (sem `/health`)
- Chamando `.../health` (root)
- Chamando `.../api/health` (path interno do DAB)

Exemplo de regras adicionais (URL Rewrite) para aceitar esse formatos e encaminhar para o DAB:

```xml
<!-- Redireciona /v1 (sem rota) para /v1/health -->
<rule name="v1-root-to-health" stopProcessing="true">
  <match url="^v1/?$" />
  <action type="Redirect" url="/v1/health" redirectType="Temporary" />
</rule>

<!-- Aceita /health direto -->
<rule name="health-root-alias" stopProcessing="true">
  <match url="^health$" />
  <action type="Rewrite" url="http://localhost:5000/api/health" appendQueryString="true" />
</rule>

<!-- Aceita /companies direto -->
<rule name="companies-root-alias" stopProcessing="true">
  <match url="^companies$" />
  <action type="Rewrite" url="http://localhost:5000/api/companies" appendQueryString="true" />
</rule>

<!-- Aceita /api/* público (pass-through) -->
<rule name="api-pass-through" stopProcessing="true">
  <match url="^api/(.*)$" />
  <action type="Rewrite" url="http://localhost:5000/api/{R:1}" appendQueryString="true" />
</rule>
```

Observação: mantenha a validação do `X-API-Key` aplicada também a essas rotas (mesma regra/condição de segurança que vocês já usam no IIS).

## 11) Referências do repo

- Config DAB (entidades/rotas): [dab/dab-config.json](../dab/dab-config.json)
- Script de teste local (sem IIS): [scripts/test-endpoints.ps1](../scripts/test-endpoints.ps1)
- Script para rodar o DAB local: [scripts/run-local.ps1](../scripts/run-local.ps1)
