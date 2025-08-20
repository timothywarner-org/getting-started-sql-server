-- find-largest-database-files.sql
-- Purpose: Largest database files (data/log) across the instance
SET NOCOUNT ON;

SELECT TOP (50)
  DB_NAME(mf.database_id)                               AS database_name,
  mf.file_id,
  mf.type_desc,                                         -- ROWS vs LOG
  mf.name                                               AS logical_name,
  mf.physical_name,
  CAST(mf.size * 8.0 / 1024 AS decimal(18,1))           AS size_mb,
  CASE mf.max_size
    WHEN -1 THEN CAST(-1 AS decimal(18,1))              -- Unlimited growth
    ELSE CAST(mf.max_size * 8.0 / 1024 AS decimal(18,1))
  END                                                   AS max_size_mb,
  CASE WHEN mf.is_percent_growth = 0
       THEN CAST(mf.growth * 8.0 / 1024 AS decimal(18,1))  -- MB when not percent
       ELSE NULL END                                    AS growth_mb,
  CASE WHEN mf.is_percent_growth = 1
       THEN mf.growth
       ELSE NULL END                                    AS growth_percent
FROM sys.master_files AS mf
ORDER BY size_mb DESC;
