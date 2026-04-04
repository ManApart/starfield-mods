@echo off
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0launch-sf1edit-virtualbox-ini-file.ps1"
echo.
echo Exit code: %errorlevel%
pause
