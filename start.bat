@echo off
cls

title "Starting container..."

# Script constants
SET PROJECT_NAME=spark
SET PROJECT_WORK_DIR=.\work
SET CONTAINER_HOME=/home/jovyan

# Header
@echo "Preparing to start Spark container..."

# Start the installation script if the work directory doesn't exist
if not exist "%PROJECT_WORK_DIR%" (
    @echo "The work directory isn't available, starting installation script..."
    install.bat
)

# Start the docker container
@echo "Starting Spark container using Docker..."
docker-compose -f "docker-compose.yml" -p "%PROJECT_NAME%" up -d

# Copy installation script to the container, and run it
docker cp "container/setup" "spark_spark_1:%CONTAINER_HOME%/setup"
docker cp "container/geturl" "spark_spark_1:%CONTAINER_HOME%/geturl"
docker exec spark_spark_1 "%CONTAINER_HOME%/setup"

# It takes a while for notebook to start, wait for this
@echo "Waiting 2 seconds for Jupyter notebook to start..."
sleep 2s

# Get the URL of the running Juptyer Notebook instance
docker exec spark_spark_1 "%CONTAINER_HOME%/setup" > url.txt
SET /p NOTEBOOK_URL=<url.txt

# Open Notebook in the default browser
@echo "Opening Jupyter Notebook in your default browser..."
explorer "%NOTEBOOK_URL%"

# Show the URL of the running notebook instance
@echo
@echo "Notebook is running at:"
@echo "%NOTEBOOK_URL%"
@echo
@echo "Use 'stop.bat' to stop the container."

