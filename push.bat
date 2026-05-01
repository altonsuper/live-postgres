@echo off
:: push.bat — VERBOSE push with error checking
echo 🚀 Starting push...
echo.

echo 📦 Staging changes...
git add .
if %errorlevel% neq 0 echo ❌ git add failed & pause & exit /b 1

echo 💬 Committing...
git commit -m "auto: %date% %time%"
if %errorlevel% neq 0 (
    echo ⚠️ Nothing to commit (no changes) 
) else (
    echo ✅ Committed
)

echo 📤 Pushing to GitHub...
git push
if %errorlevel% neq 0 (
    echo ❌ Push failed. Check: 1) git remote -v 2) GitHub token 3) Network
    pause
    exit /b 1
)

echo.
echo ✅ PUSH SUCCESS!
echo 🌐 https://project-4rhm6.vercel.app
echo 📋 Vercel build logs: https://vercel.com/altonsupers-projects/project-4rhm6
pause