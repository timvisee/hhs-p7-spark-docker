@echo off

title Stopping Spark container...

REM Script constants
SET PROJECT_NAME=spark
SET MACHINE_NAME=hhs-p7-spark-docker

REM Check whether to use regular docker or docker tooblox
WHERE docker-machine
IF %ERRORLEVEL% NEQ 0 (
    REM Show a status message
    @echo Switched to regular Docker, not Docker Toolbox

    REM Stop the docker container and detach
    @echo Stopping running Spark container in Docker...
    docker-compose -p "%PROJECT_NAME%" stop
    @echo All Spark containers have been stopped.

) ELSE (
    REM Show a status message
    @echo Switched to Docker toolbox using a VM, not regular Docker

    REM Install the virtual machine if it doesn't exist
    docker-machine active | find /i "%MACHINE_NAME%"
    IF NOT errorlevel 1 (
        @echo No virtual machine is running for the container

    ) ELSE (
        REM Stop the container on the virtual machine
        @echo Stop the container on the virtual machine...
        docker-machine ssh %MACHINE_NAME% "~/hhs-p7-spark-docker/stop"

        REM Stop the virtual machine
        @echo Stop the virtual machine...
        docker-machine stop %MACHINE_NAME%

        @echo The container and the virtual machine has been stopped.
    )
)

@echo Use 'start.bat' to restart the container.
