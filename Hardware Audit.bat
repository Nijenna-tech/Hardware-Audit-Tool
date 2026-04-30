@echo off
title Nijenna Hardware Audit Tool
color 0A
mode con: cols=100 lines=50

:: PC Name sicher holen
for /f "delims=" %%i in ('hostname') do set pcname=%%i

:: Uptime via PowerShell einzeln berechnen
for /f %%i in ('powershell -command "(Get-Date) - (Get-CimInstance Win32_OperatingSystem).LastBootUpTime | select -expand days"') do set up_d=%%i
for /f %%i in ('powershell -command "(Get-Date) - (Get-CimInstance Win32_OperatingSystem).LastBootUpTime | select -expand hours"') do set up_h=%%i

echo ============================================================
echo   SYSTEM: %pcname%  ^|  UPTIME: %up_d% Tage, %up_h% Stunden
echo ============================================================

echo [MAINBOARD]
powershell -command "Get-CimInstance Win32_BaseBoard | foreach { write-host '  ' $_.Manufacturer $_.Product }"

echo [PROZESSOR]
powershell -command "Get-CimInstance Win32_Processor | foreach { write-host '  ' $_.Name }"

echo [ARBEITSSPEICHER]
powershell -command "Get-CimInstance Win32_PhysicalMemory | foreach { write-host '  ' ($_.Capacity / 1GB) 'GB -' $_.Speed 'MHz -' $_.Manufacturer }"

echo [GRAFIKKARTE]
powershell -command "Get-CimInstance Win32_VideoController | foreach { write-host '  ' $_.Name ' (Driver:' $_.DriverVersion ')' }"

echo [FESTPLATTEN]
powershell -command "Get-CimInstance Win32_DiskDrive | foreach { write-host '  ' $_.Model '[' ([math]::Round($_.Size / 1GB, 2)) 'GB]' }"

echo [AUDIO]
powershell -command "Get-CimInstance Win32_SoundDevice | foreach { write-host '  ' $_.Name ' (' $_.Manufacturer ')' }"

echo [BIOS]
powershell -command "Get-CimInstance Win32_BIOS | foreach { write-host '  ' $_.Manufacturer '-' $_.SMBIOSBIOSVersion }"

echo [NETZWERK]
powershell -command "Get-CimInstance Win32_NetworkAdapter -Filter 'PhysicalAdapter=True' | foreach { if($_.MACAddress) { write-host '  ' $_.Name '->' $_.MACAddress } }"

echo ============================================================
echo Abfrage beendet: %date% %time%
pause