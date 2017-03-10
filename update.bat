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


REM Show a status message
@echo Switched to regular Docker, not Docker Toolbox

echo "Forcing installation for update..."
call install.bat

echo Use the 'start.bat' command to start the updated container.
echo Update finished!

