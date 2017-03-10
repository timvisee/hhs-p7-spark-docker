@echo off

title Installing container...

REM Script constants
SET NOTEBOOK_DIR=.\notebook
SET MACHINE_NAME=test2
SET MACHINE_DRIVER=virtualbox
SET README_URL=https://github.com/timvisee/hhs-p7-spark-docker/blob/master/README.md

REM Header
@echo Starting installation...


REM Show a status message
@echo Switched to regular Docker, not Docker Toolbox

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

