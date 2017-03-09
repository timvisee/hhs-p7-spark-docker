@echo off

title Uninstalling container...

REM Get the current directory
SET DIR=%~dp0

REM Script constants
SET PROJECT_NAME=spark
SET NOTEBOOK_DIR="%DIR%\notebook"
SET DOCKER_IMAGE="timvisee/hhs-p7-spark-docker:latest"
SET MACHINE_NAME=test2

REM Header
@echo Uninstallation script.
@echo.
@echo Repository directory: %DIR%
@echo.

@echo This script will uninstall all your user data, the container and
@echo the repository holding the management scripts. This data can't be
@echo recovered after uninstallation.
@echo.

@echo Uninstalling will also remove the container image, which is about
@echo 1.3GB in size.
@echo.

@echo The project and the container can be used again by getting the
@echo project from GitHub.
@echo.

@echo Are you sure you want to continue the uninstallation?
@echo.
@echo No:  Press CRTL+C
@echo Yes: Press any key

REM Wait for user input
pause

REM Stop any running containers
call stop.bat

REM Validate Docker is installed correctly
@WHERE docker-machine
IF %ERRORLEVEL% NEQ 0 (
    REM Make sure docker is installed
    @WHERE docker
    IF %ERRORLEVEL% NEQ 0 (
        REM Show an error message
        @echo.
        @echo ERROR: Docker hasn't been installed correctly.
        @echo        The command 'docker' isn't recognized.
        @echo        Because of this, the container can't be uninstalled.
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
        @echo        Because of this, the container can't be uninstalled.
        @echo        Please read the README and follow the installation instructions.

        REM Open the README in the browser
        start "%README_URL%"
        
        exit
    )
)

REM Remove the user data
@echo Uninstalling user data...
rmdir "%NOTEBOOK_DIR%" /s
@echo User data uninstalled!
@echo.

REM Check whether to use regular docker or docker tooblox
WHERE docker-machine
IF %ERRORLEVEL% NEQ 0 (
    REM Show a status message
    @echo Switched to regular Docker, not Docker toolbox

    REM Remove the container and image
    @echo Uninstalling container...
    docker-compose -f "docker-compose.yml" -p "%PROJECT_NAME%" rm -f
    docker rmi "%DOCKER_IMAGE%"
    @echo Container uninstalled!
    @echo.

) ELSE (
    REM Show a status message
    @echo Switched to Docker toolbox using a VM, not regular Docker

    REM Install the virtual machine if it doesn't exist
    docker-machine ls | find /i "%MACHINE_NAME%"
    IF NOT errorlevel 1 (
        REM Uninstall the virtual machine
        @echo Uninstall the virtual machine for Docker...
        docker-machine rm %MACHINE_NAME%

    ) ELSE (
        @echo Virtual machine for Docker could not be found. 
        @echo It has probably already been uninstalled.
    )
)

REM Uninstall/remove the repository
@echo Uninstalling repository...
rmdir "%DIR%" /s
@echo Repository uninstalled!
@echo.

REM Move to the parent directory
cd ..

REM Show a docker notice
@echo This project doesn't require docker anymore, thus it may be uninstalled.
@echo This must be done manually.
@echo.

REM We're done!
echo Uninstallation finished!
