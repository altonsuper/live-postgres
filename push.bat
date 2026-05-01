@echo off
title 🚀 PUSH TO PRODUCTION
mode con: cols=80 lines=20
color 0A

cls
echo.
echo 🚀 PUSHING TO PRODUCTION
echo ========================
echo.
echo 1. Checking Git status...
git status --short
echo.
set /p commit="Add commit message (or press Enter for auto): "
if "%commit%"=="" set commit=chore: auto-deploy %date% %time%

echo.
echo 2. Committing changes...
git add .
git commit -m "%commit%"

echo.
echo 3. Pushing to GitHub...
git push origin main

echo.
echo 4. Triggering Vercel deploy...
echo    (Check: https://vercel.com/altonsupers-projects/project-4rhm6)
echo.
echo ✅ Push complete! Vercel rebuilds in ~15 seconds.
echo.
echo 💡 Test live: https://project-4rhm6.vercel.app?v=FORCE
echo.
pause