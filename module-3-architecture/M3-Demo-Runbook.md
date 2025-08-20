# M3 Demo Runbook — Understand The Engine You’re Driving (7.5 Minutes)

**Course:** Getting Started with SQL Server  
**Module:** M3 — Architecture & Components (Practical)  
**Persona:** Senior DBA at Globomantics Robotics Company  
**Recording Host:** Windows 11 desktop, RDP into Windows Server 2022 with SQL Server 2022 Developer  
**Repo Path (Local):** `C:\github\getting-started-sql-server\m3`  
**Primary DB:** `WideWorldImporters` (WWI sample restored in advance)

**Goal:** Name the major components (Engine, Agent, Browser, Storage), then *use* a few DMVs to answer real questions about files, the transaction log, and index health—without changing anything.

---

## Preflight (60–90 sec, off-camera or fast jump-cuts)
- [ ] Open **SSMS** (connected as you finished M2; no repeated connects on camera).  
- [ ] Ensure WWI (`WideWorldImporters`) is present and online.  
- [ ] Create folder: `C:\github\getting-started-sql-server\m3`.  
- [ ] Place included files in `C:\github\getting-started-sql-server\m3`:
  - `m3-inspect-engine.sql`
  - `m3-files-and-filegroups.sql`
  - `m3-log-stats-wwi.sql`
  - `m3-index-physical-stats-wwi.sql`
  - `safe-transaction-template.sql`

---

## Demo Narrative Spine (what you’ll say)
- “We’ll map the core pieces of SQL Server, then read the truth from the engine: files/filegroups, the transaction log, and index fragmentation.”  
- “No configuration changes—this is a read-only tour with practical takeaways.”

---

## 0:00–0:30 — Context (one sentence)
**Say:** “At Globomantics, I need to know what I’m driving: which edition/version, what databases exist, and whether Agent is in play.”

---

## 0:30–2:00 — About The Instance (Edition/Version, DBs, Agent)
1) In SSMS, open `C:\github\getting-started-sql-server\m3\m3-inspect-engine.sql` and **Execute**.

**Say:**  
- “This first block uses `SERVERPROPERTY` to report the edition and version.”  
- “System databases—`master`, `model`, `msdb`, `tempdb`—do the plumbing; WWI is our app database.”  
- “I also check **msdb** for an Agent job count to show SQL Server Agent’s role in scheduling.”

**Visual beats:** A one-row server info result; a small set of database rows; a single-number Agent job count.

---

## 2:00–3:45 — Files & Filegroups (What Lives On Disk)
1) Open `C:\github\getting-started-sql-server\m3\m3-files-and-filegroups.sql` → **Execute**.

**Say:**  
- “Every database has at least one **data** file and one **log** file.”  
- “Data files (`ROWS`) sit in **filegroups**; the log is separate and sequential.”  
- “I’m reading size, growth, and paths—notice we’re not changing anything.”

**Callout:** Mention **filegroup** column and how multiple data files can spread IO for very large DBs (not needed for WWI).

---

## 3:45–5:45 — Transaction Log Reality Check (DMV)
1) Open `C:\github\getting-started-sql-server\m3\m3-log-stats-wwi.sql` → **Execute**.

**Say:**  
- “`sys.dm_db_log_stats` shows total and used log size, plus **VLF** counts.”  
- “If **used%** stays high and you’re in **FULL** recovery without log backups, the log will grow.”  
- “Excessive VLFs can slow recovery—hundreds are normal; **thousands** can be a smell.”

**Do not** shrink/grow/change anything on camera—just interpret the numbers for beginners.

---

## 5:45–7:15 — Index Health Snapshot (DMV)
1) Open `C:\github\getting-started-sql-server\m3\m3-index-physical-stats-wwi.sql` → **Execute**.

**Say:**  
- “`sys.dm_db_index_physical_stats` gives **avg_fragmentation_in_percent** and **page_count**.”  
- “Practical rule of thumb: ignore tiny indexes—if **page_count < 128**, fragmentation isn’t actionable.”  
- “We’ll save rebuild/reorg choices for a later course; today is about reading the signals.”

**Visual beats:** A few rows with index names, fragmentation %, and page counts.

---

## 7:15–7:30 — Safer Change Pattern (Template Only)
1) Briefly open `C:\github\getting-started-sql-server\m3\safe-transaction-template.sql` (do not execute).

**Say:**  
- “When you *do* make changes, standardize on `SET XACT_ABORT ON;` and explicit transactions.”  
- “If anything errors, the transaction rolls back cleanly—fewer half-applied changes.”

---

## End State
- You measured reality—no changes made.  
- You can answer three everyday questions:
  1) What instance am I on and what DBs matter here?  
  2) How big is my log and are VLFs reasonable?  
  3) Are any big indexes obviously fragmented?

---

## Appendix — Troubleshooting
- **`m3-log-stats-wwi.sql` errors**: You’re on an old build or wrong database name; confirm `WideWorldImporters` and SQL Server 2019+ feature availability.  
- **No rows for index stats**: The chosen table might not exist in your WWI variant. The script falls back to `Sales.Orders` or `Sales.Customers`.
