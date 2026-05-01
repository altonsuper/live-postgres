@echo off
:: push.bat — NO CHECKS. JUST PUSH.
echo 🚀 Pushing to GitHub...
git add .
git commit -m "auto: %date% %time%" >nul 2>&1
git push origin main
if %errorlevel% equ 0 (
    echo ✅ Pushed! Vercel auto-deploying...
    echo 🌐 https://project-4rhm6.vercel.app
    echo 💡 Hard-refresh: Ctrl+Shift+R
) else (
    echo ❌ Push failed. Run 'git status' to debug.
)
pause