---
source_file: getting-started-sql-server-m1-BENTLEY.pptx
type: PowerPoint Presentation
---

<!-- Slide number: 1 -->
Getting Started withSQL Server Administration
Connecting to and Exploring SQL Server Instances

![A person wearing glasses and a black jacket AI-generated content may be incorrect.](PicturePlaceholder10.jpg)
Tim Warner

![A blue and white circle with text and a black background Description automatically generated](Picture10.jpg)

![A blue and white rectangular sign with white text Description automatically generated](Picture12.jpg)

![A blue and white circle with text Description automatically generated](Picture9.jpg)
Principal Author  |  IT Ops  |  Pluralsight
TechTrainerTim.com

### Notes:

<!-- Slide number: 2 -->
Connect to local & remote instances (SSMS, VS Code MSSQL)
Use T-SQL to create, query & modify data
Explore databases & server settings in SSMS
Check services & protocols in Config Manager

### Notes:

Bullet: Connect To Local & Remote Instances (SSMS, VS Code MSSQL)Blurb: “We’ll connect using SQL Server Management Studio (SSMS) and Visual Studio Code (VS Code) with the Microsoft SQL (MSSQL) extension so you’re fluent in both the GUI and the script-first workflows—on your box and on remote servers.”
Bullet: Use T-SQL To Create, Query & Modify DataBlurb: “You’ll run core Transact-SQL (T-SQL)—create a database and table, then SELECT, INSERT, UPDATE, and DELETE—using safe admin patterns.”
Bullet: Explore Databases & Server Settings In SSMSBlurb: “We’ll navigate Object Explorer to read server-level configuration, security, and database objects—observing first, changing later.”
Bullet: Check Services & Protocols In Config ManagerBlurb: “We’ll verify the SQL Server service, SQL Server Agent, and network protocols fast with SQL Server Configuration Manager.”

<!-- Slide number: 3 -->

# Course Overview

Connecting to and Exploring SQL Server Instances
Using Core SQL Server Administration Tools
Understanding SQL Server Architecture and Core Components

### Notes:

Bullet: Connecting to and Exploring SQL Server InstancesBlurb: “First, we’ll connect to SQL Server 2022 using SQL Server Management Studio and Visual Studio Code with the MSSQL extension. You’ll run basic Transact-SQL commands to create, query, and modify data, and you’ll navigate Object Explorer so you can safely explore databases, objects, and server-level settings without breaking anything.”

Bullet: Using Core SQL Server Administration ToolsBlurb: “Next, we’ll use the core administration toolset: SSMS, VS Code, SQL Server Configuration Manager, sqlcmd, and PowerShell 7. You’ll manage services, configure network protocols, run administrative scripts, and handle the kinds of day-to-day tasks you’ll face as a SQL Server administrator.”

Bullet: Understanding SQL Server Architecture and Core ComponentsBlurb: “Finally, we’ll explore SQL Server’s architecture—looking at the Database Engine, SQL Server Agent, and other services. We’ll cover how databases, log files, pages, and extents are organized, where SSAS, SSIS, and SSRS fit in, and how to use core DDL and DML commands to manage and administer your environment.”

<!-- Slide number: 4 -->

# Current SQL Server Tooling Landscape

SSMS: primary admin workbench (latest 20/21 builds)
VS Code + MSSQL: lightweight, cross-platform querying
Azure Data Studio: retiring; migrate workflows to VS Code
Keep SSMS and MSSQL extension updated for security and MFA

### Notes:

Bullet: SSMS: Primary Admin Workbench (Latest 20/21 Builds)
Blurb: “SQL Server Management Studio remains the day-to-day admin cockpit—wizards, execution plans, registered servers, and modern auth support in the latest releases.”

Bullet: VS Code + MSSQL: Lightweight, Cross-Platform QueryingBlurb: “VS Code plus the MSSQL extension gives fast startup, IntelliSense, and source-controlled .sql—great for repeatable admin scripts.”

Bullet: Azure Data Studio: Retiring; Migrate Workflows To VS CodeBlurb: “Azure Data Studio (ADS) is officially retiring; Microsoft’s guidance is to transition workflows to VS Code + MSSQL.”

Bullet: Keep SSMS & MSSQL Extension Updated For Security & MFABlurb: “Upgrading buys bug/security fixes and Multi-Factor Authentication (MFA) compatibility for Microsoft Entra ID (formerly Azure AD).”

<!-- Slide number: 5 -->

# Quick Connect: SSMS

![](Picture2.jpg)
Server naming: Server or Server\Instance
Preferred auth: Windows (use SQL logins when needed)
Test query habit: SELECT @@VERSION;
Save registered servers for repeatable access

### Notes:

Bullet: Server Naming: Server Or Server\InstanceBlurb: “Default instance = just the host; named instance = Host\Instance. Saved connections reduce fat-finger risk.”

