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

echo [Motherboard]
powershell -command "Get-CimInstance Win32_BaseBoard | foreach { write-host '  ' $_.Manufacturer $_.Product }"
echo.
echo [Processor]
powershell -command "Get-CimInstance Win32_Processor | foreach { write-host '  ' $_.Name }"
echo.
echo [Memory]
powershell -command "Get-CimInstance Win32_PhysicalMemory | foreach { write-host '  ' ($_.Capacity / 1GB) 'GB -' $_.Speed 'MHz -' $_.Manufacturer }"
echo.
echo [Grafics card]
powershell -command "Get-CimInstance Win32_VideoController | foreach { write-host '  ' $_.Name ' (Driver:' $_.DriverVersion ')' }"
echo.
echo [Disks]
powershell -command "Get-CimInstance Win32_DiskDrive | foreach { write-host '  ' $_.Model '[' ([math]::Round($_.Size / 1GB, 2)) 'GB]' }"
echo.
echo [Audio]
powershell -command "Get-CimInstance Win32_SoundDevice | foreach { write-host '  ' $_.Name ' (' $_.Manufacturer ')' }"
echo.
echo [Bios]
powershell -command "Get-CimInstance Win32_BIOS | foreach { write-host '  ' $_.Manufacturer '-' $_.SMBIOSBIOSVersion }"
echo.
echo [Network]
powershell -command "Get-CimInstance Win32_NetworkAdapter -Filter 'PhysicalAdapter=True' | foreach { if($_.MACAddress) { write-host '  ' $_.Name '->' $_.MACAddress } }"
echo.
echo ============================================================
echo Endtime: %date% %time%
pause
