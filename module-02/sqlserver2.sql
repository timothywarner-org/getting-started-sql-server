# PowerShell example using SqlServer module

# Example 1: Import the SqlServer module (always start here)
# This module provides cmdlets for SQL Server management tasks
Import-Module SqlServer

# Example 2: Connect to SQL Server and list all databases
# Shows how to enumerate databases on SQL1 (default instance)
Get-SqlDatabase -ServerInstance 'SQL1'

# Example 3: Get SQL Server instance information
# Useful for inventory, version checks, and patching
Get-SqlInstance -ServerInstance 'SQL1'

# Example 4: Query data using T-SQL from PowerShell
# Use Invoke-Sqlcmd for ad-hoc queries and automation
Invoke-Sqlcmd -ServerInstance 'SQL1' -Database 'WideWorldImporters' -Query "SELECT TOP 5 CustomerID, CustomerName FROM Sales.Customers"

# Trust the server certificate

$query = @"
SELECT TOP (5) CustomerID, CustomerName
FROM Sales.Customers
ORDER BY CustomerID;
"@

Invoke-Sqlcmd -ConnectionString "Server=sql1;Database=WideWorldImporters;Encrypt=True;TrustServerCertificate=True;" -Query $query


# Example 5: Backup the WWI database
# Automate backups with Backup-SqlDatabase
Backup-SqlDatabase -ServerInstance 'SQL1' -Database 'WideWorldImporters' -BackupFile 'C:\Backups\WWI.bak'

# Example 6: Restore the WWI database (to a new name)
# Restore from backup file (be careful in production!)
Restore-SqlDatabase -ServerInstance 'SQL1' -Database 'WWI_Restored' -BackupFile 'C:\Backups\WWI.bak'

# Example 7: List failed SQL Agent jobs since midnight
# Monitor job failures for proactive DBA work
Get-SqlAgentJobHistory -ServerInstance 'SQL1' -Since Midnight -OutcomesType Failed

# Example 8: Add a SQL Server login (security task)
# Demonstrates basic security management
New-SqlLogin -ServerInstance 'SQL1' -LoginName 'OpsUser' -Password (ConvertTo-SecureString 'StrongPassword123!' -AsPlainText -Force)

# Example 9: Grant database access to a login
# Assigns user to WWI database and role
New-SqlUser -ServerInstance 'SQL1' -Database 'WideWorldImporters' -Login 'OpsUser' -Name 'OpsUser'
Add-SqlRoleMember -ServerInstance 'SQL1' -Database 'WideWorldImporters' -Role 'db_datareader' -Member 'OpsUser'

# Example 10: Run a SQL Server assessment
# Use built-in assessment to check for best practices
Invoke-SqlAssessment -ServerInstance 'SQL1'

# Example 11: Automate a health check script
# Run a custom health check and export results
Invoke-Sqlcmd -ServerInstance 'SQL1' -Database 'WideWorldImporters' -InputFile 'healthcheck_database_wwi.sql' | Export-Csv -Path 'C:\Reports\WWI_HealthCheck.csv' -NoTypeInformation

# Example 12: Schedule a PowerShell script as a SQL Agent job
# Automate recurring DBA tasks
# (Requires SQL Agent and permissions)
# See: https://learn.microsoft.com/en-us/sql/ssms/agent/schedule-a-job

# Example 13: Function to backup all user databases on SQL1
# Demonstrates functions, parameters, and pipeline usage
function Backup-AllUserDatabases {
  param(
    [string]$ServerInstance = 'SQL1',
    [string]$BackupFolder = 'C:\Backups'
  )
  Get-SqlDatabase -ServerInstance $ServerInstance | Where-Object { -not $_.IsSystemObject } |
  ForEach-Object {
    $dbName = $_.Name
    $backupFile = Join-Path $BackupFolder "$dbName.bak"
    try {
      Backup-SqlDatabase -ServerInstance $ServerInstance -Database $dbName -BackupFile $backupFile
      Write-Host "Backed up $dbName to $backupFile" -ForegroundColor Green
    }
    catch {
      Write-Warning "Failed to backup $dbName: $_"
    }
  }
}

# Example 14: Function to check database sizes and alert if over threshold
# Shows custom logic, error handling, and output formatting
function Check-DatabaseSizes {
  param(
    [string]$ServerInstance = 'SQL1',
    [int]$SizeThresholdMB = 1024
  )
  $results = Invoke-Sqlcmd -ServerInstance $ServerInstance -Database 'WideWorldImporters' -Query "SELECT name, size*8/1024 AS SizeMB FROM sys.master_files WHERE database_id > 4"
  $results | ForEach-Object {
    if ($_.SizeMB -gt $SizeThresholdMB) {
      Write-Warning "Database $($_.name) is $($_.SizeMB) MB, exceeds threshold of $SizeThresholdMB MB!"
    }
    else {
      Write-Host "Database $($_.name) is $($_.SizeMB) MB" -ForegroundColor Cyan
    }
  }
}

# Example 15: Use pipeline to export all user tables to CSV
# Demonstrates advanced pipeline and parameter usage
Get-SqlTable -ServerInstance 'SQL1' -Database 'WideWorldImporters' | Where-Object { -not $_.IsSystemObject } |
ForEach-Object {
  $tableName = $_.Name
  $query = "SELECT * FROM [$tableName]"
  try {
    Invoke-Sqlcmd -ServerInstance 'SQL1' -Database 'WideWorldImporters' -Query $query |
    Export-Csv -Path "C:\Exports\${tableName}.csv" -NoTypeInformation
    Write-Host "Exported $tableName to CSV" -ForegroundColor Green
  }
  catch {
    Write-Warning "Failed to export $tableName: $_"
  }
}

# Example 16: Function to disable all SQL Agent jobs except those matching a pattern
# Shows advanced filtering and error handling
function Disable-NonMatchingAgentJobs {
  param(
    [string]$ServerInstance = 'SQL1',
    [string]$KeepPattern = 'Critical'
  )
  Get-SqlAgentJob -ServerInstance $ServerInstance | Where-Object { $_.Name -notmatch $KeepPattern } |
  ForEach-Object {
    try {
      Set-SqlAgentJob -ServerInstance $ServerInstance -JobName $_.Name -Enabled $false
      Write-Host "Disabled job: $($_.Name)" -ForegroundColor Yellow
    }
    catch {
      Write-Warning "Failed to disable job $($_.Name): $_"
    }
  }
}
