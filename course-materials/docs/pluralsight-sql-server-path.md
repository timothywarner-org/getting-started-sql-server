---
source_file: pluralsight-sql-server-path.docx
type: Word Document
---

SQL Server Administration

**Path Description:**

# Course 1: Getting Started with SQL Server Administration

**Course Description:** This foundational course introduces individuals to the SQL Server ecosystem, its underlying architecture, and the essential tools utilized for administration. It encompasses initial setup, connectivity, and fundamental interaction with the database engine. We are wanting to lean in heavy with teaching with demos and concise, to-the-point learning.

## Terminal Objectives:

### **Connect to and Interact with SQL Server Instances.**

**Enabling Objectives:**

* Establish successful connections to SQL Server instances using SQL Server Management Studio (SSMS) and Azure Data Studio.
* Execute basic Transact-SQL (T-SQL) Data Definition Language (DDL) and Data Manipulation Language (DML) commands to interact with databases.
* Navigate and manage database objects and server configurations using SSMS Object Explorer.
* Utilize SQL Server Configuration Manager to manage SQL Server services and network protocols.

### **Utilize Essential SQL Server Administration Tools.**

**Enabling Objectives:**

* Navigate and manage database objects and server configurations effectively using SQL Server Management Studio (SSMS) Object Explorer and Query Editor.
* Connect to and query SQL Server instances using Azure Data Studio.
* Configure SQL Server services and network protocols efficiently using SQL Server Configuration Manager.
* Execute administrative commands and scripts using sqlcmd and basic PowerShell cmdlets for SQL Server.

### **Understand Foundational SQL Server Architecture and Components.**

**Enabling Objectives:**

* Explain the purpose and interaction of the SQL Server Database Engine, SQL Server Agent, and other key services.
* Describe the fundamental architecture of databases, files, and transaction logs, including the concepts of pages and extents.
* Differentiate between and identify the roles of SQL Server Analysis Services (SSAS), Integration Services (SSIS), and Reporting Services (SSRS) within a data platform.
* Outline the basic principles of Transact-SQL (T-SQL) for administrative purposes, including fundamental Data Definition Language (DDL) and Data Manipulation Language (DML) operations.

# Course 2: Database Management and Design Principles

**Course Description:** This course delves into the core responsibilities of a SQL Server database administrator concerning database creation, configuration, storage management, and fundamental design considerations that influence administrative efficiency. We are wanting to lean in heavy with teaching with demos and concise, to-the-point learning.

## Terminal Objectives:

### **Construct and Manage SQL Server Databases.**

**Enabling Objectives:**

* Create new databases, specifying file locations, initial sizes, and auto-growth settings for both data and log files.
* Implement filegroups to optimize data placement and manage storage, including the process of adding files to expand existing databases.
* Detach and attach databases for purposes such as migration, backup, or troubleshooting.
* Understand and apply database compatibility levels and collation settings.

### **Understand and Manage Database Objects.**

**Enabling Objectives:**

* Describe the role of tables and views in data organization and retrieval.
* Explain the purpose and types of indexes (clustered, non-clustered) and their impact on query performance.
* Identify and manage stored procedures and user-defined functions, understanding their benefits for encapsulation, security, and performance.
* Utilize system catalog views and dynamic management views (DMVs) to inspect database structures and monitor database activity.

### **Implement Data Loading and Migration Strategies.**

**Enabling Objectives:**

* Use the Import and Export Wizard to transfer data between SQL Server and other data sources.
* Utilize the Bulk Copy Program (BCP) utility for high-volume data imports and exports.
* Evaluate and choose appropriate migration tools and strategies for moving databases to Azure SQL Database or Azure SQL Managed Instance.
* Perform post-migration validation and optimization steps to ensure database performance and integrity after migration.

# Course 3: **Implementing SQL Server Security**

**Course Description:** This course focuses on securing SQL Server instances and databases, covering authentication, authorization, and advanced data protection features to safeguard sensitive information and ensure compliance. We are wanting to lean in heavy with teaching with demos and concise, to-the-point learning.

## Terminal Objectives:

### **Implement Server-Level Security.**

**Enabling Objectives:**

* Differentiate between Windows Authentication and SQL Server Authentication and configure the appropriate authentication mode for an instance.
* Create and manage SQL Server logins, including enforcing password policies and mapping them to Windows accounts.
* Utilize fixed server roles and create user-defined server roles to delegate administrative privileges effectively.
* Understand and apply the principle of least privilege at the server level, granting only the necessary permissions to perform required tasks.

