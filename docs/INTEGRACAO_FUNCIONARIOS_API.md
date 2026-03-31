# Integracao tecnica - Cadastro de Funcionarios via API

Data: 2026-03-25
Projeto: Cockpit

## 1) Objetivo

Substituir o cadastro manual de funcionarios no app por uma fonte de dados API-first, consumindo a entidade `funcionarios` publicada no DAB a partir de `gold.vw_funcionario`.

Resultado esperado:
- Busca de funcionarios passa a usar API.
- Lista e filtros sao alimentados pela fonte oficial (`gold.vw_funcionario`).
- Cadastro manual deixa de ser fonte primaria.

## 2) Arquitetura de consumo

Fluxo recomendado (producao):

1. App chama Edge Function `dab-proxy` (Supabase).
2. Edge Function valida JWT do usuario.
3. Edge Function consulta `api_connections` (base URL + auth).
4. Edge Function chama DAB (`/v1/funcionarios`) com `X-API-Key`.
5. App recebe resposta JSON com paginacao por `nextLink`.

## 3) Endpoint e contrato

### 3.1 Endpoint logico
- `funcionarios`

### 3.2 Endpoint DAB
- Producao: `GET https://api.grupoarantes.emp.br/v1/funcionarios`
- Local: `GET http://localhost:5000/api/funcionarios`
- Rota mantida: a URL continua `funcionarios`; a mudanca foi na fonte SQL da entidade, agora `gold.vw_funcionario`.

### 3.3 Campos retornados
- `Situacao` (number)
- `CPF` (string, chave da entidade no DAB)
- `Nome_Funcionario` (string)
- `Email` (string)
- `Sexo` (string)
- `Data_Nascimento` (date)
- `Idade` (number)
- `Data_Admissao` (date)
- `Data_Demissao` (date | null)
- `Primeiro_Emprego` (string)
- `Contabilizacao` (string)
- `Cargo` (string)
- `Categoria` (string)
- `Departamento` (string)
- `Funcao` (string)
- `Cod_Empresa` (number)
- `Nome_Fantasia` (string)

### 3.4 Paginacao
- `?$first=<N>` para tamanho de pagina.
- A resposta pode trazer `nextLink`.
- Para a proxima pagina, reaproveitar `nextLink` sem remontar filtros manualmente.

## 4) Contrato de chamada via Edge Function

### 4.1 Primeira pagina

```json
{
  "path": "funcionarios",
  "query": { "$first": 100 }
}
```

### 4.2 Proxima pagina

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
      "Situacao": 1,
      "CPF": "00298036673",
      "Nome_Funcionario": "ARMINDO GOMES DE PINHO",
      "Data_Admissao": "2025-12-09",
      "Cargo": "...",
      "Departamento": "...",
      "Cod_Empresa": 26
    }
  ],
  "nextLink": "/api/funcionarios?$first=100&$after=..."
}
```

## 5) Mapeamento para o modelo do app

Mapeamento sugerido:

- `external_id` <- `CPF`
- `full_name` <- `Nome_Funcionario`
- `document` <- `CPF`
- `admission_date` <- `Data_Admissao`
- `role_name` <- `Cargo`
- `department_name` <- `Departamento`
- `function_name` <- `Funcao`
- `company_code` <- `Cod_Empresa`
- `company_name` <- `Nome_Fantasia`
- `source` <- valor fixo `dab_api`

Regra de identidade recomendada:
- Chave primaria de integracao: `external_id` (`CPF`).
- Nao usar nome como identificador.

## 6) Estrategia de migracao (manual -> API)

### Fase 1 - Shadow mode
- Consumir API em background.
- Comparar total e amostragem com base manual.
- Logar divergencias de CPF/nome/departamento.

### Fase 2 - Write lock no manual
- Bloquear criacao/edicao manual para novos registros.
- Manter historico manual apenas para consulta.

### Fase 3 - API como fonte oficial
- Tela de busca/listagem usa somente API.
- Atualizacao local por upsert usando `external_id`.

## 7) Busca e filtros no app

Filtros minimos recomendados na UI:
- Nome (contains em memoria local apos carga da pagina, ou filtro server-side quando disponivel).
- CPF (igual ou prefixo).
- Empresa (`Cod_Empresa`).
- Departamento.

Observacao:
- O endpoint atual expoe leitura paginada. Se necessario filtro server-side avancado (`$filter`), validar suporte na versao do DAB antes de depender disso na UX.

## 8) Resiliencia e erros

Tratar explicitamente:
- `401`: token invalido (usuario sem sessao).
- `403`: path fora da allowlist da Edge Function.
- `404 EntityNotFound`: endpoint incorreto (usar `funcionarios`).
- `502/504`: indisponibilidade temporaria do backend/proxy.

Fallback recomendado:
- Exibir ultimo snapshot local em modo leitura + banner "dados desatualizados".

## 9) Seguranca e LGPD

Atencao: `CPF` e dado sensivel.

Recomendacoes:
- Nao logar CPF completo em client/server logs.
- Mascarar em tela (`***.***.***-**`) fora de telas administrativas.
- Restringir exportacao CSV por perfil.
- Definir politica de retencao para snapshots locais.

## 10) Checklist de implementacao

- [ ] Incluir `funcionarios` na allowlist da Edge Function `dab-proxy`.
- [ ] Criar servico `EmployeesApiSource` no app.
- [ ] Implementar paginacao por `nextLink`.
- [ ] Implementar upsert por `external_id`.
- [ ] Adicionar mascara de CPF na UI.
- [ ] Adicionar telemetria de erro por status HTTP.
- [ ] Habilitar feature flag para corte definitivo do cadastro manual.

## 11) Teste de aceite (minimo)

1. Chamar primeira pagina (`$first=5`) e validar `value.length > 0`.
2. Validar presenca de `CPF` em todos os itens.
3. Se houver `nextLink`, carregar segunda pagina com sucesso.
4. Confirmar que busca por nome funciona na tela.
5. Confirmar que cadastro manual nao e mais usado como fonte primaria.

## 12) Referencias tecnicas

- Configuracao da entidade: `dab/dab-config.json` (`funcionarios` -> `gold.vw_funcionario`)
- View SQL publicada no banco: `gold.vw_funcionario`
- View SQL versionada no repositorio anterior: `sql/views/vw_funcionarios.sql`
- Contrato geral da API: `docs/SERVICE_API.md`
- Especificacao proxy Cockpit/Antigravity: `docs/ANTIGRAVITY_COCKPIT_DAB_PROXY.md`
