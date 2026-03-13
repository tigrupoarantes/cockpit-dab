# GA360 x DAB — Integração do endpoint `venda_diaria_chokdist`

Data: 2026-03-13
Autor: William - TI Grupo Arantes

## Objetivo

Guia operacional para o GA360 consumir o endpoint `GET /v1/venda_diaria_chokdist` (vendas da Chok Distribuidora) de forma segura, eficiente e sem travar a Edge Function ou o frontend.

---

## 1. Visão geral

| Campo | Valor |
|---|---|
| Endpoint | `GET /v1/venda_diaria_chokdist` |
| Fonte | `gold.vw_venda_diaria_chokdist` no GA_DATALAKE |
| Empresa | CHOK DISTRIBUIDORA |
| Granularidade | 1 linha = 1 item de pedido (pedido × SKU) |
| Colunas | 60 |
| Chave | `numero_pedido` + `sku` (chave composta) |

A view tem 20+ JOINs e CTEs cobrindo toda a cadeia de vendas: pedido → produto → cliente → vendedor → supervisor → gerente → checkin → NF.

**Sem filtro de data a query faz full-table scan e ultrapassa 30 segundos de timeout.** Ver seção 5.

---

## 2. Conexão

### Produção (GA360 usa esta)

```
Base URL: https://api.grupoarantes.emp.br/v1
```

### Local / Desenvolvimento (sem IIS, sem API Key)

```
Base URL: http://localhost:5000/api
```

### Headers obrigatórios

| Header | Valor | Obrigatório |
|---|---|---|
| `X-API-Key` | `<chave configurada no IIS>` | **Sim** — 401 sem ela |
| `Accept` | `application/json` | Recomendado |

> A chave deve ser armazenada como secret (Supabase Vault ou variável de ambiente da Edge Function). Nunca hardcode.

---

## 3. Parâmetros de query suportados

> **Importante:** esta instalação do DAB usa `$first` e `$after` para paginação — **NÃO** `$top` e `$skip`. Usar `$top` retorna `400 Invalid Query Parameter`.

| Parâmetro | Exemplo | Descrição |
|---|---|---|
| `$filter` | `$filter=data eq '2026-03-13'` | Filtro OData. **Obrigatório** (ver seção 5) |
| `$select` | `$select=numero_pedido,sku,data` | Projeção de colunas. **Sempre usar** (ver seção 5) |
| `$first` | `$first=500` | Tamanho da página (default: 100, max: 100 000) |
| `$after` | `$after=<TOKEN>` | Token de cursor para próxima página (vem do `nextLink`) |
| `$orderby` | `$orderby=data desc` | Ordenação |

### Formato de resposta

```json
{
  "value": [
    { "numero_pedido": 12345, "sku": 98, "data": "2026-03-13", "..." }
  ],
  "nextLink": "/api/venda_diaria_chokdist?$first=100&$after=<TOKEN>"
}
```

- `value`: registros da página atual.
- `nextLink`: presente quando há mais páginas. Quando `null` ou ausente, acabou.

---

## 4. Colunas disponíveis

A view retorna **60 colunas**. Use `$select` para trazer apenas o necessário.

### Identificação do pedido / item
| Coluna | Tipo | Nulo | Descrição |
|---|---|---|---|
| `numero_pedido` | int | NÃO | Número do pedido (parte da chave) |
| `sku` | int | NÃO | Código do produto (parte da chave) |
| `tipo_pedido` | varchar | sim | Tipo do pedido |
| `situacao_pedido` | varchar | sim | Situação atual do pedido |
| `nota_fiscal` | int | sim | NF emitida |
| `origem_pedido` | varchar | sim | Canal de origem |

### Data / Tempo
| Coluna | Tipo | Nulo | Descrição |
|---|---|---|---|
| `data` | date | NÃO | Data do pedido — **filtrar sempre por este campo** |
| `ano` | smallint | NÃO | Ano |
| `nome_mes` | varchar | NÃO | Nome do mês em PT-BR |
| `hora_cadastro` | time | sim | Hora de cadastro do pedido |
| `data_liberacao_pedido` | date | sim | Data de separação/liberação |
| `hora_liberacao_pedido` | time | sim | Hora de liberação |
| `data_entrega` | date | sim | Data de entrega |
| `hora_entrega` | time | sim | Hora de entrega |

