@echo off
cls

title Stopping Spark container...

# Script constants
SET PROJECT_NAME=spark

# Stop the docker container and detach
@echo "Stopping running Spark container in Docker..."
docker-compose -p "%PROJECT_NAME%" stop
@echo "All Spark containers have been stopped."

