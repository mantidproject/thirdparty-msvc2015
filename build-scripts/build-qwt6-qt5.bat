@setlocal enableextensions
::
:: Build script for Qwt6 with Qt5
@echo Building Qwt6

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Setup environment. Important to ensure correct detection of environment
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call %~dp0cmds\common-setup.cmd
@set QWT6_EXTRAS_DIR=%~dp0extras\qwt6
@set PATH=%INSTALL_PREFIX%\bin;%INSTALL_PREFIX%\lib\qt5\bin;%BUILD_ROOT%\jom;%PATH%
@set NJOBS=8

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Download and unpack source.
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@set SRC_PKG_URL="https://downloads.sourceforge.net/project/qwt/qwt/6.1.3/qwt-6.1.3.zip"
@set BUILD_DIR=%BUILD_ROOT%\qwt6
@set SRC_PKG=qwt-6.1.3.zip
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
  copy /Y %QWT6_EXTRAS_DIR%\qwtconfig.pri %SRC_ROOT%\qwtconfig.pri
)
qmake "QWT_INSTALL_PREFIX=%INSTALL_PREFIX%"
nmake

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Install
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
nmake install
:: Change of QWT_INSTALL_PREFIX still leaves files in the wrong place so move them manually
set QWT_INSTALL_PREFIX=C:\%SRC_PKG:~0,-4%
if not exist %INSTALL_PREFIX%\include\qwt mkdir %INSTALL_PREFIX%\include\qwt
xcopy %QWT_INSTALL_PREFIX%\include\*.h %INSTALL_PREFIX%\include\qwt /Y /I
xcopy %QWT_INSTALL_PREFIX%\lib\*.dll %INSTALL_PREFIX%\bin /Y /I
xcopy %QWT_INSTALL_PREFIX%\lib\*.pdb %INSTALL_PREFIX%\lib /Y /I
xcopy %QWT_INSTALL_PREFIX%\lib\*.lib %INSTALL_PREFIX%\lib /Y /I

rmdir /S /Q %QWT_INSTALL_PREFIX%

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Finalize
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call try-pause.cmd
goto:eof
