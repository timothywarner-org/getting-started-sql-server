-- m3-log-stats-wwi.sql
-- Purpose: Transaction log utilization and VLF counts for WWI.
SET NOCOUNT ON;

DECLARE @db sysname = N'WideWorldImporters';

SELECT
  d.name AS DatabaseName,
  d.recovery_model_desc,
  ls.total_log_size_in_bytes / 1024.0 / 1024.0 AS total_log_mb,
  ls.used_log_space_in_bytes  / 1024.0 / 1024.0 AS used_log_mb,
  ls.used_log_space_in_percent,
  ls.total_vlf_count,
  ls.active_vlf_count,
  ls.last_log_backup_lsn,
  ls.last_log_backup_time
FROM sys.databases AS d
CROSS APPLY sys.dm_db_log_stats(DB_ID(@db)) AS ls
WHERE d.database_id = DB_ID(@db);
