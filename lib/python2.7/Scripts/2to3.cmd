@echo off
REM This script was hand written.
setlocal enableextensions
REM python launcher script. Uses a relative path to the Python
REM executable to ensure it is relocatable
set _this_dir=%~dp0
%~dp0\..\python.exe %_this_dir%2to3 %*
