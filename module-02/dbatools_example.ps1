# PowerShell example using dbatools

# Example 1: Install dbatools module (run once per system)
# dbatools is a community PowerShell module for SQL Server automation
Install-Module dbatools -Scope CurrentUser

# Example 2: Import dbatools module
Import-Module dbatools

# Example 3: List all databases on SQL1
Get-DbaDatabase -SqlInstance 'SQL1'

# Example 4: Get SQL Server instance information
Get-DbaInstanceProperty -SqlInstance 'SQL1'

# Example 5: Query data from WWI database
Invoke-DbaQuery -SqlInstance 'SQL1' -Database 'WideWorldImporters' -Query "SELECT TOP 5 CustomerID, CustomerName FROM Sales.Customers"

# Example 6: Backup the WWI database
Backup-DbaDatabase -SqlInstance 'SQL1' -Database 'WideWorldImporters' -Path 'C:\Backups'

# Example 7: Restore the WWI database (to a new name)
Restore-DbaDatabase -SqlInstance 'SQL1' -Path 'C:\Backups\WideWorldImporters*.bak' -DatabaseName 'WWI_Restored' -WithReplace

# Example 8: List failed SQL Agent jobs since midnight
Get-DbaAgentJob -SqlInstance 'SQL1' | Get-DbaAgentJobHistory | Where-Object { $_.RunStatus -ne 'Succeeded' -and $_.RunDate -ge (Get-Date).Date }

# Example 9: Add a SQL Server login (security task)
New-DbaLogin -SqlInstance 'SQL1' -Login 'OpsUser' -SecurePassword (ConvertTo-SecureString 'StrongPassword123!' -AsPlainText -Force)

# Example 10: Grant database access to a login
New-DbaDbUser -SqlInstance 'SQL1' -Database 'WideWorldImporters' -Login 'OpsUser' -Username 'OpsUser'
Add-DbaDbRoleMember -SqlInstance 'SQL1' -Database 'WideWorldImporters' -Role 'db_datareader' -User 'OpsUser'

# Example 11: Run a SQL Server health check
Test-DbaHealth -SqlInstance 'SQL1'

# Example 12: Export health check results to CSV
Test-DbaHealth -SqlInstance 'SQL1' | Export-Csv -Path 'C:\Reports\SQL1_HealthCheck.csv' -NoTypeInformation

# Example 13: Schedule a PowerShell script as a SQL Agent job
# Automate recurring DBA tasks
# See: https://docs.dbatools.io/Set-DbaAgentJob

# Advanced Example 14: Function to backup all user databases with error handling
function Backup-AllUserDbaDatabases {
  param(
    [string]$SqlInstance = 'SQL1',
    [string]$BackupPath = 'C:\Backups'
  )
  Get-DbaDatabase -SqlInstance $SqlInstance | Where-Object { -not $_.IsSystemObject } |
  ForEach-Object {
    try {
      Backup-DbaDatabase -SqlInstance $SqlInstance -Database $_.Name -Path $BackupPath
      Write-Host "Backed up $($_.Name) to $BackupPath" -ForegroundColor Green
    }
    catch {
      Write-Warning "Failed to backup $($_.Name): $_"
    }
  }
}

# Advanced Example 15: Check database sizes and alert if over threshold
function Check-DbaDatabaseSizes {
  param(
    [string]$SqlInstance = 'SQL1',
    [int]$SizeThresholdMB = 1024
  )
  Get-DbaDatabase -SqlInstance $SqlInstance | ForEach-Object {
    if ($_.SizeMB -gt $SizeThresholdMB) {
      Write-Warning "Database $($_.Name) is $($_.SizeMB) MB, exceeds threshold of $SizeThresholdMB MB!"
    }
    else {
      Write-Host "Database $($_.Name) is $($_.SizeMB) MB" -ForegroundColor Cyan
    }
  }
}

# Advanced Example 16: Export all user tables to CSV
Get-DbaDbTable -SqlInstance 'SQL1' -Database 'WideWorldImporters' | Where-Object { -not $_.IsSystemObject } |
ForEach-Object {
  $tableName = $_.Name
  try {
    Invoke-DbaQuery -SqlInstance 'SQL1' -Database 'WideWorldImporters' -Query "SELECT * FROM [$tableName]" |
    Export-Csv -Path "C:\Exports\${tableName}.csv" -NoTypeInformation
    Write-Host "Exported $tableName to CSV" -ForegroundColor Green
  }
  catch {
    Write-Warning "Failed to export $tableName: $_"
  }
}

# Advanced Example 17: Disable all SQL Agent jobs except those matching a pattern
function Disable-NonMatchingDbaAgentJobs {
  param(
    [string]$SqlInstance = 'SQL1',
    [string]$KeepPattern = 'Critical'
  )
  Get-DbaAgentJob -SqlInstance $SqlInstance | Where-Object { $_.Name -notmatch $KeepPattern } |
  ForEach-Object {
    try {
      Set-DbaAgentJob -SqlInstance $SqlInstance -Job $_.Name -Enabled $false
      Write-Host "Disabled job: $($_.Name)" -ForegroundColor Yellow
    }
    catch {
      Write-Warning "Failed to disable job $($_.Name): $_"
    }
  }
}
