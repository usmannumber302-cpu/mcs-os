# Minecraft Server OS (MCS OS) Builder

This folder contains the complete source code to compile your own lightweight Linux OS specifically designed for hosting Minecraft servers.

## Features
- **Lightweight Debian Base**: Consumes very little RAM, leaving more for your server.
- **Pre-installed Software**: XFCE Desktop, Google Chromium, File Manager, Terminal, and Java (17 & 21).
- **First-Boot Setup Wizard**: Automatically launches on the very first boot to configure your server (Version, Name, RAM, Seed, Max Players) and generates a desktop shortcut to run it.

## How to Compile into an `.iso` file

Because Linux Operating Systems must be compiled within a Linux environment, you cannot natively build this `.iso` on Windows without additional tools.

### Option 1: Use Docker (Recommended)
1. Download and install [Docker Desktop for Windows](https://www.docker.com/products/docker-desktop/).
2. Once Docker is running, double-click the `build.bat` script in this folder.
3. Wait for the process to finish. It will generate a file named `mcs-os.iso`.

### Option 2: Use GitHub Actions (No install required)
1. Create a new repository on GitHub.
2. Upload all the files in this folder to the repository.
3. Create a file named `.github/workflows/build.yml` with the following content:
```yaml
name: Build ISO
on: [push]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Install live-build
        run: sudo apt-get update && sudo apt-get install -y live-build
      - name: Build ISO
        run: sudo lb build
      - name: Upload Artifact
        uses: actions/upload-artifact@v3
        with:
          name: mcs-os
          path: "*.iso"
```
4. GitHub will automatically build your `.iso` and you can download it from the "Actions" tab.

## After Building
1. Flash the `mcs-os.iso` to a USB drive using [Rufus](https://rufus.ie/).
2. Boot a PC or Laptop from the USB drive.
3. The Setup Wizard will automatically appear and guide you through starting your server!
