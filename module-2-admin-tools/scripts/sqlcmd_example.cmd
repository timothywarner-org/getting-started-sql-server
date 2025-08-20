:: Example 5: Backup the WWI database
:: Back up to a .bak file (change path for your environment)
sqlcmd -S tcp:SQL1,1433 -d master -E -N -C -Q "BACKUP DATABASE [WideWorldImporters] TO DISK='C:\Backups\WWI.bak' WITH INIT, STATS=10"

:: Example 6: Restore the WWI database to a new name
:: Be careful: will overwrite if DB already exists
sqlcmd -S tcp:SQL1,1433 -d master -E -N -C -Q "RESTORE DATABASE [WWI_Restored] FROM DISK='C:\Backups\WWI.bak' WITH MOVE 'WWI_Primary' TO 'C:\SQLData\WWI_Restored.mdf', MOVE 'WWI_Log' TO 'C:\SQLLogs\WWI_Restored.ldf', REPLACE, STATS=10"

:: Example 7: List failed SQL Agent jobs since midnight
:: Filters SQL Agent history for failures today
sqlcmd -S tcp:SQL1,1433 -d msdb -E -N -C -Q "SELECT j.name AS JobName, h.run_date, h.run_time, h.message FROM msdb.dbo.sysjobs AS j JOIN msdb.dbo.sysjobhistory AS h ON j.job_id = h.job_id WHERE h.run_status = 0 AND CONVERT(DATE, msdb.dbo.agent_datetime(h.run_date, h.run_time)) = CAST(GETDATE() AS DATE)"

:: Example 8: Add a SQL Server login (SQL authentication)
:: Creates a SQL login with a strong password
sqlcmd -S tcp:SQL1,1433 -d master -E -N -C -Q "CREATE LOGIN [OpsUser] WITH PASSWORD='StrongPassword123!'"

:: Example 9: Grant database access to a login
:: Creates user in WWI DB and adds to db_datareader role
sqlcmd -S tcp:SQL1,1433 -d WideWorldImporters -E -N -C -Q "CREATE USER [OpsUser] FOR LOGIN [OpsUser]; EXEC sp_addrolemember 'db_datareader', 'OpsUser'"

:: Example 10: Run a SQL Server assessment (basic check)
:: Calls built-in DMVs for quick server health info
sqlcmd -S tcp:SQL1,1433 -d master -E -N -C -Q "SELECT SERVERPROPERTY('ProductVersion') AS Version, SERVERPROPERTY('Edition') AS Edition, SERVERPROPERTY('EngineEdition') AS EngineEdition; SELECT name, state_desc, recovery_model_desc FROM sys.databases"
