@echo off
cd /d "%~dp0"
echo.
echo === WLAN Ch.04 Image Downloader ===
echo.
echo Launching PowerShell...
echo.
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0download-images.ps1"
echo.
echo === Finished. Press any key to close this window. ===
pause >nul
