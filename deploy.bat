@echo off
:: push.bat — Pure git push. That's it.
:: Usage: Double-click or run: .\push.bat

echo 🚀 Pushing to GitHub...
git add .
git commit -m "auto: %date% %time%" >nul 2>&1
git push
if %errorlevel% equ 0 (
    echo ✅ Pushed! Vercel auto-deploying...
    echo 🌐 https://project-4rhm6.vercel.app
) else (
    echo ❌ Push failed. Check: 1) Git logged in 2) Repo exists 3) Network
)
pause