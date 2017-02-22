@echo off

title Stopping Spark container...

REM Script constants
SET PROJECT_NAME=spark

REM Stop the docker container and detach
@echo Stopping running Spark container in Docker...
docker-compose -p "%PROJECT_NAME%" stop
@echo All Spark containers have been stopped.
@echo Use 'start.bat' to restart the container.
