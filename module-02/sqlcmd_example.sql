-- sqlcmd example: run a quick query
SELECT TOP (5)
  CustomerID, CustomerName
FROM Sales.Customers
ORDER BY CustomerID;

-- Example 1: Connect to SQL Server and list all databases
-- Shows how to enumerate databases on SQL1 (default instance)
:CONNECT SQL1
SELECT name
FROM sys.databases;
GO

-- Example 2: Get SQL Server instance information
-- Useful for inventory, version checks, and patching
SELECT SERVERPROPERTY('ProductVersion') AS Version, SERVERPROPERTY('Edition') AS Edition, SERVERPROPERTY('ProductLevel') AS ProductLevel;
GO

-- Example 3: Query data from WWI database
-- Use :CONNECT and :USE for context switching
:CONNECT SQL1
USE WideWorldImporters;
SELECT TOP (5)
  CustomerID, CustomerName
FROM Sales.Customers
ORDER BY CustomerID;
GO

-- Example 4: Backup the WWI database
-- Automate backups using T-SQL
BACKUP DATABASE WideWorldImporters TO DISK = 'C:\Backups\WWI.bak' WITH COMPRESSION, INIT;
GO

-- Example 5: Restore the WWI database (to a new name)
-- Restore from backup file (be careful in production!)
RESTORE DATABASE WWI_Restored FROM DISK = 'C:\Backups\WWI.bak' WITH MOVE 'WideWorldImporters' TO 'C:\Data\WWI_Restored.mdf', MOVE 'WideWorldImporters_log' TO 'C:\Data\WWI_Restored_log.ldf', REPLACE;
GO

-- Example 6: List failed SQL Agent jobs since midnight
-- Requires msdb context and job history query
USE msdb;
SELECT j.name, h.run_date, h.run_status
FROM sysjobs j
  JOIN sysjobhistory h ON j.job_id = h.job_id
WHERE h.run_status <> 1 AND h.run_date = CONVERT(INT, CONVERT(VARCHAR, GETDATE(), 112));
GO

-- Example 7: Add a SQL Server login (security task)
-- Demonstrates basic security management
CREATE LOGIN OpsUser WITH PASSWORD = 'StrongPassword123!';
GO

-- Example 8: Grant database access to a login
-- Assigns user to WWI database and role
USE WideWorldImporters;
CREATE USER OpsUser FOR LOGIN OpsUser;
ALTER ROLE db_datareader ADD MEMBER OpsUser;
GO

-- Example 9: Run a SQL Server assessment (using sp_Blitz as example)
-- Download sp_Blitz from Brent Ozar's site and run for best practices
-- EXEC sp_Blitz;
GO

-- Example 10: Automate a health check script and export results
-- Use sqlcmd with -o to export results to CSV
-- sqlcmd -S SQL1 -d WideWorldImporters -i healthcheck_database_wwi.sql -o C:\Reports\WWI_HealthCheck.csv -s,

-- Example 11: Schedule a T-SQL script as a SQL Agent job
-- Automate recurring DBA tasks
-- See: https://learn.microsoft.com/en-us/sql/ssms/agent/schedule-a-job

-- Advanced Example 12: Use variables and error handling
:SETVAR dbname
WideWorldImporters
:CONNECT SQL1
USE $
(dbname);
BEGIN TRY
    SELECT COUNT(*) AS CustomerCount
FROM Sales.Customers;
END TRY
BEGIN CATCH
    SELECT ERROR_MESSAGE() AS ErrorMessage;
END CATCH;
GO

-- Advanced Example 13: Use sqlcmd scripting for looping
-- Export all tables to CSV (run from command line)
-- for %t in (SELECT name FROM sys.tables) do sqlcmd -S SQL1 -d WideWorldImporters -Q "SELECT * FROM %t" -o C:\Exports\%t.csv -s,

-- Advanced Example 14: Disable all SQL Agent jobs except those matching a pattern
-- Use T-SQL to update job status
USE msdb;
UPDATE sysjobs SET enabled = 0 WHERE name NOT LIKE '%Critical%';
GO
