# Integração Completa — cockpit-dab + cockpit-mcp-server + GA360

> **Atualizado:** 2026-03-23
> **Autor:** William Cintra + Claude Code

## Visão Geral

Três projetos formam o ecossistema de dados do Grupo Arantes:

| Projeto | Stack | Função |
|---------|-------|--------|
| **cockpit-dab** | DAB + SQL Server + IIS | Fonte de verdade — 17 endpoints REST read-only |
| **cockpit-mcp-server** | TypeScript + Vercel | MCP Gateway unificado — 14 tools (DAB + GA360) |
| **GA360** | React + Supabase + Vercel | App principal — Cockpit, Metas, Reuniões, Verbas |

```
Claude Desktop / Chat UI
        │
        ▼
cockpit-mcp-server (Vercel)          ← MCP unificado (14 tools)
  /api/mcp  (MCP protocol)
  /api/chat (BFF tool-calling)
        │
        ├──→ DAB (IIS)               ← 9 tools: vendas, HR, produtos, estoque
        │      https://api.grupoarantes.emp.br/v1
        │
        └──→ GA360 Supabase          ← 5 tools: metas, reuniões, empresas
               PostgREST + Edge Functions

GA360 Frontend (React)
        │
        ├──→ Supabase (local)        ← KPIs agregados (~5K linhas/ano)
        │      sales_fact_daily
        │
        └──→ dab-proxy Edge Function ← Detalhe em tempo real
               │
               ▼
             DAB (IIS)
```

## Estratégia de Dados

**Princípio:** Agregar localmente (KPIs compactos), consultar detalhe em tempo real.

| Dado | Onde fica | Volume | Atualização |
|------|-----------|--------|-------------|
| KPIs diários (todas as empresas) | Supabase `sales_fact_daily` | ~5K linhas/ano | Batch 1x/dia via `cockpit-sales-sync` |
| Detalhe de pedidos (multi-tenant) | DAB `sales_product_detail` | Real-time | On-demand via `dab-proxy` |
| Detalhe Chok (checkin, não-venda) | DAB `venda_diaria_chokdist` | Real-time | On-demand via `dab-proxy` |
| Verbas/comissões | DAB `verbas-ga360` → Supabase staging | 214K/ano | Batch via `sync-verbas` |
| Funcionários | DAB `funcionarios` → Supabase | ~800 CPFs | Batch via `sync-employees` |

**Por que NÃO sincronizar dados brutos:**

- `venda_diaria_chokdist`: 60 cols × milhares de linhas/dia → dezenas de milhões/ano
- Multiplicar por 3+ distribuidoras + varejo = inviável
- `sales_fact_daily` agregado: ~5K linhas/ano (3.000x menor)

## Multi-Tenant

As views DBO do DAB são multi-tenant via `tenant_id`:

```
GET /v1/sales_daily                                  → todas as empresas
GET /v1/sales_daily?$filter=tenant_id eq '5'         → empresa específica
GET /v1/companies                                    → lista de tenant_ids
```

**Não precisa criar views GOLD por distribuidora** para KPIs básicos.
Views GOLD (como `venda_diaria_chokdist`) existem apenas para detalhe operacional específico.

## Endpoints DAB (17 entities)

### Multi-tenant (todas as empresas)

| Endpoint | View | Key Fields |
|----------|------|------------|
| `/v1/health` | `dbo.vw_health` | id |
| `/v1/companies` | `dbo.vw_companies` | code |
| `/v1/sales_daily` | `dbo.vw_sales_daily` | tenant_id, dt_ref |
| `/v1/sales_by_sku` | `dbo.vw_sales_by_sku` | tenant_id, dt_ref, id_sku |
| `/v1/sales_product_detail` | `dbo.vw_sales_product_detail_api` | id_linha |
| `/v1/venda_prod` | `dbo.vw_venda_prod` | EMPRESA, DATA_VENDA, NUMERO_PEDIDO, SKU_PRODUTO |
| `/v1/coverage_city` | `dbo.vw_coverage_city` | tenant_id, dt_ref, ds_cidade |
| `/v1/stock_position` | `dbo.vw_stock_position` | tenant_id, id_sku |
| `/v1/produtos` | `dbo.vw_produtos_api` | id_dim_prod |
| `/v1/funcionarios` | `dbo.vw_funcionarios` | id_funcionario |
| `/v1/verbas` | `dbo.vw_verbas_api` | id_verba |
| `/v1/verbas-ga360` | `dbo.vw_verbas_long_api` | id_verba_long |

### Chok-específico

| Endpoint | View | Key Fields | Notas |
|----------|------|------------|-------|
| `/v1/venda_diaria_chokdist` | `gold.vw_venda_diaria_chokdist_v2` | numero_pedido, sku | v2 otimizada, colunas calculadas |

