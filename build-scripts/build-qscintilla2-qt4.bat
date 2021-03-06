@setlocal enableextensions
::
:: Build script for QScintilla2
@echo Building QScintilla2

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Setup environment. Important to ensure correct detection of environment
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call %~dp0cmds\common-setup.cmd
@set QSCI2_EXTRAS_DIR=%~dp0extras\qscintilla2
@set INCLUDE=%INSTALL_PREFIX%\include;%INCLUDE%
@echo %INLCUDE%
@set LIB=%INSTALL_PREFIX%\lib;%LIB%
@set PATH=%INSTALL_PREFIX%\bin;%INSTALL_PREFIX%\lib\qt4\bin;%BUILD_ROOT%\jom;%PATH%
@set NJOBS=8

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Download and unpack source.
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@set SRC_PKG_URL="https://downloads.sf.net/project/pyqt/QScintilla2/QScintilla-2.8.4/QScintilla-gpl-2.8.4.zip"
@set BUILD_DIR=%BUILD_ROOT%\qscintilla2
@set SRC_PKG=QScintilla-gpl-2.8.4.zip
@set SRC_ROOT=%BUILD_DIR%\QScintilla-gpl-2.8.4
if not exist %SRC_ROOT% call download-and-extract.cmd %BUILD_DIR%\%SRC_PKG% %SRC_PKG_URL%

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Patch
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
cd %SRC_ROOT%
if not exist Qt4Qt5\qscintilla.pro.orig call patch -p0 --input=%QSCI2_EXTRAS_DIR%\qt4\qscintilla.pro.patch --backup
if not exist Qt4Qt5\InputEditor.cpp.orig call patch -p0 --input=%QSCI2_EXTRAS_DIR%\qt4\InputEditor.cpp.patch --backup

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Build
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
cd %SRC_ROOT%\Qt4Qt5
qmake
jom -j%NJOBS%

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Install
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: qmake uses INSTALL_PREFIX in the generated make file and having it set here
:: confuses things
@set INSTALL_PREFIX=%INSTALL_PREFIX%
@set INSTALL_PREFIX=
nmake install

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Finalize
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call try-pause.cmd
goto:eof
