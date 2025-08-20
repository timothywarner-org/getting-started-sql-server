# M1 Demo Runbook — Connect, Sanity-Check, Tiny Round-Trip (7.5 Minutes)

**Course:** Getting Started with SQL Server  
**Module:** M1 — First Win with SSMS + VS Code + WWI  
**Persona:** Senior DBA at Globomantics Robotics Company  
**Recording Host:** Windows 11 desktop, RDP into Windows Server 2022 with SQL Server 2022 Developer  
**Repo Path (Local):** `C:\github\getting-started-sql-server\m1\`  
**Primary DB:** `WideWorldImporters` (WWI sample restored in advance)

---

## Preflight (60–90 sec, off-camera or jump-cut quickly)
- [ ] Confirm you can RDP to the VM and that **SQL Server (MSSQLSERVER)** is running.
- [ ] Open **SQL Server Management Studio (SSMS)** and **Visual Studio Code**.
- [ ] Ensure WWI (`WideWorldImporters`) is present and online.
- [ ] Create folder: `C:\github\getting-started-sql-server\m1\`.
- [ ] Download/place `m1-sanity.sql` from the course repo into that folder (included in assets).

**If anything’s off:**  
- Services: Start Menu → *SQL Server 2022 Configuration Manager* → **SQL Server Services** → ensure **Running**.  
- DB missing: restore **WideWorldImporters** before recording.  
- Permissions: use Windows Authentication as a local admin on the VM.

---

## Demo Narrative Spine (What you say in plain English)
- “I’ll connect with SSMS, run a couple of smoke tests, and show a tiny change safely.”  
- “Then I’ll mirror that workflow in VS Code with the MSSQL extension.”  
- “Finally, I’ll verify SQL Server services and TCP/IP are enabled—no deep config yet.”

Keep momentum. No execution plans, no static ports, no PowerShell/sqlcmd. Those land in M2.

---

## 0:00–0:30 — Set Context (One sentence on camera)
**Say:** “You’re the senior DBA at **Globomantics**. The WWI sample is already restored. We’ll connect, sanity-check, do one safe round-trip change, then verify services.”

---

## 0:30–2:00 — SSMS Connect + Smoke Test
1) **Open SSMS** → Connect to `localhost` (or your VM name) with **Windows Authentication**.  
   - Database dropdown: leave default (we’ll `USE` WWI in the script).
2) **New Query** and paste/run:

```sql
-- Smoke test: environment + database + quick data peek
SELECT @@VERSION AS SqlServerVersion; 
SELECT DB_NAME()  AS CurrentDb;

USE [WideWorldImporters];
GO

-- WWI: confirm basic rows exist
SELECT TOP (5) CustomerID, CustomerName
FROM Sales.Customers
ORDER BY CustomerID;
```

**Say:** “Version, current DB, and a quick peek into `Sales.Customers`—we’ve got life.”

**Visual beats:** Results grid shows a version string and five customers.

---

## 2:00–3:30 — Object Explorer Tour (Read-Only)
- Expand **Databases → WideWorldImporters → Tables**.  
- Right-click **Sales.Customers** → **Select Top 1000 Rows** (do this once).  
- Point at **Properties** for the database but **don’t** change anything.

**Say:** “This is where we’ll live day-to-day—Objects on the left, scripts in the editor, results below.”

---

## 3:30–5:15 — Tiny DDL/DML Round-Trip (Lab-Safe, Auto-Cleans Up)
1) In SSMS, open `C:\github\getting-started-sql-server\m1\m1-sanity.sql`  
   *(file included with assets; code also below for reference)*  
2) Press **Execute**.  
3) Observe the **SELECT** result set and the **ShouldBeNull** verification after rollback.

**Say (short):**  
- “I’m creating a `globoadmin` schema if it doesn’t exist.”  
- “I create a tiny `Sandbox_M1` table, insert two rows, and read them back.”  
- “I then **ROLLBACK** so the database is unchanged—perfect for safe demos.”

```sql
USE [WideWorldImporters];
GO
BEGIN TRAN;

