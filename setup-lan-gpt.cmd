@echo off
setlocal
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0setup-lan-gpt.ps1" %*
set "SETUP_EXIT=%ERRORLEVEL%"
echo.
if not "%SETUP_EXIT%"=="0" echo Setup failed with exit code %SETUP_EXIT%.
if "%~1"=="" pause
exit /b %SETUP_EXIT%
