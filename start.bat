@echo off

title Starting container...

REM Script constants
SET PROJECT_NAME=spark
SET NOTEBOOK_DIR=.\notebook
SET CONTAINER_HOME=/root
SET CONTAINER_NAME=spark_spark_1
SET MACHINE_NAME=test2
SET README_URL=https://github.com/timvisee/hhs-p7-spark-docker/blob/master/README.md

REM Header
@echo Preparing to start container...

REM Check whether to use regular docker or docker tooblox
@WHERE docker-machine
IF %ERRORLEVEL% NEQ 0 (
    REM Make sure docker is installed
    @WHERE docker
    IF %ERRORLEVEL% NEQ 0 (
        REM Show an error message
        @echo.
        @echo ERROR: Docker hasn't been installed correctly.
        @echo        The command 'docker' isn't recognized.
        @echo        Please read the README and follow the installation instructions.

        REM Open the README in the browser
        start "%README_URL%"
        
        exit
    )

    REM Make sure docker-compose is installed
    @WHERE docker-compose
    IF %ERRORLEVEL% NEQ 0 (
        REM Show an error message
        @echo.
        @echo ERROR: Docker hasn't been installed correctly.
        @echo        The command 'docker-compose' isn't recognized.
        @echo        Please read the README and follow the installation instructions.

        REM Open the README in the browser
        start "%README_URL%"
        
        exit
    )

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

) ELSE (
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
    Echo Set the docker machine environment...
    docker-machine env %MACHINE_NAME%

    REM Start the container on the virtual machine...
    @echo Start the container on the virtual machine...
    docker-machine ssh %MACHINE_NAME% "~/hhs-p7-spark-docker/start"

    REM Get the URL Of the running Notebook Jupyter instance 
    @echo Fetching URL for Jupyter Notebook on the virtual machine...
    docker-machine ssh %MACHINE_NAME% "~/hhs-p7-spark-docker/src/build_windows_url"
    docker-machine ssh %MACHINE_NAME% "~/hhs-p7-spark-docker/src/build_windows_url" > temp.txt
    SET /p NOTEBOOK_URL=<temp.txt
    SET /p NOTEBOOK_URL=<temp.txt
    SET /p NOTEBOOK_URL=<temp.txt
    SET /p NOTEBOOK_URL=<temp.txt
    SET /p NOTEBOOK_URL=<temp.txt
    SET /p NOTEBOOK_URL=<temp.txt

    REM Open Notebook in the default browser
    @echo Opening Notebook in your default browser...
    start %NOTEBOOK_URL%

    REM Show the URL of the running notebook instance
    @echo.
    @echo Notebook is running at:
    @echo %NOTEBOOK_URL%
)

REM Started successfully, show a status message
@echo.
@echo Use 'stop.bat' to stop the container.
@echo Start succeeded!

