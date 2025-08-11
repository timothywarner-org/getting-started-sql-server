-- top-databases-by-size.sql
-- Purpose: Data vs. log size for each database (instance-wide)
SET NOCOUNT ON;

SELECT
  d.name AS database_name,
  CAST(SUM(CASE WHEN mf.type_desc = 'ROWS' THEN mf.size ELSE 0 END) * 8.0 / 1024 AS decimal(18,1)) AS data_size_mb,
  CAST(SUM(CASE WHEN mf.type_desc = 'LOG'  THEN mf.size ELSE 0 END) * 8.0 / 1024 AS decimal(18,1)) AS log_size_mb
FROM sys.databases AS d
JOIN sys.master_files AS mf
  ON d.database_id = mf.database_id
GROUP BY d.name
ORDER BY (CAST(SUM(mf.size) * 8.0 / 1024 AS decimal(18,1))) DESC;
