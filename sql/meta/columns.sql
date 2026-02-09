SET NOCOUNT ON;

/*
  Inventário de colunas para tabelas e views.
  Objetivo: gerar docs/schema_columns.csv
*/

SELECT
  DB_NAME()                           AS database_name,
  s.name                              AS schema_name,
  o.name                              AS object_name,
  CASE o.type
    WHEN 'U' THEN 'TABLE'
    WHEN 'V' THEN 'VIEW'
    ELSE o.type_desc
  END                                 AS object_type,
  c.column_id                         AS column_ordinal,
  c.name                              AS column_name,
  t.name                              AS data_type,
  c.max_length                        AS max_length,
  c.precision                         AS [precision],
  c.scale                             AS [scale],
  c.is_nullable                       AS is_nullable,
  c.is_identity                       AS is_identity,
  c.is_computed                       AS is_computed
FROM sys.objects o
JOIN sys.schemas s  ON s.schema_id = o.schema_id
JOIN sys.columns c  ON c.object_id = o.object_id
JOIN sys.types t    ON t.user_type_id = c.user_type_id
WHERE o.type IN ('U','V')
  AND o.is_ms_shipped = 0
ORDER BY s.name, o.name, c.column_id;
