\
    # run-healthcheck.ps1
    # Purpose: Run SQL health checks with sqlcmd and save CSV outputs
    param(
      [string]$Server = "localhost,1433",
      [string]$OutRoot = r"C:\github\getting-started-sql-server\m2\out"
    )

    $ErrorActionPreference = "Stop"

    if (-not (Get-Command sqlcmd -ErrorAction SilentlyContinue)) {
      Write-Warning "sqlcmd not found. Install with: winget install Microsoft.SQLcmd"
      exit 1
    }

    $stamp = Get-Date -Format "yyyyMMdd-HHmmss"
    $outDir = Join-Path $OutRoot $stamp
    New-Item -ItemType Directory -Force -Path $outDir | Out-Null

    $here = Split-Path -Parent $MyInvocation.MyCommand.Path

    # Server properties (single row)
    & sqlcmd -S $Server -E -d master -W -s "," -i (Join-Path $here "healthcheck_server.sql") -o (Join-Path $outDir "server_properties.csv")

    # WWI database size + recovery model
    & sqlcmd -S $Server -E -d master -W -s "," -i (Join-Path $here "healthcheck_database_wwi.sql") -o (Join-Path $outDir "wwi_dbsize.csv")

    Write-Host "Healthcheck complete -> $outDir"
