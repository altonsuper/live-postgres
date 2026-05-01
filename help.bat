@echo off
title 👑 SUPREME MASTER CLI
mode con: cols=80 lines=30
color 0A

:menu
cls
echo.
echo 👑 SUPREME MASTER CLI
echo =====================
echo 1. deploy     ^→ Push + open live site
echo 2. dashboard  ^→ Open /dashboard.html (incognito)
echo 3. ai-read    ^→ Ask AI about your data
echo 4. secure     ^→ Check .gitignore + secrets
echo 5. status     ^→ Open Vercel + Supabase dashboards
echo 6. exit       ^→ Close menu
echo.
set /p choice="👤 Select option (1-6): "

if "%choice%"=="1" goto deploy
if "%choice%"=="2" goto dashboard
if "%choice%"=="3" goto airead
if "%choice%"=="4" goto secure
if "%choice%"=="5" goto status
if "%choice%"=="6" goto exit
echo ❌ Invalid option & timeout /t 1 & goto menu

:deploy
cls
echo 🚀 Deploying...
call push.bat
start chrome.exe --incognito "https://project-4rhm6.vercel.app?v=%random%"
goto menu

:dashboard
cls
echo 📊 Opening Dashboard...
start chrome.exe --incognito "https://project-4rhm6.vercel.app/dashboard.html"
goto menu

:airead
cls
set /p q="❓ Ask AI: "
node ai-read.js "%q%"
pause
goto menu

:secure
cls
echo 🔒 Security Check:
findstr /C:"config.json" .gitignore >nul
if %errorlevel% equ 0 (echo ✅ config.json ignored) else (echo ❌ Add 'config.json' to .gitignore)
if exist "config.json" (echo ✅ config.json exists locally) else (echo ❌ config.json missing)
pause
goto menu

:status
cls
echo 📊 Opening Dashboards...
start https://vercel.com/altonsupers-projects/project-4rhm6
start https://supabase.com/dashboard/project/zmtudgbebtnoiysebeli
goto menu

:exit
echo 👋 Goodbye.
exit