@echo off

title Updating container...

REM Header
@echo Starting update...

REM Stop running containers
call stop.bat

@echo Fetching changes from the repository...
git fetch

@echo Pulling all changes...
git pull

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

    echo "Forcing installation for update..."
    call install.bat

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

        REM Update the container on the virtual machine...
        @echo Update the container on the virtual machine...
        docker-machine ssh %MACHINE_NAME% "~/hhs-p7-spark-docker/update"

    ) ELSE (
        @echo Virtual machine for Docker could not be found. Running installation...
        call install.bat
    )
)

echo Use the 'start.bat' command to start the updated container.
echo Update finished!

