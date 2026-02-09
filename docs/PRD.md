# PRD — Ponte de Dados Cockpit GA via Data API Builder (DAB)

Projeto: API de leitura do Datalake (SQL Server 2017) para o Cockpit Grupo Arantes  
Owner: William Cintra  
Plataforma alvo: Windows Server 2019 (produção) + PC (desenvolvimento)  
Banco: SQL Server 2017 (datalake) — sem duplicar dados no Supabase  
Princípio: simples, seguro, rápido; “Apple-like”: poucas telas, pouca fricção, previsível.

## 1) Visão do produto

Criar uma ponte de API read-only entre o datalake (SQL Server 2017) e o Cockpit, usando Microsoft Data API Builder (DAB), de forma que o app consuma dados em tempo real (ou quase real) sem replicação e sem custos desnecessários.

A API expõe apenas Views (camada semântica), nunca tabelas brutas, garantindo:

- Governança (o que pode sair “pra fora”)
- Performance (pré-joins e agregações controladas)
- Segurança (mínimo privilégio e superfície reduzida)

## 2) Objetivos

### 2.1 Objetivos do MVP (sem fricção)

- Subir uma API DAB funcional (REST) conectada ao SQL Server.
- Expor um conjunto inicial de views de negócio (KPIs essenciais).
- Permitir filtros por tenant/empresa e por período (quando aplicável).
- Disponibilizar /health para monitoramento.
- Documentar tudo em um workspace do VSCode para evolução contínua.

### 2.2 Não objetivos (MVP)

- CRUD (inserir/alterar/excluir) no datalake.
- “Query livre” via API (risco de segurança e performance).
- Publicar GraphQL (opcional futuro).
- Autenticação complexa (entra depois; MVP pode ser IP allowlist/VPN + token simples).

## 3) Escopo

### 3.1 Em escopo

- Workspace VSCode com estrutura padrão do projeto.
- Extração de metadados do schema (tabelas/colunas/FKs) para orientar IA e padronizar evolução.
- Criação de views “API-ready” por domínio:
  - Vendas
  - Clientes/Positivação
  - Produtos/SKU
  - Estoque (se já existir no datalake)
  - Financeiro (se já existir no datalake)
- Configuração do DAB (dab-config.json) expondo essas views.
- Scripts PowerShell para rodar local e publicar no Windows Server.

### 3.2 Fora de escopo (por enquanto)

- Gateway/API Management
- Rate limiting avançado
- Observabilidade full (Prometheus/Grafana)
- Cache distribuído (Redis)

## 4) Usuários e casos de uso

### 4.1 Usuários

- Cockpit (app Lovable): consumidor principal
- Equipe de BI / DBA: governança das views e performance
- TI: deploy e operação do serviço

### 4.2 Casos de uso do MVP

- Cockpit consulta vendas por dia por empresa (tenant)
- Cockpit consulta ranking SKU por período
- Cockpit consulta cobertura/positivação por cidade/região
- Cockpit consulta estoque atual por SKU (se aplicável)
- Monitoramento (healthcheck) e validação de conectividade

## 5) Requisitos funcionais

### 5.1 API

- Somente leitura
- REST endpoints gerados pelo DAB para cada view exposta
- Padrão de filtros:
  - tenant_id (ou empresa_id) obrigatório em views multi-tenant
  - dt_ini / dt_fim quando aplicável (data da venda, competência etc.)
- Paginação habilitada para endpoints de listas
- Endpoint /health retorna:
  - status do serviço
  - status de conexão (opcional: query simples no banco)

### 5.2 Views (camada semântica)

Cada view deve:

- Ter nome padronizado: vw_<dominio>_<descricao>
- Incluir coluna tenant_id/empresa_id (se multi-tenant)
- Ter colunas com nomes claros e consistentes
- Evitar cálculos “pesados” em tempo de request se possível (pré-agregações)

### 5.3 Governança

- A API não expõe tabelas fato/dim diretamente
- O DBA controla o que “vira view”
- Usuário do SQL para a API:
  - permissões apenas de SELECT nas views

## 6) Requisitos não funcionais

### 6.1 Segurança (MVP)

- Tráfego em rede interna (mesma rede) + allowlist de IP (ou VPN)
- Credenciais do banco via variável de ambiente (não hardcoded)
- Usuário SQL read-only dedicado (ex.: svc_cockpit_api)

### 6.2 Performance

- Views otimizadas com índices adequados nas tabelas base (DBA decide)
- Evitar endpoints que retornem “dados infinitos” sem filtro
- Limite de período padrão (ex.: últimos 90 dias) em views onde fizer sentido

### 6.3 Confiabilidade

