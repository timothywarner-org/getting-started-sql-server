-- top10-largest-indexes-wwi.sql
-- Purpose: Top 10 largest indexes in WideWorldImporters (by reserved MB)
SET NOCOUNT ON;
USE [WideWorldImporters];
GO

SELECT TOP (10)
    OBJECT_SCHEMA_NAME(p.object_id) + '.' + OBJECT_NAME(p.object_id) AS table_name,
    i.name AS index_name,
    i.type_desc,
    CAST(SUM(p.reserved_page_count) * 8.0 / 1024 AS decimal(18,1)) AS reserved_mb,
    SUM(p.row_count) AS approx_rows
FROM sys.dm_db_partition_stats AS p
JOIN sys.indexes AS i
  ON p.object_id = i.object_id
 AND p.index_id  = i.index_id
GROUP BY OBJECT_SCHEMA_NAME(p.object_id), OBJECT_NAME(p.object_id), i.name, i.type_desc
ORDER BY reserved_mb DESC;
