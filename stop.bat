@echo off

title Stopping Spark container...

REM Script constants
SET PROJECT_NAME=spark
SET MACHINE_NAME=test2
SET README_URL=https://github.com/timvisee/hhs-p7-spark-docker/blob/master/README.md


REM Stop the docker container and detach
@echo Stopping running Spark container in Docker...
docker-compose -p "%PROJECT_NAME%" stop
@echo All Spark containers have been stopped.


@echo Use 'start.bat' to restart the container.
