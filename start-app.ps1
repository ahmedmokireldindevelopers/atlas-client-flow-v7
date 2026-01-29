# Atlas Client Flow - Robust Startup Script
Write-Host ">>> Initializing System..." -ForegroundColor Cyan

# 1. Kill Zombie Processes on Ports 3001 & 5000
Write-Host ">>> Checking ports 3001 and 5000..." -ForegroundColor Yellow
$ports = @(3001, 5000)
foreach ($port in $ports) {
    $pids = Get-NetTCPConnection -LocalPort $port -ErrorAction SilentlyContinue | Select-Object -ExpandProperty OwningProcess -Unique
    if ($pids) {
        foreach ($pid_val in $pids) {
            Stop-Process -Id $pid_val -Force -ErrorAction SilentlyContinue
            Write-Host "    - Killed process $pid_val on port $port" -ForegroundColor Red
        }
    }
}


# 3. Start Application
Write-Host ">>> Starting Application..." -ForegroundColor Green
Write-Host "    - Frontend: http://localhost:5000"
Write-Host "    - Backend:  http://localhost:3001"
Write-Host ">>> Please wait for the browser to open..." -ForegroundColor Gray

# Run npm run dev
npm run dev
