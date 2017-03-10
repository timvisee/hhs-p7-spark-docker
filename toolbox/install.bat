@echo off

title Installing container...

REM Script constants
SET NOTEBOOK_DIR=.\notebook
SET MACHINE_NAME=spark-docker
SET MACHINE_DRIVER=virtualbox
SET README_URL=https://github.com/timvisee/hhs-p7-spark-docker/blob/master/README.md

REM Header
@echo Starting installation...

REM Show a status message
@echo Switched to Docker toolbox using a VM, not regular Docker

REM Install the virtual machine if it doesn't exist
docker-machine ls | find /i "%MACHINE_NAME%"
IF NOT errorlevel 1 (
    @echo Installed virtual machine for Docker detected

    REM Make sure the Docker virtual machine is started
    @echo Ensure the Docker virtual machine is started...
    docker-machine start %MACHINE_NAME%

) ELSE (
    @echo Virtual machine for Docker could not be found. Creating...

    REM Create the docker machine
    @echo Creating virtual Linux machine to run Docker on...
    docker-machine create --driver %MACHINE_DRIVER% %MACHINE_NAME%

    REM Install bash on the virtual machine
    @echo Install bash on virtual machine...
    docker-machine ssh %MACHINE_NAME% "tce-load -wi bash.tcz"

    REM Clone the project repository on the virtual machine
    @echo Clone the repository on the virtual machine...
    docker-machine ssh %MACHINE_NAME% "git clone https://github.com/timvisee/hhs-p7-spark-docker.git ~/hhs-p7-spark-docker"

    REM Install docker-compose on the virtual machine
    @echo Install docker-compose on the virtual machine...
    docker-machine ssh %MACHINE_NAME% "sudo curl -L https://github.com/docker/compose/releases/download/1.11.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose"
    @echo Make docker-compose executable...
    docker-machine ssh %MACHINE_NAME% "sudo chmod +x /usr/local/bin/docker-compose"
)

REM Install the container on the virtual machine...
@echo Install the container on the virtual machine...
docker-machine ssh %MACHINE_NAME% "~/hhs-p7-spark-docker/install"

@echo Installation finished!

