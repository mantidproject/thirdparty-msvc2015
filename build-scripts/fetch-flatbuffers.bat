@setlocal enableextensions
::
:: Downloads the Google Flatbuffers library for Mantid and
:: copies headers to the dependency folder
@echo Fetching Google Flatbuffers Library

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Setup environment. Important to ensure correct detection of environment
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call %~dp0cmds\common-setup.cmd

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Download and unpack source
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@set SRC_PKG_URL="https://github.com/google/flatbuffers/archive/v1.3.0.zip"
@set SRC_PKG=v1.3.0.zip
@set BUILD_DIR=%BUILD_ROOT%\flatbuffers

@call try-mkdir.cmd %BUILD_DIR%
@cd %BUILD_DIR%
@call download-file.cmd %SRC_PKG% %SRC_PKG_URL%

set FLATBUFFERS_ROOT=%BUILD_DIR%\flatbuffers-1.3.0
@call extract-zip-file.cmd %SRC_PKG% %CD%

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Install
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
if not exist %INSTALL_ROOT%\include\flatbuffers mkdir %INSTALL_ROOT%\include\flatbuffers
xcopy %FLATBUFFERS_ROOT%\include\flatbuffers\* %INSTALL_ROOT%\include\flatbuffers /Y