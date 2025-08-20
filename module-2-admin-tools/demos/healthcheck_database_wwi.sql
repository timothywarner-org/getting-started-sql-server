-- healthcheck_database_wwi.sql
-- Purpose: Emit size + recovery model for WideWorldImporters
SET NOCOUNT ON;

SELECT
  d.name AS DatabaseName,
  d.recovery_model_desc AS RecoveryModel,
  CAST(SUM(CASE WHEN mf.type_desc = 'ROWS' THEN mf.size ELSE 0 END) * 8.0 / 1024 AS decimal(18,1)) AS DataSizeMB,
  CAST(SUM(CASE WHEN mf.type_desc = 'LOG'  THEN mf.size ELSE 0 END) * 8.0 / 1024 AS decimal(18,1)) AS LogSizeMB
FROM sys.databases AS d
JOIN sys.master_files AS mf
  ON d.database_id = mf.database_id
WHERE d.name = N'WideWorldImporters'
GROUP BY d.name, d.recovery_model_desc;
