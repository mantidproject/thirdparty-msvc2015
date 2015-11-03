@setlocal enableextensions
::
:: Build script for the static versions of the Qt libraries.
:: These are only used for the PyQt4 distribution. It assumes the
:: shared version has been built and installed first
@echo Building Qt

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Setup environment. Important to ensure correct detection of environment
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call %~dp0cmds\common-setup.cmd
@set INCLUDE=%INSTALL_ROOT%\include;%INCLUDE%
@set LIB=%INSTALL_ROOT%\lib;%LIB%
@set JOM_DIR=%BUILD_ROOT%\jom
@set PATH=%INSTALL_ROOT%\bin;%JOM_DIR%;%PATH%

@set QT_EXTRAS_DIR=%~dp0extras\qt
@set NJOBS=8

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Download and unpack source
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@set SRC_PKG=qt-everywhere-opensource-src-4.8.6.zip
@set DLL_BUILD_DIR=%BUILD_ROOT%\Qt
@set BUILD_DIR=%BUILD_ROOT%\Qt-static

@call try-mkdir.cmd %BUILD_DIR%
@cd %BUILD_DIR%
if not exist %SRC_PKG% copy %DLL_BUILD_DIR%\%SRC_PKG% .
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

:: patch other sources for 2015 support
if not exist src\3rdparty\javascriptcore\JavaScriptCore\wtf\TypeTraits.h.orig patch -p1 --input=%QT_EXTRAS_DIR%\fix-build-msvc2015.patch --backup
if not exist src\3rdparty\webkit\Source\JavaScriptCore\wtf\HashSet.h.orig patch -p0 --input=%QT_EXTRAS_DIR%\fix-webkit-msvc2015.patch --backup

:: configure. Do not install this version!
configure -platform win32-msvc2015 -opensource -confirm-license -release -static -no-plugin-manifests ^
 -openssl -qt-zlib -no-webkit -nomake examples -nomake demos -make nmake -no-vcproj
if not ERRORLEVEL 0 exit /b %ERRORLEVEL% 

:: build everything
jom.exe -j%NJOBS%

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Finalize
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call try-pause.cmd
goto:eof