-- Create lab schema once, if needed (rolled back in this demo anyway)
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = N'globoadmin')
    EXEC(N'CREATE SCHEMA globoadmin AUTHORIZATION dbo;');

-- Fresh table for the demo (safe because we ROLLBACK)
IF OBJECT_ID(N'globoadmin.Sandbox_M1', N'U') IS NOT NULL
    DROP TABLE globoadmin.Sandbox_M1;

CREATE TABLE globoadmin.Sandbox_M1
(
    SandboxID  int IDENTITY(1,1) PRIMARY KEY,
    Note       nvarchar(100) NOT NULL,
    CreatedAt  datetime2(0)  NOT NULL DEFAULT (sysdatetime())
);

INSERT INTO globoadmin.Sandbox_M1 (Note)
VALUES (N'Hello Globomantics'), (N'We are live');

SELECT TOP (5) *
FROM globoadmin.Sandbox_M1
ORDER BY SandboxID DESC;

-- Clean up: undo everything for a pristine DB post-demo
ROLLBACK TRAN;

-- Verify the table is gone (Should return NULL)
SELECT OBJECT_ID(N'globoadmin.Sandbox_M1', N'U') AS ShouldBeNull;
```

**Pitfall guardrail:** If the `USE [WideWorldImporters]` line fails, you restored the DW variant or a different name. Fix DB name, re-run.

---

## 5:15–6:30 — VS Code Mirror (MSSQL Extension)
1) **VS Code → File → Open Folder…** → `C:\github\getting-started-sql-server\m1\`  
2) Open `m1-sanity.sql`.  
3) Press **Ctrl+Shift+P** → **MSSQL: Connect**  
   - **Connection**: Server `localhost`, Auth `Windows`, Database `WideWorldImporters`.  
   - Save as profile: **`localhost-WWI`**.
4) Press **Run** (from the MSSQL editor) to execute the same script.

**Say:** “Same workflow, different surface. VS Code makes scripts easy to track in Git. The results grid confirms the inserts, then the rollback.”

---

## 6:30–7:30 — Config Manager Quick Verify (No Deep Changes)
1) Start Menu → **SQL Server 2022 Configuration Manager**  
2) **SQL Server Services** → Confirm **SQL Server (MSSQLSERVER)** is **Running**  
3) **SQL Server Network Configuration** → **Protocols for MSSQLSERVER** → **TCP/IP = Enabled**  
   - **Do not** set static ports or restart here (that’s M2).

**Say:** “We’re connected, we can query, we made a safe change, and the core service + TCP/IP are up. That’s your first win.”

---

## End State
- Database is unchanged (all demo changes were rolled back).
- You now have a saved script in the repo folder:
  - `C:\github\getting-started-sql-server\m1\m1-sanity.sql`
- VS Code has a connection profile named **localhost-WWI** (in your user settings).

---

## Appendix A — m1-sanity.sql (identical to the SSMS block above)
*(Included as a file in the assets; source of truth is the file version you run in both tools.)*

---

## Appendix B — Optional VS Code Profile (JSON sample)
You can keep this JSON in your repo as a reference. Import manually into the MSSQL extension if desired.

```json
{
  "profiles": [
    {
      "profileName": "localhost-WWI",
      "server": "localhost",
      "database": "WideWorldImporters",
      "authenticationType": "Integrated"
    }
  ]
}
```

---

## Recording Tips (for momentum)
- Keep query windows pre-sized; avoid dragging panes on camera.
- Run the smoke test once in SSMS, once in VS Code—don’t re-explain.
- Name things the same way on-screen and in narration (`globoadmin`, `Sandbox_M1`, `localhost-WWI`).
- If anything errors, calmly show the fix (DB name, connection profile) and move on.
