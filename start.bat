@echo off
setlocal EnableDelayedExpansion

title Starting container...

REM Script constants
SET PROJECT_NAME=spark
SET NOTEBOOK_DIR=.\notebook
SET CONTAINER_HOME=/root
SET CONTAINER_NAME=spark_spark_1
SET README_URL=https://github.com/timvisee/hhs-p7-spark-docker/blob/master/README.md

REM Header
@echo Preparing to start container...

REM Show a status message
@echo Switched to regular Docker, not Docker Toolbox

REM Start the installation script if the directory doesn't exist
IF NOT EXIST "%NOTEBOOK_DIR%" (
    @echo The notebook directory isn't available, starting installation...
    call install.bat
    @echo.
)

REM Start the docker container
@echo Starting container using Docker...
docker-compose -f "docker-compose.yml" -p "%PROJECT_NAME%" up -d

REM Get the URL of the running Juptyer Notebook instance
@echo Waiting 2 seconds for Jupyter Notebook to start...
@timeout /t 2 /nobreak
docker exec %CONTAINER_NAME% /bin/bash "%CONTAINER_HOME%/geturl" > url.txt
SET /p NOTEBOOK_URL=<url.txt

REM Open Notebook in the default browser
@echo Opening Notebook in your default browser...
start %NOTEBOOK_URL%

REM Show the URL of the running notebook instance
@echo.
@echo Notebook is running at:
@echo %NOTEBOOK_URL%

REM Started successfully, show a status message
@echo.
@echo Use 'stop.bat' to stop the container.
@echo Start succeeded!