Bullet: Preferred Auth: Windows (Use SQL Logins When Needed)Blurb: “Use Windows/Entra ID authentication for least friction and policy alignment; keep SQL logins for legacy/cross-domain scenarios.”

Bullet: Test Query Habit: SELECT @@VERSION;Blurb: “One quick query confirms connectivity and shows engine version/build.”

Bullet: Save Registered Servers For Repeatable AccessBlurb: “Registered Servers in SSMS make common endpoints one-click and consistent.”

<!-- Slide number: 6 -->

# Quick Connect: VS Code

Profile-backed connections; integrated auth support
Query files in repo; source-control your .sql
Result grids, plan viewing, IntelliSense
Great for script-first, cross-platform teams

![](Picture2.jpg)

### Notes:

Bullet: Profile-Backed Connections; Integrated Auth SupportBlurb: “Create a connection profile once, then reuse it—supports Integrated/Entra auth and SQL logins.”

Bullet: Query Files In Repo; Source-Control Your .sqlBlurb: “Keep every change in Git to diff, review, and roll back safely.”

Bullet: Result Grids, Plan Viewing, IntelliSenseBlurb: “Modern editing with exportable results and execution plan viewing inside VS Code.”

Bullet: Great For Script-First, Cross-Platform TeamsBlurb: “Same experience on Windows, macOS, and Linux—useful across mixed estates.”

<!-- Slide number: 7 -->

# First T-SQL for Admins (Safe Patterns)

DDL: CREATE DATABASE, CREATE TABLE
DML: INSERT, UPDATE, DELETE, SELECT
Preview before change: SELECT target rows first
Save/rerun scripts; parameterize where sensible

### Notes:

Bullet: DDL: CREATE DATABASE, CREATE TABLEBlurb: “We’ll scaffold a tiny lab database + table so you can practice freely.”

Bullet: DML: INSERT, UPDATE, DELETE, SELECTBlurb: “Manipulate rows safely and verify outcomes quickly.”

Bullet: Preview Before Change: SELECT Target Rows FirstBlurb: “Always preview the exact rows you’ll modify—this habit prevents most ‘oops’ moments.”

Bullet: Save/Rerun Scripts; Parameterize Where SensibleBlurb: “Persist scripts; use variables/parameters for repeatable, auditable operations.”

<!-- Slide number: 8 -->

# Explore with SSMS Object Explorer

Server scope: logins, linked servers, agent, endpoints

Database scope: tables, views, procs, security

Right-click → script changes before executing

Read-only mindset in prod; practice in lab

### Notes:

Bullet: Server Scope: Logins, Linked Servers, Agent, EndpointsBlurb: “At the top level, you’ll assess security, cross-server links, automation via SQL Agent, and endpoint config.”

Bullet: Database Scope: Tables, Views, Procs, SecurityBlurb: “Inside a database, you’ll navigate the data surface and its code surface—plus database-scoped security.”

Bullet: Right-Click → Script Changes Before ExecutingBlurb: “Script-first gives you a record, lets you review, and makes changes reproducible.”

Bullet: Read-Only Mindset In Prod; Practice In LabBlurb: “Explore safely in production; test in non-prod before you touch real users’ data.”

<!-- Slide number: 9 -->

# Services and Connectivity

SQL Server Configuration Manager
Verify SQL Server and SQL Agent service state
Enable TCP/IP; restart after protocol changes
Default port 1433 (check firewalls/profiles)
Fast triage: service running + TCP/IP enabled = 80% fix

![](Picture2.jpg)

### Notes:

Bullet: Verify SQL Server & SQL Agent Service StateBlurb: “Most ‘SQL is down’ tickets are stopped services—confirm the Database Engine and (optional) SQL Server Agent are running.”

Bullet: Enable TCP/IP; Restart After Protocol ChangesBlurb: “Ensure TCP/IP (Transmission Control Protocol/Internet Protocol) is enabled; protocol changes require a Database Engine restart to take effect.” Microsoft Learn

Bullet: Default Port 1433 (Named Instances Use Dynamic Ports)Blurb: “Default instances listen on TCP 1433; named instances use dynamic ports unless you set a static one—plan firewall rules accordingly.” Microsoft Learn

Bullet: Fast Triage: Service Running + TCP/IP EnabledBlurb: “That two-step check resolves a surprising number of first-day connectivity issues.”

<!-- Slide number: 10 -->

# Copilot in SSMS

Optional component in SSMS 21; AI help for T-SQL
Ask natural-language questions about your DB
Draft/explain/fix T-SQL; treat as scaffolding, not gospel
Microsoft Learn docs: data isn’t retained/used for training

### Notes:

