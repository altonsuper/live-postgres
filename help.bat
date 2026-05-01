@echo off
title 👑 SUPREME MASTER CLI
mode con: cols=90 lines=40
color 0A

:menu
cls
echo.
echo 👑 SUPREME MASTER CLI - ATOMIC MODE
echo ===================================
echo 1. deploy      ^→ Full push + open live site
echo 2. dashboard   ^→ Open /dashboard.html (incognito)
echo 3. ai-read     ^→ Ask AI about your data
echo 4. secure      ^→ Check .gitignore + secrets
echo 5. status      ^→ Open Vercel + Supabase dashboards
echo 6. auth-fix    ^→ Patch Google/GitHub redirect URLs
echo 7. cache-bust  ^→ Hard-refresh live site with random param
echo 8. test-local  ^→ Test locally on :8080 (NO PUSH)
echo 9. exit        ^→ Close menu
echo.
set /p choice="👤 Select option (1-9): "

if "%choice%"=="1" goto deploy
if "%choice%"=="2" goto dashboard
if "%choice%"=="3" goto airead
if "%choice%"=="4" goto secure
if "%choice%"=="5" goto status
if "%choice%"=="6" goto authfix
if "%choice%"=="7" goto cachebust
if "%choice%"=="8" goto testlocal
if "%choice%"=="9" goto exit
echo ❌ Invalid option & timeout /t 2 & goto menu

:deploy
cls
echo 🚀 Deploying full project...
echo.
call push.bat
echo.
echo 🌐 Opening live site in incognito...
start chrome.exe --incognito "https://project-4rhm6.vercel.app?v=%random%"
echo.
echo ✅ Deploy complete. Check incognito window.
pause
goto menu

:dashboard
cls
echo 📊 Opening Dashboard...
echo.
start chrome.exe --incognito "https://project-4rhm6.vercel.app/dashboard.html"
echo.
echo ✅ Dashboard opened in incognito.
pause
goto menu

:airead
cls
echo 🤖 AI Data Bridge
echo =================
echo.
set /p q="❓ Ask AI about your  "
if "%q%"=="" set q=summary
echo.
echo Running: node ai-read.js "%q%"
echo.
node ai-read.js "%q%"
echo.
pause
goto menu

:secure
cls
echo 🔒 Security Check
echo ================
echo.
echo Checking .gitignore for secrets...
findstr /C:"config.json" .gitignore >nul
if %errorlevel% equ 0 (echo ✅ config.json is ignored) else (echo ❌ Add 'config.json' to .gitignore)
echo.
if exist "config.json" (echo ✅ config.json exists locally) else (echo ⚠️  config.json missing)
echo.
pause
goto menu

:status
cls
echo 📊 Project Status
echo =================
echo 🔗 Live: https://project-4rhm6.vercel.app
echo 🔗 Vercel: https://vercel.com/altonsupers-projects/project-4rhm6
echo 🔗 Supabase: https://supabase.com/dashboard/project/zmtudgbebtnoiysebeli
echo.
set /p open="Open dashboards? (y/n): "
if /i "%open%"=="y" (
    start https://vercel.com/altonsupers-projects/project-4rhm6
    start https://supabase.com/dashboard/project/zmtudgbebtnoiysebeli
)
pause
goto menu

:authfix
cls
echo 🔐 OAuth Redirect Patcher
echo =========================
echo Will replace window.location.origin with production URL.
echo.
set /p confirm="Proceed? (y/n): "
if /i "%confirm%"=="y" (
    echo ✏️  Running patch...
    node patch-auth.js
    echo 🚀 Deploying...
    call push.bat
    echo 🌐 Testing...
    start chrome.exe --incognito "https://project-4rhm6.vercel.app?v=%random%"
) else (echo ⏭️  Skipped.)
pause
goto menu

:cachebust
cls
echo 🧹 Cache-Bust Live Site
echo =======================
set "rand=%random%%random%"
echo Opening: https://project-4rhm6.vercel.app?v=%rand%^&bust=%rand%
start chrome.exe --incognito "https://project-4rhm6.vercel.app?v=%rand%^&bust=%rand%"
pause
goto menu

:testlocal
cls
echo 🔍 Local Test Mode
echo ==================
echo This opens a new window running http://localhost:8080
echo Test auth, dashboard, AI safely. NO PUSH.
echo.
echo ⚠️  Keep the new window open while testing.
echo ⚠️  Press Ctrl+C in that window to stop.
echo.
start test-local.bat
start chrome.exe "http://localhost:8080"
echo ✅ Test windows launched.
pause
goto menu

:exit
cls
echo.
echo 👋 You're doing great!!
echo 🚀 Test first. Push second. Sleep well.
echo.
pause >nul
exit