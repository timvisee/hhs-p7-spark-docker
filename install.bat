@echo off

title Installing container...

REM Script constants
SET NOTEBOOK_DIR=.\notebook

REM Header
@echo Starting installation...

REM Pull the docker image
@echo Pulling container image...
docker-compose -f ".\docker-compose.yml" pull

REM Create the notebook directory
IF NOT EXIST "%NOTEBOOK_DIR%" (
    @echo Creating notebook directory...
    mkdir "%NOTEBOOK_DIR%"

    @echo Setting proper directory permissions...
    icacls "%NOTEBOOK_DIR%" /grant Users:F
)

@echo Installation finished!

