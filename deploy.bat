@echo off
:: deploy.bat — Double-click to run deploy.ps1
:: Fixes PowerShell execution policy on first run

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0deploy.ps1"
pause