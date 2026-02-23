# Integração técnica — Cadastro de Funcionários via API

Data: 2026-02-20  
Projeto: Cockpit

## 1) Objetivo

Substituir o cadastro manual de funcionários no app por uma fonte de dados API-first, consumindo a entidade `funcionarios` já publicada no DAB.

Resultado esperado:
- Busca de funcionários passa a usar API.
- Lista e filtros são alimentados pela fonte oficial (`dbo.vw_funcionarios`).
- Cadastro manual deixa de ser fonte primária.

## 2) Arquitetura de consumo

Fluxo recomendado (produção):

1. App chama Edge Function `dab-proxy` (Supabase).
2. Edge Function valida JWT do usuário.
3. Edge Function consulta `api_connections` (base URL + auth).
4. Edge Function chama DAB (`/v1/funcionarios`) com `X-API-Key`.
5. App recebe resposta JSON (com paginação por `nextLink`).

## 3) Endpoint e contrato

### 3.1 Endpoint lógico
- `funcionarios`

### 3.2 Endpoint DAB
- Produção: `GET https://api.grupoarantes.emp.br/v1/funcionarios`
- Local: `GET http://localhost:5000/api/funcionarios`

### 3.3 Campos retornados
- `id_funcionario` (string, chave técnica estável)
- `cpf` (string)
- `nome_funcionario` (string)
- `email` (string)
- `sexo` (string)
- `data_nascimento` (date)
- `idade` (number)
- `data_admissao` (date)
- `primeiro_emprego` (string)
- `contabilizacao` (string)
- `cargo` (string)
- `categoria` (string)
- `departamento` (string)
- `funcao` (string)
- `cod_empresa` (number)
- `nome_fantasia` (string)

### 3.4 Paginação
- `?$first=<N>` para tamanho de página.
- A resposta pode trazer `nextLink`.
- Para próxima página, reaproveitar `nextLink` sem remontar filtros manualmente.

## 4) Contrato de chamada via Edge Function

### 4.1 Primeira página

```json
{
  "path": "funcionarios",
  "query": { "$first": 100 }
}
```

### 4.2 Próxima página

```json
{
  "nextLink": "/api/funcionarios?$first=100&$after=..."
}
```

### 4.3 Resposta esperada

```json
{
  "value": [
    {
      "id_funcionario": "...",
      "cpf": "...",
      "nome_funcionario": "...",
      "data_admissao": "2025-12-09",
      "cargo": "...",
      "departamento": "...",
      "cod_empresa": 26
    }
  ],
  "nextLink": "/api/funcionarios?$first=100&$after=..."
}
```

## 5) Mapeamento para o modelo do app

Mapeamento sugerido:

- `external_id` <- `id_funcionario`
- `full_name` <- `nome_funcionario`
- `document` <- `cpf`
- `admission_date` <- `data_admissao`
- `role_name` <- `cargo`
- `department_name` <- `departamento`
- `function_name` <- `funcao`
- `company_code` <- `cod_empresa`
- `company_name` <- `nome_fantasia`
- `source` <- valor fixo `dab_api`

Regra de identidade recomendada:
- Chave primária de integração: `external_id` (`id_funcionario`).
- Não usar nome como identificador.

## 6) Estratégia de migração (manual -> API)

### Fase 1 — Shadow mode
- Consumir API em background.
- Comparar total e amostragem com base manual.
- Logar divergências de CPF/nome/departamento.

### Fase 2 — Write lock no manual
- Bloquear criação/edição manual para novos registros.
- Manter histórico manual apenas para consulta.

### Fase 3 — API como fonte oficial
- Tela de busca/listagem usa somente API.
- Atualização local por upsert usando `external_id`.

## 7) Busca e filtros no app

Filtros mínimos recomendados na UI:
- Nome (contains em memória local após carga da página, ou filtro server-side quando disponível).
- CPF (igual ou prefixo).
- Empresa (`cod_empresa`).
- Departamento.

Observação:
- O endpoint atual expõe leitura paginada. Se necessário filtro server-side avançado (`$filter`), validar suporte na versão do DAB antes de depender disso na UX.

## 8) Resiliência e erros

Tratar explicitamente:
- `401`: token inválido (usuário sem sessão).
- `403`: path fora da allowlist da Edge Function.
- `404 EntityNotFound`: endpoint incorreto (usar `funcionarios`).
- `502/504`: indisponibilidade temporária do backend/proxy.

Fallback recomendado:
- Exibir último snapshot local em modo leitura + banner “dados desatualizados”.

## 9) Segurança e LGPD

Atenção: `cpf` é dado sensível.

Recomendações:
- Não logar CPF completo em client/server logs.
- Mascarar em tela (`***.***.***-**`) fora de telas administrativas.
- Restringir exportação CSV por perfil.
- Definir política de retenção para snapshots locais.

## 10) Checklist de implementação

- [ ] Incluir `funcionarios` na allowlist da Edge Function `dab-proxy`.
- [ ] Criar serviço `EmployeesApiSource` no app.
- [ ] Implementar paginação por `nextLink`.
- [ ] Implementar upsert por `external_id`.
- [ ] Adicionar máscara de CPF na UI.
- [ ] Adicionar telemetria de erro por status HTTP.
- [ ] Habilitar feature flag para corte definitivo do cadastro manual.

## 11) Teste de aceite (mínimo)

1. Chamar primeira página (`$first=5`) e validar `value.length > 0`.
2. Validar presença de `id_funcionario` em todos os itens.
3. Se houver `nextLink`, carregar segunda página com sucesso.
4. Confirmar que busca por nome funciona na tela.
5. Confirmar que cadastro manual não é mais usado como fonte primária.

## 12) Referências técnicas

- Configuração da entidade: `dab/dab-config.json` (`funcionarios` -> `dbo.vw_funcionarios`)
- View SQL no repositório: `sql/views/vw_funcionarios.sql`
- Contrato geral da API: `docs/SERVICE_API.md`
- Especificação proxy Cockpit/Antigravity: `docs/ANTIGRAVITY_COCKPIT_DAB_PROXY.md`
