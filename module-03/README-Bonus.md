# M3 Bonus Appendix — Storage & Size Quick Wins (Read-Only)

**Where to store locally:** `C:\github\getting-started-sql-server\m3-bonus`  
**Scope:** Pure reads — no changes, no restarts. Safe to run in SSMS or VS Code.  
**DB focus:** `WideWorldImporters` for table/index reports; instance-wide for file reports.

## Files
- `find-largest-database-files.sql` — Largest data/log files across the instance (all DBs).
- `top5-largest-tables-wwi.sql` — Top 5 largest tables in WideWorldImporters by total reserved MB.
- `top10-largest-indexes-wwi.sql` — Top 10 largest indexes in WideWorldImporters.
- `top-databases-by-size.sql` — Data vs. log size per database (instance-wide).

## How to Run (SSMS)
1) Open a new query window.
2) Open one of the `.sql` files.
3) Press **Execute**.
4) **Do not** modify anything; these are read-only snapshots.

## How to Run (VS Code + MSSQL)
1) `File → Open Folder…` → `C:\github\getting-started-sql-server\m3-bonus`
2) Open a `.sql` file
3) **Ctrl+Shift+P** → **MSSQL: Connect** → use `localhost-WWI` or your profile
4) Click **Run**

## Optional: CSV export via sqlcmd (example)
```bat
sqlcmd -S localhost,1433 -E -d WideWorldImporters -W -s "," -i "C:\github\getting-started-sql-server\m3-bonus\top5-largest-tables-wwi.sql" -o "C:\github\getting-started-sql-server\m3-bonus\top5-largest-tables.csv"
```

## Notes
- Page size is 8 KB. Conversions in scripts render MB for readability.
- For tiny objects, “fragmentation” and “size” metrics are often not actionable.
