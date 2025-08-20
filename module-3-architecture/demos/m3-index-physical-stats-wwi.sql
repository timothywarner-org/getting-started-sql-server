-- m3-index-physical-stats-wwi.sql
-- Purpose: Snapshot of fragmentation/page counts for a representative WWI table.
SET NOCOUNT ON;
USE [WideWorldImporters];
GO

DECLARE @obj_id int = OBJECT_ID(N'Sales.Invoices');
IF @obj_id IS NULL SET @obj_id = OBJECT_ID(N'Sales.Orders');
IF @obj_id IS NULL SET @obj_id = OBJECT_ID(N'Sales.Customers');

SELECT
  OBJECT_SCHEMA_NAME(ips.object_id) + '.' + OBJECT_NAME(ips.object_id) AS table_name,
  i.name AS index_name,
  ips.index_id,
  ips.index_type_desc,
  ips.alloc_unit_type_desc,
  CAST(ips.avg_fragmentation_in_percent AS decimal(5,2)) AS avg_fragmentation_in_percent,
  ips.page_count
FROM sys.dm_db_index_physical_stats(DB_ID(), @obj_id, NULL, NULL, 'SAMPLED') AS ips
JOIN sys.indexes AS i
  ON ips.object_id = i.object_id
 AND ips.index_id  = i.index_id
ORDER BY ips.page_count DESC, ips.index_id;
