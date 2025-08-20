-- m3-inspect-engine.sql
-- Purpose: Quick facts about the instance and databases; show Agent job count.
SET NOCOUNT ON;

SELECT
  CAST(SERVERPROPERTY('MachineName')    AS nvarchar(128)) AS MachineName,
  CAST(SERVERPROPERTY('ServerName')     AS nvarchar(128)) AS ServerName,
  CAST(SERVERPROPERTY('Edition')        AS nvarchar(128)) AS Edition,
  CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(128)) AS ProductVersion,
  CAST(SERVERPROPERTY('ProductLevel')   AS nvarchar(128)) AS ProductLevel,
  CAST(SERVERPROPERTY('EngineEdition')  AS int)           AS EngineEdition;

SELECT
  name,
  state_desc,
  recovery_model_desc,
  containment_desc
FROM sys.databases
WHERE name IN (N'master', N'model', N'msdb', N'tempdb', N'WideWorldImporters')
ORDER BY CASE name WHEN 'master' THEN 1 WHEN 'model' THEN 2 WHEN 'msdb' THEN 3 WHEN 'tempdb' THEN 4 ELSE 5 END;

-- Agent presence: shows how many jobs exist (Agent service may or may not be running)
SELECT COUNT(*) AS AgentJobCount
FROM msdb.dbo.sysjobs;
