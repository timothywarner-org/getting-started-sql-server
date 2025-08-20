---
source_file: getting-started-sql-server-m2.pptx
type: PowerPoint Presentation
---

<!-- Slide number: 1 -->
Using Core SQL Server Administration Tools

![A person wearing glasses and a black jacket AI-generated content may be incorrect.](PicturePlaceholder10.jpg)
Tim Warner

![A blue and white circle with text and a black background Description automatically generated](Picture10.jpg)

![A blue and white rectangular sign with white text Description automatically generated](Picture12.jpg)

![A blue and white circle with text Description automatically generated](Picture9.jpg)
Principal Author  |  IT Ops  |  Pluralsight
TechTrainerTim.com

### Notes:

<!-- Slide number: 2 -->
Navigate SSMS Object Explorer & Query Editor
Connect & Query With VS Code + MSSQL Extension
Configure Services & Protocols In Configuration Manager
Run Admin Scripts With sqlcmd & PowerShell 7

### Notes:

Bullet: Navigate SSMS Object Explorer & Query EditorBlurb: “We’ll go deeper into SQL Server Management Studio (SSMS) power moves: fast filtering, dependency checks, and script-out patterns.”
Bullet: Script-First With VS Code + MSSQL ExtensionBlurb: “We’ll tighten a Visual Studio Code workflow that’s source-controlled, predictable, and team-friendly.”
Bullet: Configure Services & Protocols In Configuration ManagerBlurb: “We’ll set a static TCP port and sanity-check the SQL Server Browser service so remote apps actually connect.”
Bullet: Automate With sqlcmd & PowerShell 7Blurb: “We’ll run repeatable checks and exports using sqlcmd and PowerShell 7 without leaving your terminal.”

<!-- Slide number: 3 -->

# Text Chunking (Five Items)

Item One
Item Two
Item Three
Item Four
Item Five

<!-- Slide number: 4 -->

# Quick Recap of SQL Server GUI Management Tools

![](Picture10.jpg)

![](Picture14.jpg)

![](Picture12.jpg)
SSMS
Object Explorer
Query Editor
VS Code
MSSQL extension
Config Manager
Services
Protocols

### Notes:

Quick Recap of SQL Server GUI Management Tools

Bullet: Revisit SSMS Object Explorer & Query EditorBlurb: We’ll breeze through this—just a nod to the tools you’ve already mastered: Object Explorer, query windows, dragging and dropping. No deep dive here.

Bullet: Recall connecting and querying with VS Code + mssql extensionBlurb: Remember how fast it is—VS Code with mssql is your lightweight editor for quick scripting without sacrificing autocomplete or snippets.

Bullet: Remember Config Manager for services and protocolsBlurb: We used Config Manager to toggle TCP/IP, set service start modes, and control network protocols—your foundation for predictable server behavior.

<!-- Slide number: 5 -->

# Query Editor: Guardrails, Not Just Queries

Set SET XACT_ABORT ON for safer transactions
BEGIN TRAN / ROLLBACK dry-runs
Actual plans + SET STATISTICS IO, TIME ON
SQLCMD mode in SSMS for variables/includes

### Notes:

Query Editor: Guardrails, Not Just Queries

Bullet: Set SET XACT_ABORT ON for safer transactionsBlurb: Turning SET XACT_ABORT ON means that any runtime error causes the whole transaction to roll back—way safer than flipping a switch in your head.

Bullet: BEGIN TRAN / ROLLBACK dry-runsBlurb: Wrap changes in BEGIN TRAN and hit rollback if needed—this is your “oops” insurance before production queries.

Bullet: Actual plans + SET STATISTICS IO, TIME ONBlurb: Flip on actual execution plans and use SET STATISTICS IO, TIME ON to get real metrics—readable, actionable insight into query cost and I/O.

Bullet: SQLCMD mode in SSMS for variables/includesBlurb: Turn on SQLCMD mode in SSMS and you can do variables, includes, and even mix T-SQL with OS commands—grown-up scripting without switching to CLI.

<!-- Slide number: 6 -->

# sqlcmd – Command-Line Scripting

