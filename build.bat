@echo off
echo Building Minecraft Server OS ISO...
echo This requires Docker Desktop to be installed and running.

docker build -t mcs-os-builder .
if %errorlevel% neq 0 (
    echo Docker build failed. Please ensure Docker is installed and running.
    pause
    exit /b %errorlevel%
)

echo Starting build process inside Docker container...
docker run --rm --privileged -v "%cd%":/build -w /build mcs-os-builder lb build

if exist live-image-amd64.hybrid.iso (
    echo Build complete! Your ISO is named live-image-amd64.hybrid.iso.
    ren live-image-amd64.hybrid.iso mcs-os.iso
    echo Renamed to mcs-os.iso
) else (
    echo Build failed. ISO not generated.
)

pause
