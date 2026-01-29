@echo off
echo ==========================================
echo      GitHub Repository Setup
echo ==========================================
echo.
echo This script will:
echo 1. Initialize a new Git repository
echo 2. Configure Git LFS
echo 3. Commit your files
echo 4. Link to GitHub (ahmedmokireldindevelopers/atlas-client-flow-v7)
echo 5. Push your code
echo.
echo MAKE SURE YOU HAVE AUTHENTICATED WITH GITHUB BEFORE RUNNING THIS!
echo (You can run 'gh auth login' or ensure git is configured with your credentials)
echo.
pause

echo.
echo [1/5] Initializing Git...
git init
if %ERRORLEVEL% NEQ 0 goto :error

echo.
echo [2/5] Installing Git LFS...
git lfs install
if %ERRORLEVEL% NEQ 0 echo [WARNING] Git LFS failed to install. Continuing...

echo.
echo [3/5] Adding files (this may take a moment)...
git add .
if %ERRORLEVEL% NEQ 0 goto :error

echo.
echo [4/5] Committing...
git commit -m "Initial commit - Atlas Client Flow v7"
if %ERRORLEVEL% NEQ 0 echo [INFO] Nothing to commit or commit failed. Continuing...

echo.
echo [5/5] Adding Remote and Pushing...
git remote remove origin 2>nul
git remote add origin https://github.com/ahmedmokireldindevelopers/atlas-client-flow-v7.git
git branch -M main
git push -u origin main

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo [ERROR] Push failed. 
    echo Please make sure the repository exists on GitHub and you have permission.
    echo To create the repo using CLI, run: gh repo create ahmedmokireldindevelopers/atlas-client-flow-v7 --public --source=. --remote=origin
    goto :error
)

echo.
echo ==========================================
echo      SUCCESS! Project is on GitHub.
echo ==========================================
pause
exit /b 0

:error
echo.
echo [ERROR] An error occurred. Please check the output above.
pause
exit /b 1
