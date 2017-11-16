@setlocal enableextensions
::
:: Build script for the icu libraries for Qt5 webkit
@echo Building ICU

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Setup environment.
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call %~dp0cmds\common-setup.cmd
@set ICU_EXTRAS_DIR=%~dp0extras\icu

@set INCLUDE=%INSTALL_PREFIX%\include;%INCLUDE%
@set LIB=%INSTALL_PREFIX%\lib;%LIB%
@if not exist C:\cygwin64\bin (
  echo Failed to find 64-bit cygwin installation
  exit /b 1
)
@set PATH=%INSTALL_PREFIX%\bin;%PATH%;C:\cygwin64\bin

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: We use a customized version of the data library so we can reduce the size
:: It is configured using http://apps.icu-project.org/datacustom/index.html
:: to avoid including a vast amount of data that we will never use
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@set ICU_SRC_URL="http://download.icu-project.org/files/icu4c/57.1/icu4c-57_1-src.zip"
@set ICU_SRC_PKG=icu4c-57_1-src.zip
@set ICU_BUILD_DIR=%BUILD_ROOT%\icu4c-57-1
@call try-mkdir.cmd %ICU_BUILD_DIR%
@cd %ICU_BUILD_DIR%
call download-file.cmd %ICU_SRC_PKG% %ICU_SRC_URL%
@set ICU_ROOT=%ICU_BUILD_DIR%\icu
@rmdir /S /Q %ICU_ROOT%
call extract-zip-file.cmd %ICU_SRC_PKG% %CD%
cd %ICU_ROOT%\source
:: Copy in customized data (this must be tied to the version of icu)
copy %ICU_EXTRAS_DIR%\icudt57l.dat %ICU_ROOT%\source\data\in\icudt57l.dat
:: Copy in newer config files for VS2015
copy %ICU_EXTRAS_DIR%\config.guess %ICU_ROOT%\source\config.guess
copy %ICU_EXTRAS_DIR%\config.sub %ICU_ROOT%\source\config.sub

cd %ICU_ROOT%\source\allinone
call:upgrade-and-build-project %CD%\allinone.sln Release
call:upgrade-and-build-project %CD%\allinone.sln Debug

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
set USEENV=/p:UseEnv=true
set MULTICORE=/m

if not exist %~dp1UpgradeLog.htm (call devenv %1 /upgrade)
:: The vs120 solution is now actually vs140
%BUILD_TOOL% %MULTICORE% %USEENV% %ACTION% /p:Configuration=%2 /p:Platform="x64" %1
goto:eof