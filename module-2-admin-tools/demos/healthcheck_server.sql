-- healthcheck_server.sql
-- Purpose: Emit one row of basic server properties for quick export
SET NOCOUNT ON;
SELECT
  CAST(SERVERPROPERTY('MachineName')       AS nvarchar(128)) AS MachineName,
  CAST(SERVERPROPERTY('ServerName')        AS nvarchar(128)) AS ServerName,
  CAST(SERVERPROPERTY('Edition')           AS nvarchar(128)) AS Edition,
  CAST(SERVERPROPERTY('ProductVersion')    AS nvarchar(128)) AS ProductVersion;