### **Manage Database-Level Security.**

**Enabling Objectives:**

* Create and manage database users and map them to server logins, understanding the concept of orphaned users.
* Define and utilize database roles (fixed and user-defined) to group permissions and simplify access management within a database.
* Grant and revoke database-scoped permissions (e.g., CREATE TABLE, SELECT, INSERT) and object-level permissions (e.g., on specific tables or stored procedures).
* Repair mis-mapped logins and resolve common database access issues.

### **Implement Advanced Data Protection Features.**

**Enabling Objectives:**

* Configure Transparent Data Encryption (TDE) to encrypt databases at the file level.
* Implement Always Encrypted to protect sensitive data within application layers.
* Utilize Dynamic Data Masking to obscure sensitive data from non-privileged users.
* Configure Row-Level Security to control access to specific rows in a table based on user characteristics or execution context.

# Course 4: **Performance Monitoring, Optimization, and Automation**

**Course Description:** This course equips individuals with the skills to monitor SQL Server performance, identify bottlenecks, implement various optimization techniques, and automate routine administrative tasks to ensure efficient, responsive, and reliable database operations. We are wanting to lean in heavy with teaching with demos and concise, to-the-point learning.

## Terminal Objectives:

### **Monitor SQL Server Performance and Activity.**

**Enabling Objectives:**

* Use SQL Server Management Studio (SSMS) Activity Monitor and performance dashboards to gain real-time insights into server health and active processes.
* Query system dynamic management views (DMVs) and functions to gather detailed performance metrics and identify long-running queries or blocking sessions.
* Configure and analyze Extended Events sessions to capture specific performance data for troubleshooting and auditing.
* Understand and interpret key performance counters for CPU, memory, disk I/O, and network.

### **Optimize Database Performance.**

**Enabling Objectives:**

* Analyze query execution plans to identify performance bottlenecks and suggest improvements.
* Create, rebuild, and reorganize indexes to improve query performance and reduce fragmentation.
* Manage database statistics, including updating and creating them, to ensure the query optimizer has accurate information for generating efficient execution plans.
* Utilize the Database Engine Tuning Advisor (DTA) to recommend indexing and partitioning strategies.

### **Automate Routine Administrative Tasks.**

**Enabling Objectives:**

* Configure SQL Server Agent properties and manage its services.
* Create and schedule multi-step SQL Server Agent jobs for tasks such as backups, index maintenance, and data loading.
* Define operators and create alerts to notify administrators of critical events or job failures via Database Mail.
* Utilize PowerShell scripts to automate SQL Server administrative tasks beyond SQL Server Agent capabilities.

### **Perform Advanced Database Maintenance and Troubleshooting.**

**Enabling Objectives:**

* Implement and schedule database maintenance plans for integrity checks, index rebuilds/reorganizations, and statistics updatesl.
* Identify and resolve database fragmentation issues.
* Diagnose and repair database corruption using DBCC CHECKDB and other recovery techniques.
* Understand and manage transaction log growth and truncation for optimal database performance and recovery.

# Course 5: **High Availability, Disaster Recovery, and Cloud Integration**

**Course Description:** This course focuses on implementing strategies to ensure continuous database availability and rapid recovery from failures, encompassing comprehensive backup and restore operations, advanced high availability and disaster recovery solutions, and specific administrative skills for managing Azure SQL services. We are wanting to lean in heavy with teaching with demos and concise, to-the-point learning.

## Terminal Objectives:

### **Implement Comprehensive Backup and Restore Strategies.**

**Enabling Objectives:**

* Explain different recovery models (Full, Bulk-Logged, Simple) and their impact on backup and restore operations.
* Perform full, differential, and transaction log backups using SSMS and T-SQL.
* Restore user databases to a specific point in time, including performing post-crash log backups.
* Implement backup and restore operations to and from Azure Blob Storage, demonstrating hybrid cloud capabilities.

### **Configure Always On Availability Groups.**

**Enabling Objectives:**

* Explain the architecture and components of Always On Availability Groups (AGs), including replicas, listeners, and quorum.
* Configure and manage an Always On Availability Group using SQL Server Management Studio.
* Perform planned and unplanned failovers of Availability Groups and troubleshoot common AG issues.
* Understand the role of Availability Groups in hybrid cloud scenarios, including distributed AGs.

### **Implement Other High Availability and Disaster Recovery Solutions.**

**Enabling Objectives:**