### Produto
| Coluna | Tipo | Nulo | Descrição |
|---|---|---|---|
| `descricao_produto` | varchar | NÃO | Nome do produto |
| `ean` | varchar | sim | Código EAN |
| `categoria` | varchar | sim | Categoria |
| `familia` | varchar | sim | Família / linha |
| `grupo` | varchar | sim | Grupo / seção |
| `fabricante` | varchar | sim | Fabricante |
| `peso_liq_unid` | decimal(14,3) | sim | Peso líquido por unidade |
| `codigo_promocao` | int | sim | Código da promoção |
| `descricao_promocao` | varchar | sim | Descrição da promoção |
| `unidade_venda` | varchar | sim | Unidade (UN, CX, etc.) |

### Quantidades e Valores
| Coluna | Tipo | Nulo | Descrição |
|---|---|---|---|
| `fator_pedido` | float | sim | Fator de estoque/venda |
| `qtde_vendida` | int | sim | Quantidade vendida |
| `custo_unitario_prod` | decimal(14,4) | sim | Custo unitário |
| `preco_unitario_prod` | decimal(14,4) | sim | Preço unitário praticado |
| `preco_tabela_cadastro` | decimal(14,4) | sim | Preço de tabela |
| `desconto_aplicado_prod` | decimal(14,2) | sim | Desconto = tabela − praticado |

### Cliente
| Coluna | Tipo | Nulo | Descrição |
|---|---|---|---|
| `cod_cliente` | int | sim | Código do cliente |
| `razao_social` | varchar | sim | Razão social |
| `cnpj_cpf` | varchar | sim | CNPJ/CPF |
| `grupo_cliente` | varchar | sim | Grupo/rede do cliente |
| `segmento` | varchar | sim | Ramo de atividade |
| `endereco` | varchar | sim | Endereço |
| `bairro` | varchar | sim | Bairro |
| `municipio` | varchar | sim | Município |
| `cep` | int | sim | CEP |
| `estado` | char | sim | UF |
| `cod_pais` | char | sim | Código do país |
| `email` | varchar | sim | E-mail |
| `latitude` | numeric | sim | Latitude |
| `longitude` | numeric | sim | Longitude |
| `prazo_venda_cliente` | numeric | sim | Prazo médio na venda |
| `prazo_cadastro_cliente` | smallint | sim | Prazo médio no cadastro |

### Equipe comercial
| Coluna | Tipo | Nulo | Descrição |
|---|---|---|---|
| `cod_vendedor` | varchar | NÃO | Código do vendedor (usar para filtro de escopo) |
| `nome_vendedor` | varchar | sim | Nome de guerra do vendedor |
| `cod_supervisor` | varchar | sim | Código do supervisor |
| `nome_supervisor` | varchar | sim | Nome do supervisor |
| `nome_da_equipe` | varchar | sim | Nome da equipe |
| `cod_gerente` | varchar | sim | Código do gerente |
| `nome_gerente` | varchar | sim | Nome do gerente |
| `nome_gerencia` | varchar | sim | Nome da gerência |

### Checkin / Ação não-venda
| Coluna | Tipo | Nulo | Descrição |
|---|---|---|---|
| `hora_inicio_checkin` | time | sim | Hora de início do checkin |
| `hora_fim_checkout` | time | sim | Hora de fim do checkout |
| `duracao_checkin_minutos` | int | sim | Duração do checkin em minutos |
| `acao_nao_venda` | varchar | sim | Descrição da ação em não-venda |
| `motivo_nao_venda` | varchar | sim | Motivo da não-venda |

### Identificação da empresa
| Coluna | Tipo | Nulo | Descrição |
|---|---|---|---|
| `empresa` | varchar | NÃO | Sempre `'CHOK DISTRIBUIDORA'` |

---

## 5. Regras obrigatórias — como NÃO travar

> Esta é a seção mais importante. Ignorar estas regras causa timeouts > 30s e pode derrubar a Edge Function.

### Regra 1 — SEMPRE filtrar por `data`

A view faz full-table scan quando chamada sem filtro. **Toda chamada deve incluir `$filter=data eq 'YYYY-MM-DD'` ou um intervalo de datas.**

```
✅ /v1/venda_diaria_chokdist?$filter=data eq '2026-03-13'&$first=500
❌ /v1/venda_diaria_chokdist                          ← full scan, timeout
❌ /v1/venda_diaria_chokdist?$first=10               ← ainda full scan
```

### Regra 2 — SEMPRE usar `$select`

A view tem **60 colunas**. Trazer tudo aumenta payload e latência desnecessariamente.

```
✅ $select=numero_pedido,sku,data,razao_social,qtde_vendida,preco_unitario_prod
❌ (sem $select) ← retorna 60 colunas, payload ~10x maior
```

