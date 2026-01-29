@echo off
echo ==========================================
echo      ATLAS SYSTEM REPAIR TOOL
echo ==========================================
echo.
echo [1/3] Navigating to server directory...
cd server

echo.
echo [2/3] Installing Dependencies (This may take 1-2 minutes)...
echo PLEASE DO NOT CLOSE OR CANCEL THIS WINDOW.
echo.
call npm install
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Dependencies failed to install.
    pause
    exit /b %ERRORLEVEL%
)

echo.
echo [3/3] Generating Database Client...
call npx prisma generate
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Database generation failed.
    pause
    exit /b %ERRORLEVEL%
)

echo.
echo ==========================================
echo      REPAIR COMPLETE - STARTING APP
echo ==========================================
echo.
cd ..
powershell -ExecutionPolicy Bypass -File start-app.ps1
