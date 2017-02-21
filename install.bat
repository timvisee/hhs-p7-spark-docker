@echo off
cls

title "Installing container..."

# Script constants
SET PROJECT_WORK_DIR=.\work
SET PROJECT_RESOURCE_DIR=.\res

# Header
@echo "Installation script."

# Pull the docker image
@echo "Updating container image..."
docker-compose -f ".\docker-compose.yml" pull

# Create the work directory
if not exist "%PROJECT_WORK_DIR%" (
    @echo "Createing working directory..."
    mkdir "%PROJECT_WORK_DIR%"
    icacls "%PROJECT_WORK_DIR%" /grant Users:F
)

@echo "Installation is done."

