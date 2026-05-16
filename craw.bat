@echo off

:: ============================================
:: TARGET = folder BAT berada
:: ============================================
set "TARGET=%~dp0"

:: ============================================
:: OUTPUT = fixed location
:: ============================================
set "OUTPUT=C:\Crawler\folder_tree.txt"

:: ============================================
:: CREATE OUTPUT FOLDER IF NOT EXIST
:: ============================================
if not exist "C:\Crawler" mkdir "C:\Crawler"

:: ============================================
:: HEADER
:: ============================================
echo Folder Tree Scan > "%OUTPUT%"
echo Source: %TARGET% >> "%OUTPUT%"
echo Generated: %date% %time% >> "%OUTPUT%"
echo ============================================ >> "%OUTPUT%"
echo. >> "%OUTPUT%"

:: ============================================
:: TREE STRUCTURE WITH FILE SIZE
:: ============================================
dir "%TARGET%" /s /a /-c >> "%OUTPUT%"

:: ============================================
:: DONE
:: ============================================
echo. >> "%OUTPUT%"
echo Scan complete >> "%OUTPUT%"

echo.
echo DONE. Output saved to:
echo %OUTPUT%
echo.

pause