Command-line tool for ad‑hoc and scripted T‑SQ
Two variants: Go‑based standalone and ODBC‑based with SQL Server
Common flags: ‑S, ‑E, ‑U, ‑P, ‑i, ‑Q, ‑o

### Notes:

Bullet: sqlcmd is a command-line tool for ad-hoc and scripted T-SQLBlurb: You know T-SQL—sqlcmd is the CLI version of SSMS: lightweight, scriptable, and perfect for those “run-then-go” tasks. Microsoft Learn+8Microsoft Learn+8SQL Shack+8Microsoft Learn

Bullet: Two variants: Go-based standalone and ODBC-based with SQL ServerBlurb: There’s a Go-based version you can grab separately and an ODBC-based one that ships with SQL Server or mssql-tools. Both run everywhere—Windows, Linux, even containers. Microsoft Learn

Bullet: Common flags: -S, -E, -U, -P, -i, -Q, -oBlurb: Flags: -S is your server, -E is Windows auth, -U/-P for SQL logins; -i runs a script, -Q runs inline queries, and -o writes output to file. Microsoft Learn

<!-- Slide number: 7 -->

# sqlcmd: Small But Mighty

-b fail on error for CI/CD
-Q for one-offs; -i for script files
-v variables + :setvar inside scripts
-s delimiter + -W trim for clean CSV

### Notes:

sqlcmd – Small But Mighty

Bullet: -b fail on error for CI/CDBlurb: Use -b so sqlcmd exits on error—critical when you're piping scripts into CI/CD pipelines or automation.

Bullet: -Q for one-offs; -i for script filesBlurb: -Q is your quick ad-hoc query tool; -i lets you run pro-level scripts from file—pick your weapon depending on the job.

Bullet: -v variables + :setvar inside scriptsBlurb: Parameterize your script with -v and :setvar—makes your scripts portable and safe for multiple environments.

Bullet: -s delimiter + -W trim for clean CSVBlurb: Want nice CSVs for reporting or ETL? Use -s to set your field separator and -W to strip padding—clean data out of the box.

<!-- Slide number: 8 -->

# sqlcmd - Sample Script

:: sqlcmd example — comment (::) –annotated; filetype .cmd
:: Connect to the local SQL Server default instance using Windows auth, run a script, output a log

sqlcmd -S ".\SQL1" -E -i "C:\Globomantics\Scripts\Cleanup.sql" -o "C:\Globomantics\Logs\Cleanup.log“

:: Flags:
::   -S : specifies the server instance
::   -E : uses Windows integrated (trusted) authentication
::   -i : inputs the SQL script file
::   -o : outputs results or errors to a log file

### Notes:

Bullet: Sample sqlcmd script with Windows auth and file inputs/outputsBlurb: This snippet shows how you run a cleanup script against your local instance, using Windows auth and logging output—perfect for nightly runs.

<!-- Slide number: 9 -->

# SQLServer Module

![](Picture9.jpg)
Provides modern cmdlets replacing legacy SQLPS
Install via Install‑Module –Name SqlServer from PowerShell Gallery
Use cmdlets like Get-SqlInstance, Backup-SqlDatabase
Supports loops, error handling, and PS objects

### Notes:

SqlServer Module – Practical PowerShell Admin

Bullet: Import-Module SqlServer for modern cmdletsBlurb: This module replaces the old SQLPS—clean, updated cmdlets that let you query, backup, manage security, and more—all from PowerShell.

Bullet: Install-Module SqlServer via PowerShell GalleryBlurb: One-liner install from PowerShell Gallery—Install-Module SqlServer—no installer spam, just instant access to automation scripts.

Bullet: Use cmdlets like Get-SqlInstance, Backup-SqlDatabaseBlurb: Need to list instances or run a backup? Cmdlets named Get-SqlInstance or Backup-SqlDatabase are literally what they sound like—intuitive and script-friendly.

Bullet: Supports loops, error handling, and PS objectsBlurb: PowerShell handles loops, try/catch, and returns objects—not text—so your automation is robust, programmable, and reusable.

<!-- Slide number: 10 -->

# SqlServer Module – Sample Code

# SqlServer module example — annotated

Import-Module –Name SqlServer

# Run a quick GETDATE query and capture execution details

