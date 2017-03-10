@echo off

title Stopping Spark container...

REM Script constants
SET PROJECT_NAME=spark
SET MACHINE_NAME=test2
SET README_URL=https://github.com/timvisee/hhs-p7-spark-docker/blob/master/README.md

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
    REM docker-machine stop
    "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" controlvm %MACHINE_NAME% savestate

    @echo The container and the virtual machine has been stopped.
)

@echo Use 'start.bat' to restart the container.
