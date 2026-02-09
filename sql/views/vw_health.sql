CREATE OR ALTER VIEW dbo.vw_health
AS
SELECT
  CAST(1 AS int)   AS id,
  CAST(1 AS bit)   AS is_ok,
  @@SERVERNAME     AS server_name,
  DB_NAME()        AS database_name,
  SUSER_SNAME()    AS login_name,
  SYSUTCDATETIME() AS dt_utc;
GO
