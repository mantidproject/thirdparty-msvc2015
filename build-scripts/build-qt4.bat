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
@set PATH=%INSTALL_ROOT%\bin;%INSTALL_ROOT%\lib\qt4\bin;%PATH%

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
:: patch make files for our changed zlib library name
if not exist src\tools\bootstrap\bootstrap.pri.orig patch -p0 --input=%QT_EXTRAS_DIR%\bootstrap.pri.patch --backup
if not exist src\3rdparty\zlib_dependency.pri.orig  patch -p0 --input=%QT_EXTRAS_DIR%\zlib_dependency.pri.patch --backup

:: patch other sources for 2015 support
if not exist src\3rdparty\javascriptcore\JavaScriptCore\wtf\TypeTraits.h.orig patch -p1 --input=%QT_EXTRAS_DIR%\fix-build-msvc2015.patch --backup
if not exist src\3rdparty\webkit\Source\JavaScriptCore\wtf\HashSet.h.orig patch -p0 --input=%QT_EXTRAS_DIR%\fix-webkit-msvc2015.patch --backup

:: configure. Passing the prefix option requires the mkspecs to have been installed in the root already!
set QT_INSTALL_PREFIX=%INSTALL_ROOT%\lib\qt4
@xcopy %QT_ROOT%\mkspecs\* %QT_INSTALL_PREFIX%\mkspecs /Y /E /I
configure -platform win32-msvc2015 -opensource -confirm-license -debug-and-release -no-plugin-manifests ^
 -openssl -webkit -nomake examples -nomake demos -make nmake -no-vcproj ^
 -prefix %QT_INSTALL_PREFIX%
if not ERRORLEVEL 0 exit /b %ERRORLEVEL% 

:: build everything
jom.exe -j%NJOBS%

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Install
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: the makefile install rule uses [DRIVE]:$(INSTALL_ROOT)\...
:: remove the definition temporarily
set INSTALL_PREFIX=%INSTALL_ROOT%
set INSTALL_ROOT=
nmake install

:: Qt builds are by default tied to their build location. A qt.conf file is required to be portable
@set QT_CONF_FILE=%QT_INSTALL_PREFIX%\bin\qt.conf
echo [Paths] > %QT_CONF_FILE%
echo Prefix = .. >> %QT_CONF_FILE%
:: A copy is required in the lib folder too
copy %QT_CONF_FILE% %QT_INSTALL_PREFIX%\lib\qt.conf

:: remove stuff we don't want to keep
for %%D in (demos doc examples tests) do rmdir /S /Q %QT_INSTALL_PREFIX%\%%D
for %%F in (q3porting.xml) do del %QT_INSTALL_PREFIX%\%%F

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Finalize
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call try-pause.cmd
goto:eof
