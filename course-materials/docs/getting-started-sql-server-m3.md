---
source_file: getting-started-sql-server-m3.pptx
type: PowerPoint Presentation
---

<!-- Slide number: 1 -->
Understanding SQL Server Architecture andCore Components

![A person wearing glasses and a black jacket AI-generated content may be incorrect.](PicturePlaceholder10.jpg)
Tim Warner

![A blue and white circle with text and a black background Description automatically generated](Picture10.jpg)

![A blue and white rectangular sign with white text Description automatically generated](Picture12.jpg)

![A blue and white circle with text Description automatically generated](Picture9.jpg)
Principal Author  |  IT Ops  |  Pluralsight
TechTrainerTim.com

### Notes:

<!-- Slide number: 2 -->
Database Engine, Agent, And Key Services
Database Files, Filegroups, And Transaction Logs
Pages And Extents: How Storage Works
SSAS, SSIS, SSRS In The Ecosystem
T-SQL Foundations For Admins (DDL & DML)

### Notes:

Bullet: Database Engine, Agent, And Key ServicesBlurb: “We’ll place the Database Engine, SQL Server Agent, and supporting services in context so you know what does what.”
Bullet: Database Files, Filegroups, And Transaction LogsBlurb: “You’ll learn how data and logs live on disk—so growth, backup, and recovery make sense.”
Bullet: Pages And Extents: How Storage WorksBlurb: “We’ll translate 8-KB pages and 64-KB extents into practical admin signals.”
Bullet: SSAS, SSIS, SSRS In The EcosystemBlurb: “We’ll identify where analytics, integration, and reporting fit—so you route tickets correctly.”
Bullet: T-SQL Foundations For Admins (DDL & DML)Blurb: “We’ll close with the essential language patterns you’ll use daily as a DBA.”

<!-- Slide number: 3 -->
What is SQL Server Made Of?
Database Engine: the core service that runs your databases
SQL Server Agent: runs jobs like backups or cleanup tasks
Browser Service: helps remote clients find named instances

![](Picture2.jpg)

### Notes:

BULLET: Database Engine: the core service that runs your databasesBLURB: “The Database Engine handles every query and stores all your data. Think of it as the heart of SQL Server—without it, nothing else runs.”

BULLET: SQL Server Agent: runs jobs like backups or cleanup tasksBLURB: “SQL Server Agent automates work through scheduled jobs. Common tasks include nightly backups and index maintenance.”

BULLET: Browser Service: helps remote clients find named instancesBLURB: “The Browser service tells client apps how to connect to a named instance. It’s often disabled in locked-down environments for security.”

<!-- Slide number: 4 -->
What is SQL Server Made Of?
Optional extras: Full-Text Search, PolyBase, Machine Learning
Each service runs independently and can be started/stopped

![](Picture2.jpg)

### Notes:

BULLET: Optional extras: Full-Text Search, PolyBase, Machine LearningBLURB: “These are add-on services that expand SQL Server beyond the basics. Use them for specialized workloads like searching text or running Python and R inside the database.”

BULLET: Each service runs independently and can be started/stoppedBLURB: “Each service is its own Windows process. That means you can monitor, patch, or restart them independently.”

<!-- Slide number: 5 -->

# ACID Properties: The Relational Data Model

![](Picture14.jpg)

### Notes:

“Let’s walk through the ACID properties — the foundation of the relational data model.

Atomicity means a transaction is all or nothing. If one step fails, the entire unit of work rolls back, protecting data integrity.

Consistency ensures that every transaction moves the database from one valid state to another. Business rules and constraints are always enforced, so you never end up with half-baked data.

Isolation guarantees that concurrent transactions don’t interfere with each other. Think of it as guardrails that prevent dirty reads, lost updates, and other anomalies.

Finally, Durability means once a transaction commits, it sticks — even if the server crashes. The log guarantees that committed data will be there when you restart.

Together, ACID explains why relational systems like SQL Server are trusted for critical enterprise workloads.”

<!-- Slide number: 6 -->

# What’s Inside a SQL Server Database?

![database-storage](Picture2.jpg)
MDF = Main data file (stores tables, views, indexes)
LDF = Log file (tracks every change before it’s committed)

![database-storage](Picture4.jpg)
NDF = Extra data files (optional for large databases)

![database-storage](Picture6.jpg)
Filegroups help organize storage into logical chunks

![database-storage](Picture8.jpg)
Keep data and log files on different drives when possible

![database-storage](Picture10.jpg)

### Notes:

BULLET: MDF = Main data file (stores tables, views, indexes)BLURB: “Every database starts with one MDF file. This is where your actual data lives.”

BULLET: LDF = Log file (tracks every change before it’s committed)BLURB: “SQL Server logs every change first before it changes your data. This allows rollback and recovery.”

BULLET: NDF = Extra data files (optional for large databases)BLURB: “You can add extra NDF files if your database grows really large or you want to split it across drives.”

