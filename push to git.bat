@echo off
setlocal

echo ===============================
echo   GitHub Push Automation
echo ===============================
echo.

:: Ask for GitHub repo URL
set /p REPO_URL=Enter GitHub repository URL: 

:: Initialize git if not already
if not exist ".git" (
    echo Initializing git repository...
    git init
)

:: Add remote origin if not exists
git remote | findstr origin >nul
if errorlevel 1 (
    echo Adding remote origin...
    git remote add origin %REPO_URL%
) else (
    echo Remote origin already exists.
)

:: Ask for commit message
echo.
set /p COMMIT_MSG=Enter commit message: 

:: Git add & commit
git add .
git commit -m "%COMMIT_MSG%"

:: Ask before push
echo.
set /p PUSH_CONFIRM=Do you want to push to GitHub now? (y/n): 

if /I "%PUSH_CONFIRM%"=="y" (
    echo Pushing to GitHub...
    git branch -M main
    git push -u origin main
) else (
    echo Push cancelled.
)

echo.
echo Done!
pause
