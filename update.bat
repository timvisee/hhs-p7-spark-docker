@echo off

title Updating container...

REM Header
@echo Starting update...

REM Stop running containers
call stop.bat

@echo Fetching new updates from repository...
git fetch

@echo Checking out latest version...
git checkout origin/master

echo "Forcing installation for update..."
call install.bat

echo Use the 'start.bat' command to start the updated container.
echo Update finished!

