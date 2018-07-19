@setlocal enableextensions
::
:: Build script for QScintilla2
@echo Building QScintilla2 for Qt5

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Setup environment. Important to ensure correct detection of environment
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call %~dp0cmds\common-setup.cmd
@set QSCI2_EXTRAS_DIR=%~dp0extras\qscintilla2
@set INCLUDE=%INSTALL_PREFIX%\include;%INCLUDE%
@echo %INLCUDE%
@set LIB=%INSTALL_PREFIX%\lib;%LIB%
@set PATH=%INSTALL_PREFIX%\bin;%INSTALL_PREFIX%\lib\qt5\bin;%PATH%
@set NJOBS=8

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Download and unpack source.
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@set SRC_PKG_URL="https://downloads.sf.net/project/pyqt/QScintilla2/QScintilla-2.10.1/QScintilla_gpl-2.10.1.zip"
@set BUILD_DIR=%BUILD_ROOT%\qscintilla2
@set SRC_PKG=QScintilla_gpl-2.10.1.zip
@set SRC_ROOT=%BUILD_DIR%\QScintilla_gpl-2.10.1
if not exist %SRC_ROOT% call download-and-extract.cmd %BUILD_DIR%\%SRC_PKG% %SRC_PKG_URL%

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Patch
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
cd %SRC_ROOT%

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Build
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
cd %SRC_ROOT%\Qt4Qt5
qmake -spec win32-msvc qscintilla.pro
nmake debug
nmake release

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Install
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: qmake uses INSTALL_PREFIX in the generated make file and having it set here
:: confuses things
@set INSTALL_PREFIX=%INSTALL_PREFIX%
@set INSTALL_PREFIX=
nmake debug-install
nmake release-install

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Finalize
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call try-pause.cmd
goto:eof