BULLET: Filegroups help organize storage into logical chunksBLURB: “Think of filegroups like folders—useful when you want to keep archived data separate or tune performance.”

BULLET: Keep data and log files on different drives when possibleBLURB: “Best practice: don’t put data and log files on the same drive. It reduces contention and improves recovery.”

<!-- Slide number: 7 -->

# What’s the Transaction Log, and Why Should I Care?

SQL Server logs every change before applying it
Log is used for backup, rollback, and recovery
Simple, Full, Bulk-Logged recovery models
If the log can’t truncate, it grows forever
Virtual Log Files (VLFs) affect recovery time

### Notes:

BULLET: SQL Server logs every change before applying itBLURB: “This is called write-ahead logging. Every INSERT, UPDATE, or DELETE goes to the log first to guarantee recoverability.”

BULLET: Log is used for backup, rollback, and recoveryBLURB: “The log enables you to roll back failed transactions and replay committed ones after a crash. It’s also the foundation of point-in-time restores.”

BULLET: Recovery models: Simple, Full, Bulk-LoggedBLURB: “The recovery model defines how the log behaves. Simple skips log backups, Full requires them, and Bulk-Logged is optimized for large imports.”

BULLET: If the log can’t truncate, it grows foreverBLURB: “SQL Server reuses log space only when certain conditions are met. If reuse is blocked, the log just keeps growing until you fix the cause.”

BULLET: Virtual Log Files (VLFs) affect recovery timeBLURB: “The log is divided internally into chunks called VLFs. Too many small VLFs slow down crash recovery and log backups.”

<!-- Slide number: 8 -->

# How SQL Server Stores Your Data on Disk

![hard-drive](Picture2.jpg)
Data is stored in 8 KB pages
8 pages = 1 extent (64 KB chunk)
Heaps = unordered pages
Clustered indexes = ordered by key
SQL tracks usage with allocation maps

### Notes:

BULLET: Data is stored in 8KB pagesBLURB: “Everything in SQL Server lives in a page—whether it’s a row of a table or an index entry.”

BULLET: 8 pages = 1 extent (64KB chunk)BLURB: “Most I/O happens in these 64KB extents. SQL grabs them when it needs more space.”

BULLET: Heaps = unordered pagesBLURB: “A heap is just a pile of rows with no order. They’re fast to write but slow to search.”

BULLET: Clustered indexes = ordered by keyBLURB: “A clustered index sorts your table by a specific column. That makes searches faster.”

BULLET: SQL tracks usage with allocation mapsBLURB: “Behind the scenes, SQL uses maps to keep track of which pages are full or free.”

<!-- Slide number: 9 -->

# SQL Server Physical Storage Architecture

![](Picture2.jpg)

### Notes:

“SQL Server stores data in 8-KB pages that get grouped into 64-KB extents. Over time, inserts and updates can cause pages to split apart, leaving related rows scattered across the file. That’s what we call fragmentation, and it makes scans less efficient.

On the log side, every change is captured first in the transaction log—that’s write-ahead logging. The recovery model you pick determines how SQL Server reuses that log. In Full recovery, the log won’t truncate until you back it up, which gives you point-in-time restores but requires log backup discipline. In Simple recovery, SQL Server truncates automatically after checkpoints, so the log won’t grow forever, but you lose point-in-time recovery. Bulk-logged sits in between—handy for large data loads.

As a DBA, keep an eye on both: fragmentation tells you when index maintenance is needed, and the recovery model defines your log backup and restore strategy. Get those two right and you’ve avoided two of the most common pitfalls new DBAs run into.”

<!-- Slide number: 10 -->

# What Are SSIS, SSRS, and SSAS?

![](Picture14.jpg)

![](Picture12.jpg)

![](Picture10.jpg)

SSIS
Integration Services
ETL (Extract, Transform, Load)
SSRS
Reporting Services
Build reports
SSAS
Analysis Services
BI models and KPIs

### Notes:

SSIS (SQL Server Integration Services)
Every day at companies, SSIS is the backbone of moving messy files—CSV dumps, Excel sheets, ERP exports—into clean, structured databases.
“We use SSIS to load incomplete data from various platforms—Salesforce, other databases, even junky Excel—into SQL Server, then hand it off to stored procs or produce new files.”

SSRS (SQL Server Reporting Services)
Think of SSRS as the waiter in a restaurant—it presents polished, interactive or paginated reports from SQL Server data to your users.It runs as a server-based tool with a web GUI, letting folks schedule, email, and export reports—whether it’s PDF, Excel, or HTML.

SSAS (SQL Server Analysis Services)
SSAS is your storage manager, organizing data into cubes or models for fast, multi-dimensional querying.This is the engine behind dashboards and BI tools—powering hierarchy slicing, drill-down analytics, and decision support across reports and Excel or Power BI.

<!-- Slide number: 11 -->

