@echo off
cls

title Updating container...

REM Header
@echo Updating container scripts...

@echo Fetching new updates...
git fetch

@echo Checking out latest version...
git checkout origin/master

echo Update done.

