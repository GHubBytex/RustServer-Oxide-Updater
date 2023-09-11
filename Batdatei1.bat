@echo off

:: Lesen Sie die Pfade aus der config.cfg Datei
setlocal enabledelayedexpansion
set /p STEAMCMD_PATH=<config.cfg
set /a LineNumber=0

for /f "delims=" %%a in (config.cfg) do (
    set /a LineNumber+=1
    if !LineNumber! equ 2 (
        set SERVERDATA_PATH=%%a
    )
)

taskkill /F /IM RustDedicated.exe

:: Führen Sie steamcmd.exe mit den angegebenen Parametern aus
call %STEAMCMD_PATH%\steamcmd.exe +force_install_dir "%SERVERDATA_PATH%" +login anonymous +app_update 258550 validate +exit

:: Rufen Sie die PowerShell-Datei auf
call Powershell -NoProfile -ExecutionPolicy Bypass -File "Powershelldatei2.ps1"