Bullet: Optional Component In SSMS 21Blurb: “Copilot in SSMS is available as an optional component in SSMS 21—opt in if you want AI assistance inside SSMS.” TECHCOMMUNITY.MICROSOFT.COM+1

Bullet: Ask Natural-Language Questions About Your DBBlurb: “Use plain English to get help writing, explaining, or fixing T-SQL; Copilot uses your connection and database context to draft answers.” TECHCOMMUNITY.MICROSOFT.COM

Bullet: Draft/Explain/Fix T-SQL; Treat As ScaffoldingBlurb: “Treat AI output like a junior teammate’s draft—review and test before running.”

Bullet: Privacy: Copilot In SSMS Doesn’t Retain Your DataBlurb: “Per Microsoft’s documentation, prompts and responses aren’t retained or used to train models.” Microsoft Learn

<!-- Slide number: 11 -->

# PowerShell for DBAs: dbatools + SqlServer

Goal
Cross-platform dev environment
PowerShell 7+
dbatools
Community PowerShell module
Hundreds of administrative cmdlets
Install-Module –Name dbatools –Scope CurrentUser
SqlServer
Microsoft PowerShell module
First-party cmdlets with support
Invoke-SqlCmd
SMO
Pick per task
One-to-many ops: dbatools
Fine-grained config: SqlServer

### Notes:

Bullet: dbatools: Community Module, Hundreds Of Admin CmdletsBlurb: “dbatools is an open-source, community PowerShell module with hundreds of commands for migration, checks, and one-to-many admin.”

Bullet: Cross-Platform Support (PowerShell 7+)Blurb: “dbatools works on Windows, Linux, and macOS; in PowerShell Core (7.x) it’s a smooth fit for mixed estates.”

Bullet: SqlServer Module: First-Party Cmdlets (Invoke-Sqlcmd, SMO)Blurb: “The SqlServer module is Microsoft’s first-party cmdlet set; under the hood it exposes SQL Server Management Objects (SMO)—a .NET object model for programmatic SQL Server admin.”

Bullet: Pick Per Task: One-To-Many vs. Fine-GrainedBlurb: “Use dbatools for large, repeatable operations; use SqlServer + SMO for precise, scripted changes.”

<!-- Slide number: 12 -->

# Common Day 1 Pitfalls (Reluctant DBA Edition)

Can’t connect: service stopped, TCP/IP disabled, firewall block
Login failed: wrong DB default, orphaned user, disabled login
Slow/busy: Activity monitoring ≠ root cause; check waits/blocks later

### Notes:

Bullet: “Can’t Connect”: Service Stopped, TCP/IP Disabled, Firewall BlockBlurb: “Verify services, confirm TCP/IP enabled, and check firewall—these are the usual suspects.”

Bullet: “Login Failed”: Wrong DB Default, Orphaned User, Disabled LoginBlurb: “Map server logins to database users, confirm the default database exists, and check disabled/expired credentials.”

Bullet: “Slow/Busy”: Activity Monitor ≠ Root CauseBlurb: “Treat Activity Monitor as a hint, then verify with Dynamic Management Views (DMVs) and waits analysis before changing anything.”

Bullet: Rule: Observe First, Script Changes, Apply In Non-ProdBlurb: “Curious is good; reckless is expensive—script and test before prod.”

<!-- Slide number: 13 -->

# Demo

Let’s put our new skills into action!

### Notes:

“In this demo, we’re going to put our new skills into action. You’ll see me connect to a SQL Server 2022 instance from both SQL Server Management Studio and Visual Studio Code, using the WideWorldImporters sample database. We’ll run some safe T-SQL commands to create and modify data, take a guided tour of Object Explorer, and then jump into SQL Server Configuration Manager to verify services and enable TCP/IP. By the end of this short walkthrough, you’ll know exactly how to explore a SQL Server instance confidently and without risking production data.”

<!-- Slide number: 14 -->
You can connect, query, explore, and verify services
Use SSMS for admin; VS Code For script velocity
Know ADS is sunsetting; plan your shift to VS Code
Next: deeper admin workflows (storage, security, jobs)

### Notes:

Bullet: You Can Connect, Query, Explore, And Verify ServicesBlurb: “You’ve got the essentials to stop the bleeding and gather facts on day one.”

Bullet: Use SSMS For Admin, VS Code For Script VelocityBlurb: “Split your workflow: GUI breadth in SSMS; repeatable precision in VS Code + MSSQL.”

Bullet: Know ADS Is Sunsetting; Plan Your Shift To VS CodeBlurb: “Future-proof your toolchain and avoid stranding learners or teams on retiring software.” Microsoft Learn

Bullet: Next: Deeper Admin Workflows (Storage, Security, Jobs)Blurb: “From here we dig into storage layout, security roles, and automation so you can run a clean, resilient environment.”