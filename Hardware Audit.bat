@echo off
title Nijenna Hardware Audit Tool v2.1
color 0A
mode con: cols=100 lines=50

:: Start-Meldung
echo ============================================================

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "$os = Get-CimInstance Win32_OperatingSystem;" ^
    "$uptime = (Get-Date) - $os.LastBootUpTime;" ^
    "Write-Host ('  SYSTEM: {0} | UPTIME: {1} Tage, {2} Stunden' -f $env:COMPUTERNAME, $uptime.Days, $uptime.Hours);" ^
    "Write-Host '============================================================';" ^
    "Write-Host '[Motherboard]';" ^
    "Get-CimInstance Win32_BaseBoard | ForEach-Object { Write-Host ('  {0} {1}' -f $_.Manufacturer, $_.Product) };" ^
    "Write-Host \"`n[Processor]\";" ^
    "Get-CimInstance Win32_Processor | ForEach-Object { Write-Host ('  {0}' -f $_.Name) };" ^
    "Write-Host \"`n[Memory]\";" ^
    "Get-CimInstance Win32_PhysicalMemory | ForEach-Object { Write-Host ('  {0} GB - {1} MHz - {2}' -f ([math]::Round($_.Capacity / 1GB, 0)), $_.Speed, $_.Manufacturer) };" ^
    "Write-Host \"`n[Graphics Card]\";" ^
    "Get-CimInstance Win32_VideoController | ForEach-Object { Write-Host ('  {0} (Driver: {1})' -f $_.Name, $_.DriverVersion) };" ^
    "Write-Host \"`n[Disks]\";" ^
    "Get-CimInstance Win32_DiskDrive | ForEach-Object {" ^
    "    $d = $_;" ^
    "    $health = Get-PhysicalDisk | Where-Object { $_.DeviceID -eq $d.Index.ToString() };" ^
    "    Write-Host ('  {0} [{1} GB]' -f $d.Model, ([math]::Round($d.Size / 1GB, 2)));" ^
    "    if ($health) {" ^
    "        Write-Host ('  SMART: Status={0}, Health={1}' -f $health.OperationalStatus, $health.HealthStatus) -ForegroundColor Cyan;" ^
    "    } else {" ^
    "        Write-Host '  SMART: Keine Daten verfügbar' -ForegroundColor Yellow;" ^
    "    }" ^
    "};" ^
    "$batt = Get-CimInstance Win32_Battery;" ^
    "if ($batt -and $batt.Availability -gt 0) {" ^
    "    Write-Host \"`n[Battery]\";" ^
    "    foreach ($b in $batt) {" ^
    "        if ($b.EstimatedChargeRemaining -le 100) {" ^
    "            Write-Host ('  Status: {0} ({1}%% geladen)' -f $b.Status, $b.EstimatedChargeRemaining);" ^
    "        }" ^
    "    }" ^
    "}" ^
    "Write-Host \"`n[Audio]\";" ^
    "Get-CimInstance Win32_SoundDevice | ForEach-Object { Write-Host ('  {0} ({1})' -f $_.Name, $_.Manufacturer) };" ^
    "Write-Host \"`n[Bios]\";" ^
    "Get-CimInstance Win32_BIOS | ForEach-Object { Write-Host ('  {0} - {1}' -f $_.Manufacturer, $_.SMBIOSBIOSVersion) };" ^
    "Write-Host \"`n[Operating System]\";" ^
    "Get-CimInstance Win32_OperatingSystem | ForEach-Object { Write-Host ('  {0} (Build: {1})' -f $_.Caption, $_.BuildNumber) };" ^
    "Write-Host \"`n[Network]\";" ^
    "Get-CimInstance Win32_NetworkAdapter -Filter 'PhysicalAdapter=True' | Where-Object { $_.MACAddress } | ForEach-Object { Write-Host ('  {0} -> {1}' -f $_.Name, $_.MACAddress) };"

echo ============================================================
echo Endzeit: %date% %time%
pause
