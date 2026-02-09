# Convenções (Cockpit GA DAB)

Este documento define padrões para manter previsibilidade, performance e governança na ponte DAB → SQL Server.

## 1) Princípios

- API é **read-only**.
- A API expõe **apenas views** (camada semântica), nunca tabelas brutas.
- Views são o **contrato estável** com o app.
- Preferir **pré-agregação / pré-join** em view quando isso reduzir custo por request.

## 2) Naming

### 2.1 Views

- Prefixo obrigatório: `vw_`
- Formato: `vw_<dominio>_<descricao>`
- Exemplos:
  - `vw_sales_daily`
  - `vw_sales_by_sku`
  - `vw_customers_coverage_city`

### 2.2 Colunas

Padrões de prefixo:

- Datas: `dt_*`
- Valores monetários/decimais relevantes: `vl_*`
- Quantidades: `qt_*`
- Chaves (IDs): `id_*`

Evitar abreviações ambíguas. Preferir nomes autoexplicativos e consistentes entre views.

### 2.3 Tenant

- Padronizar coluna: `tenant_id`
- Mesmo que a origem use `cd_empresa`, `empresa_id`, etc., a view exposta deve projetar para `tenant_id`.

## 3) Regras de exposição

- Não publicar views “genéricas” que permitam acesso amplo (ex.: dump de fato sem filtros).
- A entidade DAB deve apontar para **view específica**.
- Cada view exposta deve ter um propósito de negócio claro (KPI/relatório/painel).

## 4) Filtros padrão (MVP)

### 4.1 Multi-tenant

- Se a view é multi-tenant, `tenant_id` deve existir e deve ser filtrável.
- Idealmente o app sempre envia `tenant_id`.

### 4.2 Período

- Se o dataset é temporal, a view deve ter (ou derivar) um campo de data para filtro.
- Preferir:
  - `dt_ref` (data de referência)
  - ou `dt_venda`, `dt_competencia`, conforme domínio

Recomendação: impor limites (ex.: 90 dias) por convenção do app ou por view (quando fizer sentido).

### 4.3 Paginação

- Endpoints de lista devem ser paginados.
- Evitar retornar “dados infinitos” sem período.

## 5) Padrão de SQL para views

- Usar `CREATE OR ALTER VIEW`.
- Evitar `SELECT *`.
- Sempre qualificar schemas (ex.: `dbo.tabela`).
- Preferir conversões explícitas quando necessário (ex.: `CAST`/`CONVERT`).
- Se houver agregação, garantir chaves e granularidade claramente definidas.

## 6) Performance

- Evitar funções escalares em colunas de filtro (quebram uso de índice).
- Preferir filtros sargáveis (ex.: `dt_venda >= @ini AND dt_venda < @fim`).
- Pré-joins e pré-agregações devem ser controladas por domínio.

## 7) Segurança

- Usuário SQL da API deve ter **somente SELECT** nas views expostas.
- Nenhuma credencial em arquivo versionado.
- Preferir variáveis de ambiente/.env local (ignorado pelo git).

## 8) Contratos e versionamento

- Mudanças breaking em view devem ser tratadas como mudança de contrato.
- Preferir adicionar coluna (backward-compatible) a renomear/remover.