### Regra 3 — Usar `$first` (não `$top`)

```
✅ $first=500
❌ $top=500   ← retorna 400 Invalid Query Parameter nesta instalação
```

### Regra 4 — Para KPIs do dia: `$first=1000` cobre sem paginar

Para um único dia de vendas, 1000 linhas geralmente cobre todos os itens. Valide em homologação.

### Regra 5 — Para KPIs do mês: seguir `nextLink`

Consultas de período longo retornam múltiplas páginas. Sempre iterar o `nextLink` até ser nulo.

---

## 6. Filtros prontos por caso de uso

```
# Por dia específico
$filter=data eq '2026-03-13'

# Por período
$filter=data ge '2026-03-01' and data le '2026-03-13'

# Dia + vendedor
$filter=data eq '2026-03-13' and cod_vendedor eq 'V001'

# Dia + supervisor (todos os vendedores da equipe)
$filter=data eq '2026-03-13' and cod_supervisor eq 'S01'

# Dia + gerente
$filter=data eq '2026-03-13' and cod_gerente eq 'G01'

# Produto específico no dia
$filter=data eq '2026-03-13' and sku eq 98
```

---

## 7. Exemplos de chamadas por caso de uso

### 7.1 KPIs de faturamento do dia (Edge Function)

Colunas mínimas para calcular faturamento, pedidos e ticket médio:

```
GET /v1/venda_diaria_chokdist
  ?$filter=data eq '2026-03-13' and cod_vendedor eq 'V001'
  &$select=numero_pedido,sku,qtde_vendida,preco_unitario_prod,desconto_aplicado_prod
  &$first=1000
  &X-API-Key: <CHAVE>
```

Agregação na Edge Function (TypeScript):

```typescript
const items = response.value;

const faturamento = items.reduce(
  (sum, i) => sum + i.qtde_vendida * i.preco_unitario_prod, 0
);
const totalPedidos = new Set(items.map(i => i.numero_pedido)).size;
const ticketMedio = totalPedidos > 0 ? faturamento / totalPedidos : 0;
```

### 7.2 Ranking de produtos do mês (com paginação)

```typescript
const BASE_URL = 'https://api.grupoarantes.emp.br/v1';
const API_KEY  = Deno.env.get('DAB_API_KEY')!;

async function fetchVendasMes(mes: string, codVendedor: string) {
  const filter  = `data ge '${mes}-01' and data le '${mes}-31' and cod_vendedor eq '${codVendedor}'`;
  const select  = 'numero_pedido,sku,descricao_produto,qtde_vendida,preco_unitario_prod';
  let   url     = `${BASE_URL}/venda_diaria_chokdist?$filter=${encodeURIComponent(filter)}&$select=${select}&$first=500`;

  const all: any[] = [];

  while (url) {
    const res  = await fetch(url, { headers: { 'X-API-Key': API_KEY } });

    if (!res.ok) throw new Error(`DAB error ${res.status}: ${await res.text()}`);

    const json = await res.json();
    all.push(...(json.value ?? []));

    // nextLink é relativo (/api/...) — montar URL absoluta
    url = json.nextLink
      ? `https://api.grupoarantes.emp.br${json.nextLink.replace('/api/', '/v1/')}`
      : null;
  }

  return all;
}
```

> **Atenção ao `nextLink`:** o DAB retorna o link com prefixo `/api/` (caminho interno). Na chamada pelo IIS, o prefixo é `/v1/`. A Edge Function deve converter `/api/` → `/v1/` antes de seguir o link.

### 7.3 Listagem paginada para tabela no frontend (page-by-page)

```typescript
// Página 1
const page1 = await fetch(
  `${BASE_URL}/venda_diaria_chokdist?$filter=data eq '2026-03-13'` +
  `&$select=numero_pedido,sku,razao_social,descricao_produto,qtde_vendida,preco_unitario_prod` +
  `&$first=50`,
  { headers: { 'X-API-Key': API_KEY } }
).then(r => r.json());

const registros  = page1.value;         // até 50 itens
const proximaPag = page1.nextLink;      // null se não houver mais

