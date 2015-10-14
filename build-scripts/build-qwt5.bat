@setlocal enableextensions
::
:: Build script for Qwt5 with Qt4
@echo Building Qwt5

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Setup environment. Important to ensure correct detection of environment
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call %~dp0cmds\common-setup.cmd
@set QWT5_EXTRAS_DIR=%~dp0extras\qwt5
@set PATH=%INSTALL_ROOT%\bin;%INSTALL_ROOT%\lib\qt4;%BUILD_ROOT%\jom;%PATH%
@set NJOBS=8

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Download and unpack source. We use the HDF5 patched source that has been
:: patched to build with CMake
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@set SRC_PKG_URL="https://downloads.sourceforge.net/project/qwt/qwt/5.2.3/qwt-5.2.3.zip"
@set BUILD_DIR=%BUILD_ROOT%\qwt5
@set SRC_PKG=qwt-5.2.3.zip
@set SRC_ROOT=%BUILD_DIR%\%SRC_PKG:~0,-4%
@call download-and-extract.cmd %BUILD_DIR%\%SRC_PKG% %SRC_PKG_URL%

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Patch
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
cd %SRC_ROOT%

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Build
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
if not exist %SRC_ROOT%\qwtconfig.pri.orig (
  copy /Y %SRC_ROOT%\qwtconfig.pri %SRC_ROOT%\qwtconfig.pri.orig
  copy /Y %QWT5_EXTRAS_DIR%\qwtconfig.pri %SRC_ROOT%\qwtconfig.pri
)
qmake
nmake

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Install
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
set INSTALL_PREFIX=%INSTALL_ROOT%
:: nmake uses this internally
set INSTALL_ROOT=
nmake install
:: Change of INSTALLBASE still leaves files in the wrong place so move them manually
set QWT_INSTALLBASE=C:\%SRC_PKG:~0,-4%
if not exist %INSTALL_PREFIX%\include\qwt-qt4 mkdir %INSTALL_PREFIX%\include\qwt-qt4
xcopy %QWT_INSTALLBASE%\include\*.h %INSTALL_PREFIX%\include\qwt-qt4 /Y /I
xcopy %QWT_INSTALLBASE%\lib\*.dll %INSTALL_PREFIX%\bin /Y /I
xcopy %QWT_INSTALLBASE%\lib\*.pdb %INSTALL_PREFIX%\bin /Y /I
xcopy %QWT_INSTALLBASE%\lib\*.lib %INSTALL_PREFIX%\lib /Y /I

rmdir /S /Q %QWT_INSTALLBASE%\

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Finalize
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call try-pause.cmd
goto:eof
