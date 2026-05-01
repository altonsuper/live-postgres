@echo off
title 🔍 LOCAL TEST SERVER
mode con: cols=90 lines=25
color 0B
cls

echo.
echo 🔍 LOCAL TEST SERVER - NO PUSH, NO DEPLOY
echo =========================================
echo.
echo Folder: %~dp0
echo Target: http://localhost:8080
echo.

REM --- Check Python ---
python --version >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ Python detected. Starting server...
    echo.
    echo 💡 Open: http://localhost:8080
    echo 💡 Press Ctrl+C to stop server
    echo.
    python -m http.server 8080
    goto finished
)

REM --- Check Node.js ---
node --version >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ Node.js detected. Starting server...
    echo.
    echo 💡 Open: http://localhost:8080
    echo 💡 Press Ctrl+C to stop server
    echo.
    npx serve . -p 8080
    goto finished
)

REM --- Fallback Instructions ---
echo ❌ Neither Python nor Node.js found in PATH.
echo.
echo 💡 Quick fixes:
echo    1. Install Python: https://python.org (check "Add to PATH")
echo    2. Install Node.js: https://nodejs.org
echo    3. OR use VS Code Live Server extension
echo    4. OR run manually: npx serve . -p 8080
echo.

:finished
echo.
echo ⚠️  Server stopped or unavailable.
echo     Press any key to close...
pause >nul
exit