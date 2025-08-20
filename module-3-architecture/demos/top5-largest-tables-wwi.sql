-- top5-largest-tables-wwi.sql
-- Purpose: Top 5 largest tables in WideWorldImporters by total reserved MB
SET NOCOUNT ON;
USE [WideWorldImporters];
GO

SELECT TOP (5)
    s.name + '.' + t.name AS table_name,
    CAST(SUM(a.total_pages) * 8.0 / 1024 AS decimal(18,1)) AS total_mb,
    CAST(SUM(a.used_pages)  * 8.0 / 1024 AS decimal(18,1)) AS used_mb,
    CAST(SUM(a.data_pages)  * 8.0 / 1024 AS decimal(18,1)) AS data_mb,
    SUM(CASE WHEN i.index_id IN (0,1) THEN p.rows ELSE 0 END) AS approx_rows
FROM sys.tables AS t
JOIN sys.schemas AS s
  ON t.schema_id = s.schema_id
JOIN sys.indexes AS i
  ON t.object_id = i.object_id
JOIN sys.partitions AS p
  ON i.object_id = p.object_id AND i.index_id = p.index_id
JOIN sys.allocation_units AS a
  ON a.container_id = p.partition_id
GROUP BY s.name, t.name
ORDER BY total_mb DESC;
