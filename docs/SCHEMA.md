# Schema (inventário)

Este inventário é gerado automaticamente a partir do SQL Server para dar contexto ao time e à IA durante a criação/alteração de views.

## Arquivos gerados

- `docs/schema_columns.csv`: colunas de tabelas e views (schema, objeto, tipo, nulabilidade, etc.)
- `docs/schema_fks.csv`: foreign keys (relacionamentos entre tabelas)

## Como gerar/atualizar

Execute:

- `powershell -NoProfile -File scripts/export-schema.ps1`

O script usa as variáveis do `.env`/`.env.local`:

- `MSSQL_SERVER`
- `MSSQL_DATABASE`
- `MSSQL_AUTH` (`Windows` ou `Sql`)
- `MSSQL_USERNAME` (se `Sql`)
- `MSSQL_PASSWORD` (opcional; se não existir, ele pede no prompt)

## Fonte dos dados

As queries de inventário ficam em:

- `sql/meta/columns.sql`
- `sql/meta/fks.sql`