# T-SQL for Admin Tasks (Beyond the Basics)

Use CREATE LOGIN and CREATE USER to manage access
System stored procs (sp_helpdb, sp_whoisactive) help with diagnostics
DMVs (Dynamic Management Views) expose live health info
ALTER DATABASE lets you change file growth, recovery model, options

### Notes:

BULLET: Use CREATE LOGIN and CREATE USER to manage accessBLURB: “At some point you’ll need to add people. CREATE LOGIN adds them at the server level, and CREATE USER maps them inside a database.”

BULLET: System stored procs (sp_helpdb, sp_whoisactive) help with diagnosticsBLURB: “These are prebuilt utilities. sp_helpdb shows database sizes and settings. sp_whoisactive—a free but essential add-on—shows who’s running queries right now.”

BULLET: DMVs (Dynamic Management Views) expose live health infoBLURB: “DMVs are built-in tables you can query for metrics: CPU usage, waits, index fragmentation. Example: sys.dm_exec_requests shows what queries are running.”

BULLET: ALTER DATABASE lets you change file growth, recovery model, optionsBLURB: “DDL isn’t just for creating. With ALTER DATABASE you can move a DB into SIMPLE recovery, grow a file, or set it to READ_ONLY.”

<!-- Slide number: 12 -->
EXEC sp_helpdb N'WorldWideImporters’;

SELECT log_reuse_wait_desc
FROM sys.databases
WHERE name = N'WorldWideImporters’;

ALTER DATABASE WorldWideImporters
SET RECOVERY SIMPLE;

System stored procedure that quickly shows file locations, sizes, and recovery model for a database

DMV that tells you why the transaction log can’t clear space – key to preventing runaway log growth

DDL that switches to Simple recovery model – useful for dev/test environments where point-in-time (PIT) restores aren’t needed

### Notes:

<!-- Slide number: 13 -->

# Demo

### Notes:

<!-- Slide number: 14 -->

# For Further Learning @ Pluralsight

![retro-pluralsight](Picture2.jpg)
SQL Server: Transact-SQL Basic Data Retrieval
T-SQL Data Manipulation Playbook

![retro-pluralsight](Picture4.jpg)
SQL Server Security Fundamentals

![retro-pluralsight](Picture6.jpg)
Securing SQL Server Applications

![retro-pluralsight](Picture8.jpg)
Capturing Logic with Stored Procedures in T-SQL

![retro-pluralsight](Picture10.jpg)

### Notes:

BULLET: SQL Server: Transact-SQL Basic Data Retrieval (Joe Sack)BLURB: Joe Sack, a Program Manager on the SQL Server and Azure SQL team at Microsoft, teaches how to craft SELECT statements—from simple to multi-source queries—using more than fifty demos to cement understanding Reddit+4Pluralsight+4Classpert+4.

BULLET: T-SQL Data Manipulation Playbook (Xavier Morera)BLURB: Xavier Morera guides you through the essential Data Manipulation Language (DML): INSERT, UPDATE, DELETE, plus transactions and lesser-known T-SQL patterns for safe, real-world data editing Pluralsight.

BULLET: SQL Server Security Fundamentals (Author: Pinal Dave)BLURB: Pinal Dave, an SQL Server performance & security expert with over two decades of experience, walks learners through securing server and database layers—a must for IT Ops teams managing sensitive data Pluralsight.

BULLET: Securing SQL Server Applications (Author: Pinal Dave)BLURB: Also authored by Pinal Dave, this course dives into application-layer defense strategies—covering secure access, CLR code, and encryption practices DAG-based operations for building hardened SQL Server applications.

BULLET: Capturing Logic with Stored Procedures in T-SQL (Author: Pinal Dave)BLURB: In this session, Pinal Dave explains how to encapsulate logic in T-SQL stored procedures—making your operational tasks reusable, auditable, and maintainable across your environment.

<!-- Slide number: 15 -->
You can name each service and its job
You understand files, filegroups, and logs
You can read page/extent health signals
You know where SSAS/SSIS/SSRS fit
You have safe T-SQL patterns for admin

### Notes:

Bullet: You Can Name Each Service And Its JobBlurb: “You know who does what, so you’ll route and troubleshoot faster.”
Bullet: You Understand Files, Filegroups, And LogsBlurb: “Growth, backup, and restore decisions now have context.”
Bullet: You Can Read Page/Extent Health SignalsBlurb: “You’ve got quick DMVs to spot fragmentation or bloat.”
Bullet: You Know Where SSAS/SSIS/SSRS FitBlurb: “You won’t burn time debugging the wrong service.”
Bullet: You Have Safe T-SQL Patterns For AdminBlurb: “Change with confidence and receipts.”

<!-- Slide number: 16 -->

# Thank you for your time!

![](PicturePlaceholder7.jpg)
Tim Warner   |   TechTrainerTim.com

### Notes: