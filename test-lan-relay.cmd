@echo off
setlocal
set "RELAY_URL=http://192.168.18.17:8088"
if not "%~1"=="" set "RELAY_URL=%~1"

echo Testing %RELAY_URL%/health ...
curl.exe --noproxy "*" -sS -o NUL -w "HTTP %%{http_code}" --connect-timeout 5 "%RELAY_URL%/health"
set "TEST_EXIT=%ERRORLEVEL%"
echo.

if not "%TEST_EXIT%"=="0" (
  echo Connection failed.
) else (
  echo Connection succeeded.
  echo Base URL: %RELAY_URL%/v1
  echo API Key: use an existing key from the Sub2API admin page
)

echo.
pause
exit /b %TEST_EXIT%
