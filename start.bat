@echo off

title Starting container...

REM Script constants
SET PROJECT_NAME=spark
SET PROJECT_NOTEBOOK_DIR=.\notebook
SET CONTAINER_HOME=/root

REM Header
@echo Preparing to start container...

REM Start the installation script if the directory doesn't exist
IF NOT EXIST "%PROJECT_NOTEBOOK_DIR%" (
    @echo The notebook directory isn't available, starting installation script...
    call install.bat
)

REM Start the docker container
@echo Starting container using Docker...
docker-compose -f "docker-compose.yml" -p "%PROJECT_NAME%" up -d

REM Get the URL of the running Juptyer Notebook instance
@echo Waiting 2 seconds for Jupyter notebook to start...
docker exec spark_spark_1 /bin/bash "%CONTAINER_HOME%/geturl" > url.txt
SET /p NOTEBOOK_URL=<url.txt

REM Open Notebook in the default browser
@echo Opening Jupyter Notebook in your default browser...
start %NOTEBOOK_URL%

REM Show the URL of the running notebook instance
@echo.
@echo Notebook is running at:
@echo %NOTEBOOK_URL%
@echo.
@echo Use 'stop.bat' to stop the container.

