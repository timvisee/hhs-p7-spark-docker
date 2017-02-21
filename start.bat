@echo off
cls

title "Starting container..."

REM Script constants
SET PROJECT_NAME=spark
SET PROJECT_WORK_DIR=.\work
SET CONTAINER_HOME=/home/jovyan

REM Header
@echo "Preparing to start Spark container..."

REM Start the installation script if the work directory doesn't exist
IF NOT EXIST "%PROJECT_WORK_DIR%" (
    @echo "The work directory isn't available, starting installation script..."
    install.bat
)

REM Start the docker container
@echo "Starting Spark container using Docker..."
docker-compose -f "docker-compose.yml" -p "%PROJECT_NAME%" up -d

REM Copy installation script to the container, and run it
docker cp "container/setup" "spark_spark_1:%CONTAINER_HOME%/setup"
docker cp "container/geturl" "spark_spark_1:%CONTAINER_HOME%/geturl"
docker exec spark_spark_1 "%CONTAINER_HOME%/setup"

REM It takes a while for notebook to start, wait for this
@echo "Waiting 2 seconds for Jupyter notebook to start..."
sleep 2s

REM Get the URL of the running Juptyer Notebook instance
docker exec spark_spark_1 "%CONTAINER_HOME%/setup" > url.txt
SET /p NOTEBOOK_URL=<url.txt

REM Open Notebook in the default browser
@echo "Opening Jupyter Notebook in your default browser..."
explorer "%NOTEBOOK_URL%"

REM Show the URL of the running notebook instance
@echo
@echo "Notebook is running at:"
@echo "%NOTEBOOK_URL%"
@echo
@echo "Use 'stop.bat' to stop the container."

