-- m3-files-and-filegroups.sql
-- Purpose: Show WWI data/log files, sizes, growth, and filegroup placements.
SET NOCOUNT ON;
USE [WideWorldImporters];
GO

SELECT
  df.file_id,
  df.type_desc,                     -- ROWS (data) vs LOG
  df.name,
  df.physical_name,
  CAST(df.size * 8.0 / 1024 AS decimal(18,1)) AS size_mb,
  CASE df.max_size
    WHEN -1 THEN CAST(-1 AS decimal(18,1))    -- Unlimited
    ELSE CAST(df.max_size * 8.0 / 1024 AS decimal(18,1))
  END AS max_size_mb,
  CASE WHEN df.is_percent_growth = 0
       THEN CAST(df.growth * 8.0 / 1024 AS decimal(18,1))  -- MB when not percent
       ELSE NULL END AS growth_mb,
  CASE WHEN df.is_percent_growth = 1
       THEN df.growth                                     -- Percent when is_percent_growth=1
       ELSE NULL END AS growth_percent,
  fg.name AS filegroup_name
FROM sys.database_files AS df
LEFT JOIN sys.filegroups AS fg
  ON df.type_desc = 'ROWS' AND df.data_space_id = fg.data_space_id
ORDER BY df.file_id;