* Describe the principles and configuration of Always On Failover Cluster Instances (FCIs) for instance-level high availability.
* Configure and manage Log Shipping for disaster recovery, including monitoring and troubleshooting.
* Understand the basics of transactional and merge replication for data distribution and synchronization.
* Evaluate different high availability and disaster recovery solutions based on Recovery Time Objective (RTO) and Recovery Point Objective (RPO) requirements.

### **Administer Azure SQL Services.**

**Enabling Objectives:**

* Create and configure Azure SQL Database and Azure SQL Managed Instance using the Azure portal and PowerShell.
* Implement security measures specific to Azure SQL, including network security (firewall rules, VNet integration) and Azure AD authentication.
* Monitor and optimize performance for Azure SQL services using Azure Monitor, Query Performance Insight, and Automatic Tuning.
* Configure high availability and disaster recovery for Azure SQL Database (e.g., active geo-replication, auto-failover groups) and Azure SQL Managed Instance.

# Lab 1: Foundational Tools and T-SQL Interaction

**Lab Description:** This lab focuses on establishing connectivity to SQL Server instances and performing basic administrative and data manipulation tasks using SQL Server Management Studio (SSMS), Azure Data Studio, and Transact-SQL.

## Terminal Objectives:

### **Establish and manage connections to SQL Server instances**.

**Enabling Objectives:**

* Connect to a SQL Server instance using SQL Server Management Studio (SSMS).
* Connect to a SQL Server instance using Azure Data Studio.
* Utilize SQL Server Configuration Manager to verify and manage network protocols for connectivity.

### **Perform fundamental data definition and manipulation using T-SQL.**

**Enabling Objectives:**

* Write and execute DDL commands to create a new database and tables.
* Write and execute DML commands (INSERT, UPDATE, DELETE) to modify data within tables.
* Write and execute SELECT statements to retrieve data from tables.

### **Navigate and inspect SQL Server objects and services.**

**Enabling Objectives:**

* Explore server-level objects and properties using SSMS Object Explorer.
* Inspect database-level objects such as tables, views, and stored procedures using SSMS.
* Verify the status and configuration of SQL Server services using SQL Server Configuration Manager.

# Lab 2: Database Object Management and Data Loading

**Lab Description:** This lab provides hands-on experience with managing database storage structures, creating and optimizing database objects, and implementing various data loading techniques.

## Terminal Objectives:

### **Manage database storage and file structures**.

**Enabling Objectives:**

* Create a new database, specifying initial sizes and auto-growth settings for data and log files.
* Implement and manage filegroups to optimize data placement and storage.
* Add new data files to an existing database to expand its storage capacity.

### **Implement and optimize database objects.**

**Enabling Objectives:**

* Create and manage tables, including defining primary and foreign keys.
* Design and implement clustered and non-clustered indexes to enhance query performance.
* Create and modify views and stored procedures for data abstraction and encapsulation.

### **Execute various data loading and migration techniques.**

**Enabling Objectives:**

* Utilize the SQL Server Import and Export Wizard to transfer data between different sources.
* Perform high-volume data imports using the Bulk Copy Program (BCP) utility.
* Simulate a database migration scenario using detach/attach methods or a migration assistant.

# Lab 3: Performance Tuning and Automated Maintenance

**Lab Description:** This lab focuses on identifying and resolving performance bottlenecks, and setting up automated maintenance tasks to ensure the ongoing health and efficiency of SQL Server databases.

## Terminal Objectives:

### **Diagnose and optimize query performance**.

**Enabling Objectives:**

* Analyze graphical and text-based query execution plans to identify performance bottlenecks.
* Apply basic T-SQL query tuning techniques, such as adding appropriate indexes or rewriting queries.
* Use Dynamic Management Views (DMVs) to identify long-running queries and resource consumption.

### **Implement and monitor automated administrative tasks.**

**Enabling Objectives:**

* Configure SQL Server Agent and create a multi-step job for a recurring administrative task (e.g., backup).
* Set up operators and alerts to receive notifications for job success or failure via Database Mail.
* Create and schedule a comprehensive database maintenance plan for integrity checks and index optimization.

### **Troubleshoot and resolve common database health issues.**

**Enabling Objectives:**

* Identify and resolve database fragmentation issues through index rebuilds or reorganizations.
* Simulate and diagnose a blocking scenario, then identify and resolve the blocking process.
* Perform a DBCC CHECKDB command to check for database integrity and understand its output.