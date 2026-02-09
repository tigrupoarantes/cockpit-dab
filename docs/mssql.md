# MSSQL (SQL Server) – Conexão local

Este repo não deve armazenar credenciais em texto.

## Opção 1: Windows Authentication (recomendado)
1. Copie `.env.example` para `.env.local`
2. Preencha:
   - `MSSQL_SERVER=SEU_SERVIDOR\\SUA_INSTANCIA`
   - `MSSQL_DATABASE=SEU_BANCO` (opcional)
   - `MSSQL_AUTH=Windows`
3. Conecte:
   - `powershell -NoProfile -File scripts/connect-mssql.ps1`

## Opção 2: SQL Authentication
1. Copie `.env.example` para `.env.local`
2. Preencha:
   - `MSSQL_SERVER=...`
   - `MSSQL_DATABASE=...` (opcional)
   - `MSSQL_AUTH=Sql`
   - `MSSQL_USERNAME=...`
   - **não** commite `MSSQL_PASSWORD` (use prompt de senha do script)
3. Conecte:
   - `powershell -NoProfile -File scripts/connect-mssql.ps1 -Auth Sql -Username SEU_USER`

## Listar bancos
- `powershell -NoProfile -File scripts/connect-mssql.ps1 -ListDatabases`

## Listar schemas
- `powershell -NoProfile -File scripts/connect-mssql.ps1 -ListSchemas`

## Listar tabelas
- `powershell -NoProfile -File scripts/connect-mssql.ps1 -ListTables`
- Filtrar por schema: `powershell -NoProfile -File scripts/connect-mssql.ps1 -ListTables -Schema dbo`
- Limitar quantidade: `powershell -NoProfile -File scripts/connect-mssql.ps1 -ListTables -Top 50`
