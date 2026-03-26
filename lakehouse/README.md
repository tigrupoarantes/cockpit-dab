# Lakehouse Skills e Inventario

Este pacote concentra a governanca local do data lakehouse `GA_DATALAKE` com estrutura medalhao. A organizacao principal segue dois eixos:

- camada: `bronze`, `silver`, `gold`
- industria: `shared`, `chokdistribuidora`, `g4distribuidora`

## Objetivo

- padronizar skills especializadas para analise e manutencao do lakehouse
- materializar um inventario navegavel do banco por camada e industria
- manter um manifesto central com classificacao, colunas e relacionamentos

## Estrutura

```text
lakehouse/
  README.md
  catalog/
    classification-overrides.json
    manifest.json
    manifest.md
  scripts/
    generate-inventory.ps1
  skills/
    lakehouse-orchestrator/
    lakehouse-inventory/
    lakehouse-naming/
    lakehouse-bronze/
    lakehouse-silver/
    lakehouse-gold/
    lakehouse-quality/
  bronze|silver|gold/
    shared/
    chokdistribuidora/
    g4distribuidora/
```

## Convencoes

- Objetos com nome final `_chokdistribuidora` vao para `chokdistribuidora`.
- Objetos com nome final `_g4distribuidora` ou `_g4_distribuidora` vao para `g4distribuidora`.
- Objetos sem sufixo de industria vao para `shared`.
- Sufixos nao mapeados explicitamente ficam em `shared` ate entrarem no arquivo de overrides.
- Views funcionais e endpoints multi-tenant, como `vw_sales_daily` e `vw_verbas_api`, ficam em `shared`.

## Fonte dos metadados

- `docs/schema_columns.csv`
- `docs/schema_fks.csv`

O inventario atual e derivado desses snapshots versionados, nao de introspeccao online do banco.

## Geracao do inventario

### Banco real

Execute:

```powershell
powershell -ExecutionPolicy Bypass -File .\lakehouse\scripts\refresh-lakehouse-from-db.ps1
```

Esse fluxo:

- conecta no SQL Server usando o `.env`
- atualiza `docs/schema_columns.csv` e `docs/schema_fks.csv`
- consulta definicoes SQL e chaves do banco real
- gera `manifest.json`, `manifest.md`, `index.md`
- cria um arquivo `.md` por objeto em `lakehouse/<schema>/<industria>/`

### Fallback offline

Execute:

```powershell
powershell -ExecutionPolicy Bypass -File .\lakehouse\scripts\generate-inventory.ps1
```

O script offline atualiza:

- `lakehouse/catalog/manifest.json`
- `lakehouse/catalog/manifest.md`
- `lakehouse/<schema>/<industria>/index.md`

## Skills

- `lakehouse-orchestrator`: skill frontal para roteamento
- `lakehouse-inventory`: inventario e catalogo
- `lakehouse-naming`: naming, parsing e classificacao
- `lakehouse-bronze`: ingestao e rastreabilidade
- `lakehouse-silver`: modelagem intermediaria
- `lakehouse-gold`: camada semantica e consumo
- `lakehouse-quality`: qualidade, reconciliacao e auditoria
