@echo off
echo ==========================================
echo      Atlas Session Cleaner
echo ==========================================
echo.
echo This will DELETE all WhatsApp sessions (Factory Reset).
echo You will need to scan the QR code again.
echo.
set /p "confirm=Are you sure? (y/n): "
if /i "%confirm%" neq "y" exit /b

echo.
echo Cleaning server/sessions...
if exist "server\sessions" (
    del /f /q "server\sessions\*.*"
    for /d %%p in ("server\sessions\*") do rd /s /q "%%p"
    echo Done.
) else (
    echo Sessions directory not found.
)

pause