Invoke-Sqlcmd -ServerInstance ".\SQL1" -Database "Globomantics"
  -Query "SELECT GETDATE() AS CurrentTime;" -Verbose -StatisticsVariable stats

# ‘Verbose’ shows PRINT output, ‘StatisticsVariable’ provides execution info

### Notes:

Bullet: Example showing Import‑Module and Invoke‑Sqlcmd with verbose and statsBlurb: Here you import the module, run a simple date query, get print outputs, and capture stats like rows affected — all inside PowerShell with context and control.

<!-- Slide number: 11 -->

# dbatools – Community PowerShell Super-Module

500+ open-source cmdlets covering nearly every DBA task

![gear-powershell](Picture2.jpg)
Built and battle-tested by SQL pros

![gear-powershell](Picture4.jpg)
Cmdlets like Test-DbaConnection, Copy-DbaDatabase

![gear-powershell](Picture6.jpg)
Great for repeatable cross-server tasks

![gear-powershell](Picture8.jpg)

### Notes:

Bullet: 500+ open-source cmdlets covering nearly every DBA taskBlurb: dbatools is a DBAs power collection—backup, restore, clone, migration—you name it, a cmdlet exists. Real impact with minimal code.

Bullet: Built and battle-tested by SQL prosBlurb: This isn’t hobby code—it’s backed by MVPs, Microsoft engineers, and real DBAs. Trust it’s solid before you trust your script to it.

Bullet: Cmdlets like Test-DbaConnection, Copy-DbaDatabaseBlurb: Short, logical cmdlet names like Test-DbaConnection or Copy-DbaDatabase make scripts nearly self-documenting—so anyone on your team gets it.

Bullet: Great for repeatable cross-server tasksBlurb: Everyday operations across hundreds of servers? dbatools gives you remote copy, schema sync, integrity checks in seconds—not hours.

<!-- Slide number: 12 -->

# dbatools – Sample Code

# dbatools example — annotated

Install-Module –Name dbatools
Import-Module –Name dbatools

# Test connection and backup a database in one command

