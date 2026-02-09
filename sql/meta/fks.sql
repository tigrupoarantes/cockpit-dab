SET NOCOUNT ON;

/*
  Inventário de Foreign Keys (tabelas).
  Objetivo: gerar docs/schema_fks.csv
*/

SELECT
  DB_NAME()                                   AS database_name,
  fk.name                                     AS fk_name,
  s_parent.name                               AS parent_schema,
  t_parent.name                               AS parent_table,
  c_parent.name                               AS parent_column,
  s_ref.name                                  AS referenced_schema,
  t_ref.name                                  AS referenced_table,
  c_ref.name                                  AS referenced_column,
  fkc.constraint_column_id                    AS column_ordinal
FROM sys.foreign_keys fk
JOIN sys.foreign_key_columns fkc ON fkc.constraint_object_id = fk.object_id
JOIN sys.tables t_parent         ON t_parent.object_id = fk.parent_object_id
JOIN sys.schemas s_parent        ON s_parent.schema_id = t_parent.schema_id
JOIN sys.columns c_parent        ON c_parent.object_id = t_parent.object_id AND c_parent.column_id = fkc.parent_column_id
JOIN sys.tables t_ref            ON t_ref.object_id = fk.referenced_object_id
JOIN sys.schemas s_ref           ON s_ref.schema_id = t_ref.schema_id
JOIN sys.columns c_ref           ON c_ref.object_id = t_ref.object_id AND c_ref.column_id = fkc.referenced_column_id
WHERE fk.is_ms_shipped = 0
ORDER BY s_parent.name, t_parent.name, fk.name, fkc.constraint_column_id;
