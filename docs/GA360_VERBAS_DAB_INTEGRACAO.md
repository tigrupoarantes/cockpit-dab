# GA360 x DAB — Integração do endpoint `verbas`

## Objetivo

Documentar, de forma operacional, como o GA360 deve consultar o endpoint `verbas` no Data API Builder (DAB), evitando o erro:

`Support for url template with implicit primary key field names is not yet added.`

---

## Diagnóstico consolidado

### Serviços

- DAB local: online (`/api/health` retornando 200)
- IIS público: online e protegido por `X-API-Key`
- Endpoint público `/v1/health`:
  - sem chave: 401 (esperado)
  - com chave: 200

### Causa raiz do erro no GA360

O cliente está chamando rota de item no formato **chave implícita**:

- `GET /v1/verbas/{valor}`

No DAB em uso, esse formato não é suportado para esse endpoint e retorna 400 com a mensagem de `implicit primary key`.

---

## Contrato da API `verbas`

## Base URLs

- Externa (produção): `https://api.grupoarantes.emp.br/v1`
- Interna (upstream DAB): `http://localhost:5000/api`

## Autenticação

Obrigatória no endpoint público:

- Header: `X-API-Key: <sua-chave>`
- Recomendado também enviar: `Accept: application/json`

## Entidade

- Nome REST: `verbas`
- Fonte no DAB: `dbo.vw_verbas_api`
- Chave configurada: `id_verba`

---

## Formatos de URL suportados e não suportados

### ✅ Suportado (coleção)

- `GET /v1/verbas`
- `GET /v1/verbas?$first=100`

### ✅ Suportado (item com chave explícita)

- `GET /v1/verbas/id_verba/{id_verba}`

Exemplo real validado:

- `GET /api/verbas/id_verba/0002FF3CC7F9BDB7CFEB4B3E6AC52C027616DB9957B650E801BDFD2330772DC2`

### ❌ Não suportado (gera erro 400)

- `GET /v1/verbas/{id}`

Erro esperado:

```json
{
  "error": {
    "code": "BadRequest",
    "message": "Support for url template with implicit primary key field names is not yet added.",
    "status": 400
  }
}
```

---

## Paginação

Configuração atual do DAB:

- `default-page-size`: 100
- `max-page-size`: 100000

### Recomendação de consumo

1. Começar com `?$first=<pageSize>`
2. Ler `value`
3. Se vier `nextLink`, seguir até finalizar

---

## Campos principais retornados por `verbas`

Campos observados na resposta:

- `id_verba` (chave técnica para rota de item)
- `razao_social`
- `cpf`
- `nome_funcionario`
- `tipo_verba`
- `ano`
- colunas mensais (ex.: `Janeiro`, `Fevereiro`, `Marco`, `Abril`, ...)

> Observação: usar `id_verba` apenas como identificador técnico de API. Não inferir regra de negócio a partir do hash.

---

## Exemplos prontos de chamada

## 1) Health público

```bash
curl -i "https://api.grupoarantes.emp.br/v1/health" \
  -H "X-API-Key: <API_KEY>" \
  -H "Accept: application/json"
```

## 2) Listar verbas paginado

```bash
curl -i "https://api.grupoarantes.emp.br/v1/verbas?$first=200" \
  -H "X-API-Key: <API_KEY>" \
  -H "Accept: application/json"
```

## 3) Buscar item por chave explícita

```bash
curl -i "https://api.grupoarantes.emp.br/v1/verbas/id_verba/<ID_VERBA>" \
  -H "X-API-Key: <API_KEY>" \
  -H "Accept: application/json"
```

---

## Implementação recomendada no GA360 (`sync-verbas`)

## Estratégia de rota

### Fluxo para sincronização (coleção)

1. Tentar `GET /v1/verbas?$first=<N>`
2. Se 200, processar `value` e seguir `nextLink`
3. Se 401, tratar autenticação/chave
4. Se 5xx, aplicar retry exponencial

### Fluxo para detalhe (quando necessário)

- **Não usar** `/v1/verbas/{id}`
- Usar exclusivamente `/v1/verbas/id_verba/{id_verba}`

## Pseudocódigo resiliente

```ts
async function syncVerbas(baseUrl: string, apiKey: string, first = 500) {
  const headers = {
    'X-API-Key': apiKey,
    'Accept': 'application/json'
  };

  let url = `${baseUrl}/verbas?$first=${first}`;

  while (url) {
    const res = await fetch(url, { headers });

    if (res.status === 401) {
      throw new Error('DAB Unauthorized: valide X-API-Key');
    }

    if (res.status >= 500) {
      throw new Error(`DAB ${res.status}: falha transitória`);
    }

    if (!res.ok) {
      const body = await res.text();
      throw new Error(`DAB ${res.status}: ${body}`);
    }

    const payload = await res.json();
    const rows = payload.value ?? [];

    // persistir rows no GA360
    await persist(rows);

    url = payload.nextLink ? new URL(payload.nextLink, baseUrl).toString() : '';
  }
}

async function getVerbaById(baseUrl: string, apiKey: string, idVerba: string) {
  const url = `${baseUrl}/verbas/id_verba/${encodeURIComponent(idVerba)}`;
  const res = await fetch(url, {
    headers: {
      'X-API-Key': apiKey,
      'Accept': 'application/json'
    }
  });

  if (res.status === 404) {
    return null;
  }

  if (!res.ok) {
    throw new Error(`DAB ${res.status}: ${await res.text()}`);
  }

  const payload = await res.json();
  return payload.value?.[0] ?? null;
}
```

---

## Tratamento de erros (playbook)

### 400 + `implicit primary key`

- Causa: uso de `/verbas/{id}`
- Ação: trocar para `/verbas/id_verba/{id}`

### 401

- Causa: ausência/chave inválida no IIS
- Ação: revisar `X-API-Key`

### 404 em item

- Causa: `id_verba` não encontrado
- Ação: tratar como "sem registro"

### 500

- Causa: erro interno/transitório
- Ação: retry exponencial com limite e observabilidade

---

## Checklist de homologação GA360

- [ ] `GET /v1/health` com `X-API-Key` retorna 200
- [ ] `GET /v1/verbas?$first=1` retorna 200 e campo `value`
- [ ] `id_verba` presente nos itens retornados
- [ ] `GET /v1/verbas/id_verba/{id}` retorna 200 para id válido
- [ ] Nenhuma chamada usando `/v1/verbas/{id}`
- [ ] Retry implementado para 5xx

---

## Observações finais

- O backend DAB está operacional.
- O erro apontado pelo GA360 é **de formato de URL na integração**, não de indisponibilidade do serviço.
- Com a mudança de rota para chave explícita e uso de coleção paginada, a sincronização deve ocorrer normalmente.