Test-DbaConnection -SqlInstance "localhost\SQLEXPRESS"
Backup-DbaDatabase -SqlInstance "localhost\SQLEXPRESS" `
  -Database "Globomantics" -Path "C:\Globomantics\Backup" –CopyOnly

# These are single-line simplifies of multi-step tasks

### Notes:

Speaker Notes:
Bullet: Example using Test-DbaConnection and Backup-DbaDatabase in a single workflowBlurb: With dbatools, testing connectivity and backing up a database is a one-liner—no scripting gymnastics, high confidence execution with best-practice defaults.

<!-- Slide number: 13 -->

# Field-tested Combos (Do This in the Real World)

SSMS script-out → VS Code review → sqlcmd run
Static port + connection string update = fewer pages
Daily baseline with PowerShell → JSON artifact
CMS query for estate-wide settings drift

### Notes:

Bullet: SSMS script-out → VS Code review → sqlcmd runBlurb: Workflow: script it in SSMS, polish it in VS Code, then deploy via sqlcmd—that’s how you maintain quality and speed.

Bullet: Static port + connection string update = fewer help-desk pagesBlurb: Fix your port once, bake it into connection strings—suddenly your help-desk isn’t fielding “can’t connect” calls all day.

Bullet: Daily baseline via PowerShell → JSON artifactBlurb: Scripting daily stats and saving to JSON—boom, automatic baseline tracking for performance slide downs or complaints.

Bullet: CMS query for estate-wide settings driftBlurb: Use Central Management Server to run a query across all servers—ideal for catching rogue configuration drift on 50+ instances.
.”

<!-- Slide number: 14 -->

# Demo

### Notes:

Context: Windows 11, SQL Server 2022 Developer, database GlobomanticsImports. You are the senior DBA at Globomantics Imports.
1) SSMS Setup & Object Explorer (2:30)
Open SSMS → Connect localhost (Windows auth).
Registered Servers: View → Registered Servers → create Local, Prod, NonProd groups; add localhost.
Color Status Bar: Options → Text Editor → Editor Tab/Status Bar → enable custom color per server (set non-prod neutral; mention prod = red).
Object Explorer Details: Press F7 on Tables; filter by Customer to show fast discovery.
Script-Out Defaults: Tools → Options → SQL Server Object Explorer → Scripting: check Include IF EXISTS, Script DROP and CREATE.
Dependencies: Right-click a proc → View Dependencies (note limitations; dynamic SQL caveat).
DAC: Connect dialog → Server name ADMIN:localhost (don’t connect; just show where it lives).
2) Query Editor Guardrails (1:30)
Open New Query, set DB to GlobomanticsImports, paste:
sql
CopyEdit
-- Safer error semantics SET XACT_ABORT ON; -- Dry-run pattern BEGIN TRAN; -- Inspect target first SELECT COUNT(*) AS RowsToChange FROM Sales.Customers WHERE CustomerName LIKE N'%Ltd%'; -- Example change (commented) -- UPDATE Sales.Customers SET PhoneNumber = NULL WHERE CustomerName LIKE N'%Ltd%'; ROLLBACK; -- or COMMIT after verifying
Then enable Actual Execution Plan (Ctrl+M) and:
sql
CopyEdit
SET STATISTICS IO, TIME ON; SELECT TOP 10 * FROM Sales.Customers ORDER BY CustomerID; SET STATISTICS IO, TIME OFF;
Explain reading IO/TIME quickly.
3) VS Code + MSSQL Team Workflow (1:30)
Open VS Code → install “SQL Server (mssql)” if needed.
Connection Profile: Ctrl+Shift+P → MS SQL: Manage Connection Profiles → create localhost / GlobomanticsImports.
Repo Conventions: Create folder C:\github\globomantics-admin\sql.
New file: health-check.sql:
sql
CopyEdit
SELECT DB_NAME() AS DbName, (SELECT COUNT(*) FROM Sales.Customers) AS CustomerCount, (SELECT SUM(size)*8 FROM sys.database_files WHERE type_desc='ROWS') AS DataMB;
Run (play button) → Save.
Optional: create .vscode/settings.json with default connection/database for the workspace.
4) Configuration Manager: Predictable Connectivity (1:00)
Open SQL Server Configuration Manager.
Services: Confirm SQL Server (MSSQLSERVER) running; SQL Server Agent running/disabled per policy.
Protocols: SQL Server Network Configuration → Protocols for MSSQLSERVER → Enable TCP/IP.
Static Port: TCP/IP → Properties → IPAll → TCP Port = 1433 (example) → OK → restart service.
SQL Server Browser: Services → set Automatic only if you need named instance discovery; otherwise Disabled + static port.
5) sqlcmd: Checks & Exports (0:45)
Open Windows Terminal:
powershell
CopyEdit

# One-off version check sqlcmd -S localhost -E -Q "SELECT @@SERVERNAME AS ServerName, @@VERSION AS Version;" # Export a CSV from our repo script sqlcmd -S localhost -E -d GlobomanticsImports -i "C:\github\globomantics-admin\sql\health-check.sql" -s "," -W -o "C:\Temp\health-check.csv" # CI-friendly: fail on error sqlcmd -S localhost -E -Q "SELECT 1/0" -b; echo $LASTEXITCODE

6) PowerShell 7: Inventory & Sanity (0:45)
powershell
CopyEdit

# Ensure modules (first time only) Install-PackageProvider NuGet -Force Set-PSRepository PSGallery -InstallationPolicy Trusted Install-Module SqlServer -Force Install-Module dbatools -Force # optional but recommended # Quick connection + count with Invoke-Sqlcmd Invoke-Sqlcmd -ServerInstance localhost -Database GlobomanticsImports -Query "SELECT COUNT(*) AS CustomerCount FROM Sales.Customers" # Fleet-ready checks with dbatools (example) "localhost" | Test-DbaConnection Get-DbaDatabase -SqlInstance localhost | Where-Object IsSystemObject -eq $false | Select-Object Name, Owner, CreateDate

7) Wrap (0:30)
“We hardened SSMS with CMS, filters, and script options; guarded ourselves with XACT_ABORT, transactions, and quick perf reads; standardized VS Code for the team; locked in a static port so apps connect; and automated checks with sqlcmd + PowerShell.”