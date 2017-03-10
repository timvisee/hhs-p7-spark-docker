@echo off
setlocal EnableDelayedExpansion

title Starting container...

REM Script constants
SET PROJECT_NAME=spark
SET CONTAINER_HOME=/root
SET CONTAINER_NAME=spark_spark_1
SET MACHINE_NAME=spark-docker
SET README_URL=https://github.com/timvisee/hhs-p7-spark-docker/blob/master/README.md

REM Header
@echo Preparing to start container...

REM TODO: Make sure docker-machine is installed

REM Show a status message
@echo Switched to Docker toolbox using a VM, not regular Docker

REM Install the virtual machine if it doesn't exist
docker-machine ls | find /i "%MACHINE_NAME%"
IF NOT errorlevel 1 (
    @echo Virtual machine for Docker detected

    REM Make sure the Docker virtual machine is started
    @echo Ensure the Docker virtual machine is started...
    docker-machine start %MACHINE_NAME%

) ELSE (
    @echo Virtual machine for Docker could not be found. Running installation...
    call install.bat
)

REM Set the docker machine environment
@echo Set the docker machine environment to %MACHINE_NAME%...
docker-machine env %MACHINE_NAME%

REM Start the container on the virtual machine...
@echo Start the container on the virtual machine...
docker-machine ssh %MACHINE_NAME% "~/hhs-p7-spark-docker/start"

REM Get the URL Of the running Notebook Jupyter instance 
@echo Fetching URL for Jupyter Notebook on the virtual machine...
docker-machine ssh %MACHINE_NAME% "~/hhs-p7-spark-docker/src/build_windows_url"
docker-machine ssh %MACHINE_NAME% "~/hhs-p7-spark-docker/src/build_windows_url" > url.txt
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