- Serviço iniciado automaticamente no servidor (Windows Service/Task Scheduler/NSSM)
- Logs básicos e healthcheck
- Procedimento de rollback simples (troca de pasta / versão)

## 7) Arquitetura

### 7.1 Alto nível

Cockpit → (HTTPS/internal) → DAB (Windows Server 2019) → SQL Server 2017 (Datalake)

### 7.2 Ambiente de desenvolvimento

PC (VSCode):

- Conecta no SQL Server para gerar views e testar consultas
- Roda DAB localmente apontando para o datalake (rede interna)

### 7.3 Contratos

- Camada “fonte”: fato/dim
- Camada “API”: views (contrato estável)
- Camada “app”: endpoints DAB (contrato versionável)

## 8) Estrutura do repositório (VSCode Workspace)

```
cockpit-dab/
  dab/
    dab-config.json
  sql/
    meta/
      columns.sql
      fks.sql
    views/
      vw_sales_daily.sql
      vw_sales_by_sku.sql
      vw_coverage_city.sql
      vw_stock_position.sql
  scripts/
    run-local.ps1
    deploy-server.ps1
    healthcheck.ps1
    test-endpoints.ps1
  docs/
    PRD.md
    SCHEMA.md
    schema_columns.csv
    schema_fks.csv
    conventions.md
  tests/
    postman_collection.json (opcional)
```

## 9) Padrões (convenções)

### 9.1 Naming

Views: vw_<dominio>_<descricao>

Campos:

- datas: dt_*
- valores: vl_*
- quantidades: qt_*
- chaves: id_*

Tenant:

- padronizar para tenant_id nas views (mesmo que no datalake seja cd_empresa)

### 9.2 Filtros padrão

- Sempre que for lista:
  - deve existir condição de período (quando aplicável)
  - ou paginação obrigatória

## 10) Fases de implementação

### Fase 0 — Preparação do workspace (PC)

Entregas

- Estrutura de pastas
- Scripts SQL de inventário (columns/fks)
- SCHEMA.md e conventions.md

Critérios de aceite

- VSCode conecta no SQL Server
- Export de schema_columns.csv e schema_fks.csv realizado

### Fase 1 — MVP de API “no ar” (local)

Entregas

- 3–5 views iniciais (vendas e ranking)
- dab-config.json expondo as views
- run-local.ps1 + test-endpoints.ps1
- /health

Critérios de aceite

- DAB roda local e responde endpoints
- Endpoint de vendas por dia retorna dados com filtro tenant/período
- /health OK

### Fase 2 — Publicação no Windows Server 2019

Entregas

- Script deploy-server.ps1
- Serviço rodando automaticamente (NSSM/Task Scheduler/IIS reverse proxy se necessário)
- CORS configurado para o host do Cockpit
- Allowlist de IP ou rede interna controlada

Critérios de aceite

- API acessível a partir do Cockpit
- API reinicia automaticamente após reboot
- Logs mínimos e healthcheck funcionando

### Fase 3 — Hardening e Governança

Entregas

- Usuário SQL read-only dedicado
- Rotina de versionamento do dab-config.json e das views
- Limites e proteções (paginação e filtros padrão)
- Checklist de performance (índices e execução)

Critérios de aceite

- Sem acesso a tabelas brutas
- Sem endpoint que “derrube” o banco por consulta ampla
- Processo claro de publicar nova view sem risco

## 11) Requisitos de IA (para o VSCode trabalhar bem)

### 11.1 Insumos que a IA deve ler

- docs/SCHEMA.md
- docs/schema_columns.csv
- docs/schema_fks.csv
- docs/conventions.md

### 11.2 O que a IA deve gerar

- sql/views/*.sql com CREATE OR ALTER VIEW
- dab/dab-config.json com entidades REST
- scripts/*.ps1 para rodar/testar/deploy
- Sugestões de índices (como recomendação, não executa sozinho)

## 12) Riscos e mitigação

- Schema mudando (DBA construindo fato/dim): usar views como contrato; refinar depois.
- Performance: pré-agregações e filtros; índices; limites por período.
- Segurança: read-only + allowlist/VPN; sem query livre.
- Operação: healthcheck + serviço automático.

## 13) Checklist de “Definition of Done”

- Consegue rodar DAB local no PC e consultar endpoints
- Views padronizadas e revisadas pelo DBA
- DAB no Windows Server com start automático
- Credenciais via variáveis de ambiente
- CORS/allowlist ok
- Documentação mínima no docs/

## Próximo passo imediato (para o VSCode já ter contexto)

- Salve este PRD como docs/PRD.md dentro do projeto.
- Crie também docs/conventions.md com os padrões de naming/filtros (posso te entregar o conteúdo pronto se quiser).
- Gere schema_columns.csv e schema_fks.csv pelo VSCode (mssql).
