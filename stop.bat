@echo off
cls

title Stopping Spark container...

# Stop the docker container and detach
@echo "Stopping running Spark container in Docker..."
docker-compose -p spark stop
@echo "All Spark containers have been stopped."

