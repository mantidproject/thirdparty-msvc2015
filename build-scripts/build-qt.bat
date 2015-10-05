@setlocal enableextensions
::
:: Build script for the Qt libraries for Mantid.
:: It requires zlib to have been built and installed
@echo Building Qt

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Setup environment. Important to ensure correct detection of environment
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call %~dp0cmds\common-setup.cmd
@set INCLUDE=%INSTALL_ROOT%\include;%INCLUDE%
@set LIB=%INSTALL_ROOT%\lib;%LIB%

@set QT_EXTRAS_DIR=%~dp0extras\qt
@set NJOBS=8

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Download and unpack jom. Enables parallel builds on Windows with nmake
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@set JOM_SRC_URL="https://download.qt.io/official_releases/jom/jom_1_1_0.zip"
@set JOM_SRC_PKG=jom_1_1_0.zip
@set JOM_DIR=%BUILD_ROOT%\jom
@call try-mkdir.cmd %JOM_DIR%
@cd %JOM_DIR%
@if not exist %JOM_DIR%\jom.exe (
  call download-file.cmd %JOM_SRC_PKG% %JOM_SRC_URL%
  call extract-zip-file.cmd %JOM_SRC_PKG% %CD%
)
@set PATH=%PATH%;%JOM_DIR%

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Download and unpack source
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@set SRC_PKG_URL="http://download.qt.io/archive/qt/4.8/4.8.6/qt-everywhere-opensource-src-4.8.6.zip"
@set SRC_PKG=qt-everywhere-opensource-src-4.8.6.zip
@set BUILD_DIR=%BUILD_ROOT%\Qt

@call try-mkdir.cmd %BUILD_DIR%
@cd %BUILD_DIR%
@call download-file.cmd %SRC_PKG% %SRC_PKG_URL%
@set QT_ROOT=%BUILD_DIR%\qt-everywhere-opensource-src-4.8.6
@if not exist %QT_ROOT% @call extract-zip-file.cmd %SRC_PKG% %CD%

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Configure & build
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@cd %QT_ROOT%
:: Qt 4.8 doesn't have a mkspec for VS2015 built in so copy in ours
@xcopy %QT_EXTRAS_DIR%\win32-msvc2015\* %QT_ROOT%\mkspecs\win32-msvc2015 /Y /E /I
:: patch qmake makefile for VS2015 support
cd %QT_ROOT%\qmake
if not exist Makefile.win32.orig patch -p0 --input=%QT_EXTRAS_DIR%\qmake-makefile.win32.patch --backup
cd %QT_ROOT%

:: configure
@configure -prefix %INSTALL_ROOT% -platform win32-msvc2015 -opensource -confirm-license -debug-and-release -no-plugin-manifests^
 -qt-sql-sqlite -system-zlib -webkit -nomake examples -nomake demos -make nmake

:: build everything
jom.exe -j%NJOBS%

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
:: The vs120 solution is now actually vs140
%BUILD_TOOL% %USEENV% %EXTRASW% %ACTION% /p:Configuration=%2 %1
goto:eof