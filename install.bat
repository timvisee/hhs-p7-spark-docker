@echo off

title Installing container...

REM Script constants
SET PROJECT_NOTEBOOK_DIR=.\notebook

REM Header
@echo Installation script.

REM Pull the docker image
@echo Pulling container image...
docker-compose -f ".\docker-compose.yml" pull

REM Create the notebook directory
IF NOT EXIST "%PROJECT_NOTEBOOK_DIR%" (
    @echo Creating notebook  directory...
    mkdir "%PROJECT_NOTEBOOK_DIR%"
    icacls "%PROJECT_NOTEBOOK_DIR%" /grant Users:F
)

@echo Installation is done.

