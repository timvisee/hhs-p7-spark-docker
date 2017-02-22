@echo off

title Updating container...

REM Header
@echo Updating container scripts...

REM Stop running containers
call stop.bat

@echo Fetching new updates...
git fetch

@echo Checking out latest version...
git checkout origin/master

echo Update done.

