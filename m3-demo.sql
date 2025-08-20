SELECT name, compatibility_level
FROM sys.databases
WHERE name = N'WideWorldImporters';


SELECT @@VERSION AS SqlServerVersion;
SELECT DB_NAME() AS CurrentDatabase;

EXEC sp_helpdb N'WideWorldImporters';

USE WideWorldImporters;
GO
SELECT file_id, name AS LogicalName, type_desc AS FileType,
       physical_name, size * 8 / 1024 AS SizeMB, growth, is_percent_growth
FROM sys.database_files;

SELECT name, recovery_model_desc, log_reuse_wait_desc
FROM sys.databases
WHERE name = N'WideWorldImporters';

SELECT *
FROM sys.dm_db_log_stats(DB_ID(N'WideWorldImporters'));

USE msdb;
GO
-- Create a new job named 'Nightly Cleanup'
EXEC dbo.sp_add_job 
    @job_name = N'Nightly Cleanup',
    @enabled = 1,
    @description = N'Deleted old log entries nightly';
GO
-- Explanation:
-- sp_add_job sets up a new job in MSDB. 'enabled = 1' means the job is active by default.

USE msdb;
GO
-- Add a T-SQL step to the 'Nightly Cleanup' job
EXEC sp_add_jobstep
    @job_name   = N'Nightly Cleanup',
    @step_name  = N'Delete expired rows',
    @subsystem  = N'TSQL',
    @command    = N'DELETE FROM Audit.Log WHERE LogDate < DATEADD(day,-30,GETDATE());',
    @retry_attempts = 3,
    @retry_interval = 5;
GO
-- Explanation:
-- sp_add_jobstep defines the action to perform when the job runs. You can specify retry logic for resilience.

USE msdb;
GO
-- Create a daily schedule at 1:00 AM
EXEC dbo.sp_add_schedule
    @schedule_name = N'Daily 1AM',
    @freq_type = 4,              -- 4 = daily
    @active_start_time = 10000;  -- time in HHMMSS, so 01:00:00
GO

-- Attach the schedule to the 'Nightly Cleanup' job
EXEC sp_attach_schedule
    @job_name = N'Nightly Cleanup',
    @schedule_name = N'Daily 1AM';
GO

-- Assign job to the local server
EXEC dbo.sp_add_jobserver
    @job_name = N'Nightly Cleanup';
GO
-- Explanation:
-- sp_add_schedule defines the execution frequency (daily at 1 AM).
-- sp_attach_schedule links the schedule.
-- sp_add_jobserver tells which server will run it.


