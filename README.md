# 🛠️ HW-Audit Dash

A lightweight, zero-installation Windows Batch utility to retrieve detailed hardware information instantly. This tool bypasses the deprecated `wmic` and uses modern PowerShell/CIM queries to provide a clean, compact overview of your system.

## ✨ Features
- **EXE File with cert:** Install cert for .exe usage, looks better. :)
- **Zero Footprint:** No installation required, just run the `.bat` file.
- **Modern Backend:** Uses PowerShell `Get-CimInstance` for future-proof compatibility with Windows 11.
- **Smart Uptime:** Displays system boot time and PC identity.
- **Hardware Coverage:**
  - **Mainboard:** Brand and Model detection.
  - **Processor:** Full CPU name and specs.
  - **RAM:** Capacity (GB), Speed (MHz), and Manufacturer.
  - **GPU:** Multi-GPU support with Driver versions.
  - **Storage:** Model names and formatted capacity in GB.
  - **Audio:** Lists all connected sound devices and interfaces.
  - **Network:** Physical adapters and MAC addresses.

## 🚀 Quick Start
1. Download the `Hardware-Audit.bat`.
2. Right-click and **Run as Administrator** (recommended for full serial number access).
3. View your specs directly in the command prompt.

## 📸 Preview
> The output is formatted in a clean, high-contrast green-on-black layout for maximum readability.

```textoutput showcase
============================================================
  SYSTEM: MY-PC-NAME  |  UPTIME: 2 Days, 4 Hours
============================================================
[Motherboard]
   Manufacturer Model-ID

[Processor]
   13th Gen Intel(R) Core(TM)
...
