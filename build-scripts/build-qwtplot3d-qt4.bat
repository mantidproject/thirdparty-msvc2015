@setlocal enableextensions
::
:: Build script for QwtPlot3D with Qt4
@echo Building QwtPlot3D

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Setup environment. Important to ensure correct detection of environment
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call %~dp0cmds\common-setup.cmd
@set QWTPLOT3D_EXTRAS_DIR=%~dp0extras\qwtplot3d
@set INCLUDE=%INSTALL_ROOT%\include;%INCLUDE%
@echo %INLCUDE%
@set LIB=%INSTALL_ROOT%\lib;%LIB%
@set PATH=%INSTALL_ROOT%\bin;%INSTALL_ROOT%\lib\qt4\bin;%BUILD_ROOT%\jom;%PATH%
@set NJOBS=8

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Download and unpack source.
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@set SRC_PKG_URL="http://downloads.sourceforge.net/project/qwtplot3d/qwtplot3d/0.2.7/qwtplot3d-0.2.7.zip"
@set BUILD_DIR=%BUILD_ROOT%\qwtplot3d
@set SRC_PKG=qwtplot3d-0.2.7.zip
@set SRC_ROOT=%BUILD_DIR%\qwtplot3d
if not exist %SRC_ROOT% call download-and-extract.cmd %BUILD_DIR%\%SRC_PKG% %SRC_PKG_URL%

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Patch
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
cd %SRC_ROOT%
if not exist %SRC_ROOT%\include\qwt3d_openglhelper.h.orig call patch -p0 --input=%QWTPLOT3D_EXTRAS_DIR%\qwt3d_openglhelper.h.patch --backup
if not exist %SRC_ROOT%\qwtplot3d.pro.orig call patch -p0 --input=%QWTPLOT3D_EXTRAS_DIR%\qwtplot3d.pro.patch --backup

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Build
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
qmake
nmake

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Install
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: No install rule generated so do it by hand
if not exist %INSTALL_ROOT%\include\qwt-qt4 mkdir %INSTALL_ROOT%\include\qwtplot3d-qt4
xcopy %SRC_ROOT%\include\*.h %INSTALL_ROOT%\include\qwtplot3d-qt4 /Y /I
xcopy %SRC_ROOT%\lib\*.dll %INSTALL_ROOT%\bin /Y /I
xcopy %SRC_ROOT%\lib\*.pdb %INSTALL_ROOT%\lib /Y /I
xcopy %SRC_ROOT%\lib\*.lib %INSTALL_ROOT%\lib /Y /I

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Finalize
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call try-pause.cmd
goto:eof
