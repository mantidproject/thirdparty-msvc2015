@setlocal enableextensions
::
:: Build script for the Poco libraries for Mantid. All libraries are built.
:: Requires OpenSSL
::
@echo Building poco

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Setup environment. Important to ensure correct detection of environment
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call %~dp0cmds\common-setup.cmd

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Download and unpack source
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@set SRC_PKG_URL="https://github.com/pocoproject/poco/archive/poco-1.4.7p1-release.zip"
@set SRC_PKG=poco-1.4.7p1-release.zip
@set BUILD_DIR=%BUILD_ROOT%\poco

@call try-mkdir.cmd %BUILD_DIR%
@cd %BUILD_DIR%
@call download-file.cmd %SRC_PKG% %SRC_PKG_URL%

set POCO_ROOT=%BUILD_DIR%\poco-poco-1.4.7p1-release
if not exist %POCO_ROOT% @call extract-zip-file.cmd %SRC_PKG% %CD%

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Build
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@cd %POCO_ROOT%
set VS_SUFFIX_OLD=120
set LIBRARIES=Foundation XML Util Net  Zip
:: Crypto NetSSL_OpenSSL -- require SSL

for %%C in (%LIBRARIES%) do call:upgrade-and-build-project %%C\%%C_x64_vs%VS_SUFFIX_OLD%.vcxproj

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Install
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Finalize
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call try-pause.cmd
goto:eof

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Functions
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:upgrade-and-build-project
set BUILD_TOOL=msbuild
set ACTION=/t:build
set CONFIGSW=/p:Configuration=
set EXTRASW=/m
set USEENV=/p:UseEnv=true

if not exist %~dp1UpgradeLog.htm (call devenv %1 /upgrade)
:: The vs120 solution is now actually vs140
%BUILD_TOOL% %USEENV% %EXTRASW% %ACTION% %CONFIGSW%release_shared %1
%BUILD_TOOL% %USEENV% %EXTRASW% %ACTION% %CONFIGSW%debug_shared %1
goto:eof