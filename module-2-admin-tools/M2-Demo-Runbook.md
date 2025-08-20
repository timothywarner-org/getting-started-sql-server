# M2 Demo Runbook — Daily Tools That Pay Rent (7.5 Minutes)

**Course:** Getting Started with SQL Server  
**Module:** M2 — SSMS Pro Habits + VS Code + sqlcmd (Minimal Overlap With M1)  
**Persona:** Senior DBA at Globomantics Robotics Company  
**Recording Host:** Windows 11 desktop, RDP into Windows Server 2022 with SQL Server 2022 Developer  
**Repo Path (Local):** `C:\github\getting-started-sql-server\m2`  
**Primary DB:** `WideWorldImporters` (WWI sample restored in advance)

---

## Preflight (60–90 sec, off-camera or fast jump-cuts)
- [ ] Open **SSMS** (already installed), **VS Code** with **MSSQL** extension, and **SQL Server 2022 Configuration Manager**.
- [ ] Ensure **SQL Server (MSSQLSERVER)** is **Running**.
- [ ] Create folder: `C:\github\getting-started-sql-server\m2` and `C:\github\getting-started-sql-server\m2\out\`.
- [ ] Confirm `sqlcmd` is available: `Win + R` → `cmd` → run `sqlcmd -?` (okay if classic or new version).
  - If missing, skip the csv export step on-camera; mention install via `winget install Microsoft.SQLcmd` later.
- [ ] Place included files in `C:\github\getting-started-sql-server\m2`:
  - `healthcheck_server.sql`
  - `healthcheck_database_wwi.sql`
  - `test_customers_to_csv.sql`
  - `run-healthcheck.ps1`

---

## Demo Narrative Spine (what you’ll say)
- “We’re upgrading daily workflow: fast, safe connects; faster object navigation; predictable networking; and quick exports to CSV.”  
- “No internals deep-dive yet—that’s Module 3.”

---

## 0:00–1:30 — SSMS Pro Habits (Connection Color + Registered Servers)
1) In **SSMS**, click **Connect** → **Database Engine…** (even if already connected).  
   - **Server name:** `localhost` (or your VM name)  
   - Click **Options >>** → **Connection Properties** → **Use custom color** → pick a non-danger color (e.g., **Blue** for Dev).  
   - **Connect**.  
2) **Registered Servers**: **View → Registered Servers** (or press **Ctrl+Alt+G**).  
   - Create **Server Group**: `Globomantics` → **New Server Registration** → Server: `localhost` → **Save**.
**Say:** “Color-coding reduces ‘oops’ on prod; Registered Servers gives me one-click connects across environments.”

---

## 1:30–2:45 — Object Explorer Details + Filters (F7)
1) In **SSMS**, press **F7** to open **Object Explorer Details**.  
2) Navigate to **Databases → WideWorldImporters → Tables**.  
3) In the Details pane, use the **filter row**:  
   - **Schema** = `Sales`  
   - **Name contains** = `Customer`  
**Say:** “F7 + filters jump me right to the objects I need when the list is huge.”

---

## 2:45–4:00 — Script-Out Defaults That Save Time
1) **Tools → Options → SQL Server Objects → Scripting** (names may vary slightly by SSMS version).  
   - **Script DROP and CREATE** = **True**  
   - **Script USE DATABASE** = **True**  
   - **Include descriptive headers** = **True**  
   - **Script for server version** = **SQL Server 2022** (if available)  
2) Right-click **Sales.Customers** → **Script Table as → DROP and CREATE To → New Query Editor Window**.  
   - **Do not execute**—we’re just showing high-quality scripts.
**Say:** “Good defaults make safer, repeatable scripts. We’ll actually execute changes in later modules.”

---

## 4:00–5:15 — Predictable Networking (Set Static TCP Port 1433)
1) Open **SQL Server 2022 Configuration Manager**.  
2) **SQL Server Network Configuration → Protocols for MSSQLSERVER → TCP/IP** → **Properties**.  
   - **IP Addresses** tab → **IPAll**:  
     - **TCP Dynamic Ports** = *(blank)*  
     - **TCP Port** = `1433`  
   - **OK**.  
3) **SQL Server Services** → Right-click **SQL Server (MSSQLSERVER)** → **Restart**.  
**Say:** “Now the default instance listens on 1433—easy to script, easy to firewall, no dependency on Browser.”

*(Local connections typically ignore firewall rules; for remote demos, open 1433/TCP inbound on Windows Firewall.)*

---

## 5:15–6:15 — Quick CSV Exports with sqlcmd (confirm the port + useful outputs)
1) **Command Prompt** (or **Terminal** in VS Code).  
2) Test query to CSV:  
   ```bat
   sqlcmd -S localhost,1433 -E -d WideWorldImporters -W -s "," -Q "SET NOCOUNT ON; SELECT TOP (5) CustomerID, CustomerName FROM Sales.Customers ORDER BY CustomerID;" -o "C:\github\getting-started-sql-server\m2\out\customers_top5.csv"
   ```
**Say:** “That proves the static port and gives me a CSV I can hand to an analyst.”

---

## 6:15–7:30 — One-Click Health Export (PowerShell wrapper)
1) **PowerShell**:  
   ```powershell
   Set-Location "C:\github\getting-started-sql-server\m2"
   .\run-healthcheck.ps1
   ```
   This creates a timestamped folder in `C:\github\getting-started-sql-server\m2\out\` with:
   - `server_properties.csv`
   - `wwi_dbsize.csv`
**Say:** “This is a simple pattern: keep SQL in .sql files, call them with `sqlcmd` from PowerShell, and capture clean CSVs.”

---

## End State
- You have color-coded connections and a **Registered Servers** group.  
- SSMS scripting defaults are safer and more complete.  
- The SQL Server engine now listens on a **static TCP port (1433)**.  
- You can produce quick CSVs via `sqlcmd` or the provided PowerShell wrapper.

---

## Appendix A — File List (included in assets)
- `healthcheck_server.sql` — server properties (single row)
- `healthcheck_database_wwi.sql` — WideWorldImporters size + recovery model
- `test_customers_to_csv.sql` — simple top-5 customer export
- `run-healthcheck.ps1` — wrapper that calls the SQL and writes timestamped CSVs

## Appendix B — Troubleshooting
- **`sqlcmd` not found**: install later via `winget install Microsoft.SQLcmd` or use SSMS to run the .sql files on camera.  
- **Static port didn’t take**: re-open TCP/IP **Properties**, ensure **IPAll → TCP Dynamic Ports** is blank, and that you restarted the service.  
- **CSV is empty**: check the `-d WideWorldImporters` DB name and query text; remove `-W` if you want padded spaces preserved.
