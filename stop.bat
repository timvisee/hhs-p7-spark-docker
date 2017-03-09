@echo off

title Stopping Spark container...

REM Script constants
SET PROJECT_NAME=spark
SET MACHINE_NAME=test
SET README_URL=https://github.com/timvisee/hhs-p7-spark-docker/blob/master/README.md

REM Check whether to use regular docker or docker tooblox
WHERE docker-machine
IF %ERRORLEVEL% NEQ 0 (
    REM Show a status message
    @echo Switched to regular Docker, not Docker Toolbox

    REM Make sure docker is installed
    WHERE docker
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
    WHERE docker-compose
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

    REM Stop the docker container and detach
    @echo Stopping running Spark container in Docker...
    docker-compose -p "%PROJECT_NAME%" stop
    @echo All Spark containers have been stopped.

) ELSE (
    REM Show a status message
    @echo Switched to Docker toolbox using a VM, not regular Docker

    REM Don't stop the VM if it isn't running anyway
    docker-machine active | find /i "%MACHINE_NAME%"
    IF NOT errorlevel 1 (
        @echo No virtual machine is running for the container, nothing to stop

    ) ELSE (
        REM Stop the container on the virtual machine
        @echo Stop the container on the virtual machine...
        docker-machine ssh %MACHINE_NAME% "cd ~/hhs-p7-spark-docker/ && ~/hhs-p7-spark-docker/stop"

        REM Stop the virtual machine
        @echo Stop the virtual machine...
        docker-machine stop %MACHINE_NAME%

        @echo The container and the virtual machine has been stopped.
    )
)

@echo Use 'start.bat' to restart the container.