### Filtros obrigatórios (timeout sem eles)

| Endpoint | Filtro | Exemplo |
|----------|--------|---------|
| `venda_diaria_chokdist*` | `data` | `$filter=data eq '2026-03-20'` |
| `verbas*` | `ano` | `$filter=ano eq 2026` |

## MCP Server — 14 Tools Unificados

### Fonte DAB (9 tools)

| Tool | Endpoint DAB | Filtro obrigatório |
|------|-------------|-------------------|
| `get_sales_daily` | sales_daily | — |
| `get_sales_by_sku` | sales_by_sku | — |
| `get_sales_product_detail` | sales_product_detail | — |
| `get_venda_prod` | venda_prod | — |
| `get_verbas_ga360` | verbas-ga360 | `ano` (required) |
| `get_venda_diaria_chokdist` | venda_diaria_chokdist (v2) | `data` (required) |
| `get_companies` | companies | — |
| `get_funcionarios` | funcionarios | — |

### Fonte GA360 Supabase (5 tools)

| Tool | Tabela/Função | Requer |
|------|--------------|--------|
| `ga360_get_goals` | goals | company_id |
| `ga360_get_meetings` | meetings | company_id |
| `ga360_create_goal` | INSERT goals | company_id, title, pillar, unit, target_value, cadence |
| `ga360_add_goal_progress` | INSERT goal_updates | goal_id, value |
| `ga360_get_companies` | companies | — |

### Env Vars (Vercel)

```
DAB_BASE_URL=https://api.grupoarantes.emp.br/v1
DAB_API_KEY=<chave IIS>
GA360_SUPABASE_URL=https://zveqhxaiwghexfobjaek.supabase.co
GA360_SUPABASE_KEY=<service_role key>
MCP_AUTH_TOKEN=<token para clientes MCP>
```

## GA360 Edge Functions (integração DAB)

| Edge Function | Fonte DAB | Destino Supabase | Tipo |
|--------------|-----------|-----------------|------|
| `sync-verbas` | verbas-ga360 | payroll_verba_staging → pivot | Batch |
| `sync-employees` | funcionarios | external_employees | Batch |
| `sync-companies` | companies | companies | Batch |
| `cockpit-sales-sync` | sales_daily (multi-tenant) | sales_fact_daily | Batch |
| `cockpit-vendas-sync` | venda_diaria_chokdist | cockpit_vendas_sync | Batch (Chok) |
| `cockpit-vendas-query` | chokdist ou sales_product_detail | cache | Real-time |
| `dab-proxy` | qualquer (allowlist) | sync_logs | Passthrough |

### Allowlist do dab-proxy

```
funcionarios, health, companies, venda_prod, sales_daily, sales_by_sku,
coverage_city, stock_position, produtos, stock_lots, sales_product_detail,
venda_diaria_chokdist, venda_diaria_chokdist_lite, verbas-ga360, verbas
```

## Skills Claude Code (9)

| Skill | Domínio |
|-------|---------|
| `/dev` | SQL views, DAB config, onboarding |
| `/infra` | DAB process, IIS, Windows Server |
| `/integracoes` | API externa, OData, consumidores |
| `/seguranca` | Auth, LGPD, data exposure |
| `/melhorias` | Performance, tech debt, backlog |
| `/criar-skill` | Meta-skill para gerar novas skills |
| `/ga360` | Integração GA360 (sync, query, multi-tenant) |
| `/mcp` | Cross-project DAB ↔ MCP Server |
| `/dados` | Qualidade, validação, reconciliação |

## Paginação DAB

- Operadores: `$first` (page size), `$after` (cursor)
- **NÃO** usa `$top`/`$skip`
- `nextLink` é relativo: `/api/entity?$after=TOKEN&$first=N`
- Consumer deve resolver: `new URL(nextLink, baseUrl)`
- Default: 100 linhas, max: 100.000

## Como Testar

### DAB Local

```powershell
cd C:\Github\cockpit-dab
.\scripts\run-local.ps1
curl http://localhost:5000/api/companies
curl "http://localhost:5000/api/sales_daily?`$first=5"
```

### MCP Server

```bash
cd cockpit-mcp-server
npm run dev
# BFF: POST http://localhost:3000/api/chat
# MCP: POST http://localhost:3000/api/mcp
```

### GA360 Edge Functions

```bash
supabase functions deploy cockpit-sales-sync dab-proxy cockpit-vendas-query
```

### Claude Desktop

Configurar `claude_desktop_config.json`:

```json
{
  "mcpServers": {
    "cockpit": {
      "url": "https://<vercel-url>/api/mcp",
      "headers": { "Authorization": "Bearer <MCP_AUTH_TOKEN>" }
    }
  }
}
```
