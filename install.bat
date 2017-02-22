@echo off

title Installing container...

REM Script constants
SET PROJECT_WORK_DIR=.\work
SET PROJECT_RESOURCE_DIR=.\res

REM Header
@echo Installation script.

REM Pull the docker image
@echo Updating container image...
docker-compose -f ".\docker-compose.yml" pull

REM Create the work directory
IF NOT EXIST "%PROJECT_WORK_DIR%" (
    @echo Createing working directory...
    mkdir "%PROJECT_WORK_DIR%"
    icacls "%PROJECT_WORK_DIR%" /grant Users:F
)

@echo Installation is done.

