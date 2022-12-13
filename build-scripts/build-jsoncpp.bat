@setlocal enableextensions
::
:: Build script JsonCPP
@echo Building JSONCpp

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Setup environment. Important to ensure correct detection of environment
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call %~dp0cmds\common-setup.cmd
@set JSONCPP_EXTRAS_DIR=%~dp0extras\jsoncpp

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Download and unpack source.
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@set SRC_PKG_URL="https://codeload.github.com/open-source-parsers/jsoncpp/zip/1.9.1"
@set BUILD_DIR=%BUILD_ROOT%\jsoncpp
@set SRC_PKG=1.9.1.zip
@set SRC_ROOT=%BUILD_DIR%\jsoncpp-1.9.1
@if not exist %SRC_ROOT% call download-and-extract.cmd %BUILD_DIR%\%SRC_PKG% %SRC_PKG_URL%

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Patch