// Página 2 (se o usuário clicar em "próxima")
if (proximaPag) {
  const absUrl = `https://api.grupoarantes.emp.br${proximaPag.replace('/api/', '/v1/')}`;
  const page2  = await fetch(absUrl, { headers: { 'X-API-Key': API_KEY } }).then(r => r.json());
}
```

---

## 8. Responsabilidade de escopo

**O DAB não aplica controle de acesso por usuário.** O endpoint devolve todos os registros que passam no `$filter`. A Edge Function é responsável por:

1. Validar o JWT do usuário logado no GA360.
2. Determinar o `cod_vendedor`, `cod_supervisor` ou `cod_gerente` associado ao usuário.
3. Montar o `$filter` com o escopo correto antes de chamar o DAB.

```typescript
// Exemplo: vendedor só vê as próprias vendas
const { cod_vendedor } = await getUserScope(jwt);
const filter = `data eq '${hoje}' and cod_vendedor eq '${cod_vendedor}'`;
```

---

## 9. Tratamento de erros

| Status | Mensagem | Causa | Ação |
|---|---|---|---|
| `200` | — | Sucesso | Processar `value[]`, verificar `nextLink` |
| `400` | `Invalid Query Parameter: $top` | Usando `$top` em vez de `$first` | Trocar para `$first=N` |
| `400` | Qualquer outro | Filtro/coluna inválida | Verificar nomes de colunas (case-sensitive) |
| `401` | `Unauthorized` | `X-API-Key` ausente ou inválida | Verificar header e chave no vault |
| `404` | `Entity not found` | Nome de entidade errado na URL | Verificar endpoint `/venda_diaria_chokdist` |
| `502` / `503` | — | DAB indisponível | Retry com backoff exponencial (ver abaixo) |

### Padrão de retry recomendado

```typescript
async function fetchComRetry(url: string, headers: Record<string, string>, maxTentativas = 3) {
  for (let i = 0; i < maxTentativas; i++) {
    const res = await fetch(url, { headers });
    if (res.ok)  return res.json();
    if (res.status < 500) throw new Error(`Erro ${res.status}: ${await res.text()}`); // não retry em 4xx
    if (i < maxTentativas - 1) await new Promise(r => setTimeout(r, 1000 * 2 ** i)); // 1s, 2s, 4s
  }
  throw new Error('DAB indisponível após 3 tentativas');
}
```

---

## 10. Seleções prontas por módulo do Cockpit

### KPIs do Cockpit de Vendas (mínimo)
```
$select=numero_pedido,sku,data,cod_vendedor,qtde_vendida,preco_unitario_prod,desconto_aplicado_prod
```

### Card de cliente
```
$select=cod_cliente,razao_social,cnpj_cpf,grupo_cliente,segmento,municipio,estado
```

### Detalhe de produto
```
$select=sku,descricao_produto,categoria,familia,grupo,fabricante,qtde_vendida,preco_unitario_prod,preco_tabela_cadastro,desconto_aplicado_prod
```

### Hierarquia comercial
```
$select=cod_vendedor,nome_vendedor,cod_supervisor,nome_supervisor,nome_da_equipe,cod_gerente,nome_gerente
```

---

## 11. Checklist de homologação

Antes de liberar para produção, validar todos os itens:

- [ ] `GET /v1/health` retorna `200` com `X-API-Key`
- [ ] `GET /v1/venda_diaria_chokdist?$filter=data eq '<hoje>'&$select=numero_pedido,sku,data&$first=5` retorna `200` com dados
- [ ] Sem `X-API-Key` retorna `401`
- [ ] Chamada com `$top=5` retorna `400` (esperado — usar `$first`)
- [ ] Chamada SEM `$filter` é bloqueada pela Edge Function (não deve chegar ao DAB)
- [ ] `nextLink` é seguido corretamente com `/api/` → `/v1/` na conversão
- [ ] Edge Function aplica o filtro de escopo correto pelo JWT do usuário
- [ ] Resposta com dados do vendedor correto (sem vazamento de escopo)
- [ ] Timeout da Edge Function configurado para pelo menos **20 segundos**

---

## 12. Referências

| Recurso | Localização |
|---|---|
| Contrato geral da API (base URL, auth, paginação) | [docs/SERVICE_API.md](SERVICE_API.md) |
| Definição SQL da view | [sql/views/vw_venda_diaria_chokdist.sql](../sql/views/vw_venda_diaria_chokdist.sql) |
| Config do DAB (todas as entidades) | [dab/dab-config.json](../dab/dab-config.json) |
| Doc de integração verbas (padrão similar) | [docs/GA360_VERBAS_DAB_INTEGRACAO.md](GA360_VERBAS_DAB_INTEGRACAO.md) |
| PRD de onboarding desta view | `PRD_DAB_Onboarding_Cockpit.docx` (raiz do repo) |
