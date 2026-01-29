@echo off
echo ==========================================
echo   Atlas Client Flow - Startup Script
echo ==========================================
echo.

cd /d "%~dp0"

IF NOT EXIST .env (
    echo [ERROR] .env file not found in root directory!
    echo Please create one based on .env.example
    pause
    exit /b 1
)

echo Loading environment variables from .env...
for /f "usebackq tokens=1* delims==" %%a in (`type .env ^| findstr /v "^#" ^| findstr /v "^$"`) do (
    set "%%a=%%b"
)

echo.
echo Starting Application (Frontend + Backend)...
echo Please ensure your DATABASE_URL is set in .env
echo.

call npm run dev

pause
