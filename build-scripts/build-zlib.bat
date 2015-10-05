@setlocal enableextensions
::
:: Build script for zlib
::
@echo Building zlib

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Setup environment. Important to ensure correct detection of environment
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call %~dp0cmds\common-setup.cmd

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Download and unpack source
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@set SRC_PKG_URL="http://downloads.sourceforge.net/project/libpng/zlib/1.2.8/zlib128.zip?r=http%3A%2F%2Fwww.zlib.net%2F&ts=1444063036&use_mirror=kent"
@set SRC_PKG=zlib128.zip
@set BUILD_DIR=%BUILD_ROOT%\zlib

@call try-mkdir.cmd %BUILD_DIR%
@cd %BUILD_DIR%
@call download-file.cmd %SRC_PKG% %SRC_PKG_URL%

@set ZLIB_ROOT=%BUILD_DIR%\zlib-1.2.8
@if not exist %ZLIB_ROOT% @call extract-zip-file.cmd %SRC_PKG% %CD%

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Build
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call:upgrade-and-build-project %ZLIB_ROOT%\contrib\vstudio\vc11\zlibvc.vcxproj Release
@call:upgrade-and-build-project %ZLIB_ROOT%\contrib\vstudio\vc11\zlibvc.vcxproj Debug

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
set EXTRASW=/m
set USEENV=/p:UseEnv=true

if not exist %~dp1UpgradeLog.htm (call devenv %1 /upgrade)
:: The original solution is now actually vs140
%BUILD_TOOL% %USEENV% %EXTRASW% %ACTION% /p:Configuration=%2 /p:Platform=x64 %1
goto:eof