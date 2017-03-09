@echo off

title Starting container...

REM Script constants
SET PROJECT_NAME=spark
SET NOTEBOOK_DIR=.\notebook
SET CONTAINER_HOME=/root
SET NOTEBOOK_URL="http://localhost:8888"
SET MACHINE_NAME=hhs-p7-spark-docker

REM Header
@echo Preparing to start container...

REM Start the installation script if the directory doesn't exist
IF NOT EXIST "%NOTEBOOK_DIR%" (
    @echo The notebook directory isn't available, starting installation...
    call install.bat
    @echo.
)

REM Check whether to use regular docker or docker tooblox
WHERE docker-machine
IF %ERRORLEVEL% NEQ 0 (
    REM Show a status message
    @echo Switched to regular Docker, not Docker Toolbox

    REM Start the docker container
    @echo Starting container using Docker...
    docker-compose -f "docker-compose.yml" -p "%PROJECT_NAME%" up -d

    REM Get the URL of the running Juptyer Notebook instance
    @echo Waiting 2 seconds for Jupyter Notebook to start...
    @timeout /t 2 /nobreak
    REM TODO: Get container name from constant
    docker exec spark_spark_1 /bin/bash "%CONTAINER_HOME%/geturl" > url.txt
    SET /p NOTEBOOK_URL=<url.txt

) ELSE (
    REM Show a status message
    @echo Switched to Docker toolbox, not regular Docker

    REM Install the virtual machine if it doesn't exist
    docker-machine ls | find /i "%MACHINE_NAME%"
    IF NOT errorlevel 1 (
        @echo Virtual machine for Docker detected

        REM Make sure the Docker virtual machine is started
        @echo Ensure the Docker virtual machine is started...
        docker-machine start hhs-p7-spark-docker

    ) ELSE (
        @echo Virtual machine for Docker could not be found. Creating...

        REM Create the docker machine
        @echo Creating virtual Linux machine to run Docker on...
        docker-machine create --driver virtualbox %MACHINE_NAME%

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

        REM Install the container on the virtual machine...
        @echo Install the container on the virtual machine...
        docker-machine ssh %MACHINE_NAME% "~/hhs-p7-spark-docker/install"
    )

    REM Start the container on the virtual machine...
    echo Start the container on the virtual machine...
    docker-machine ssh %MACHINE_NAME% "~/hhs-p7-spark-docker/start"

    REM Get the URL Of the running Notebook Jupyter instance 
    REM TODO: Get container name from constant
    @echo Fetching URL for Jupyter Notebook on the virtual machine...
    docker-machine ssh %MACHINE_NAME% 'docker exec spark_spark_1 /bin/bash "%CONTAINER_HOME%/geturl"' > temp.txt
    SET /p NOTEBOOK_URL_LOCAL=<temp.txt

    REM Fetch the URLs of the active machines
    REM TODO: Make sure to only fetch the URL of the docker machine, and not other ones
    @echo Getting host address of the virtual machine...
    docker-machine ssh %MACHINE_NAME% "ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p' | head -n 1" > temp.txt
    SET /p NOTEBOOK_HOST=<temp.txt

    REM TODO: Remove this debug code!
    @echo.
    @echo LIST OF HOSTS:
    docker-machine ssh %MACHINE_NAME% "ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'"
    @echo.

    REM Replace localhost with virtual machine IP...
    @echo Replace localhost with virtual machine host...
    SET NOTEBOOK_URL=!NOTEBOOK_URL_LOCAL:localhost=%NOTEBOOK_HOST%!
)

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

