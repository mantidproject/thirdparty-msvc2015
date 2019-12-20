@setlocal enableextensions
::
:: Build script PyQt4.
@echo Building PyQt4

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Setup environment. Important to ensure correct detection of environment
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call %~dp0cmds\common-setup.cmd
@set PYQT4_EXTRAS_DIR=%~dp0extras\pyqt4
@set INCLUDE=%INSTALL_PREFIX%\include;%INCLUDE%
@set LIB=%INSTALL_PREFIX%\lib;%LIB%
@set QT_ROOT=%INSTALL_PREFIX%\lib\qt4
@set PYTHONHOME=%INSTALL_PREFIX%\lib\python3.8
@set PATH_NO_QT=%INSTALL_PREFIX%\bin;%PYTHONHOME%;D:\Builds\jom;%PATH%
@set PATH=%QT_ROOT%\bin;%PATH_NO_QT%

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Clean any old build
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
if exist %PYTHONHOME%\Lib\site-packages\PyQt4 (
:: assume a build has been done with this script
  rmdir /S /Q %PYTHONHOME%\Lib\site-packages\PyQt4
  rmdir /S /Q %PYTHONHOME%\msvc-site-packages\debug\PyQt4
  del %PYTHONHOME%\pylupdate4.exe
  del %PYTHONHOME%\pyrcc4.exe
  del %PYTHONHOME%\pyuic4.exe
)

@set BUILD_DIR=%BUILD_ROOT%\pyqt4
@call try-mkdir %BUILD_DIR%
@cd %BUILD_DIR%

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Build private sip module
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call %~dp0build-sip PyQt4.sip %BUILD_DIR% libonly

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Use two build directories as the build is inplace
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@set QMAKESPEC=%QT_ROOT%\mkspecs\win32-msvc2015
@set SRC_PKG_URL="https://downloads.sourceforge.net/project/pyqt/PyQt4/PyQt-4.12.3/PyQt4_gpl_win-4.12.3.zip"
@set SRC_PKG=PyQt4_gpl_win-4.12.3.zip
@set EXTRACTED_SRC=PyQt4_gpl_win-4.12.3
call download-file.cmd %SRC_PKG% %SRC_PKG_URL%

:: debug build first so that release exes for pyrcc etc are installed over the debug ones
:: Copy private PyQt5.sip from release to debug as sip won't have done this
call try-mkdir.cmd %PYTHONHOME%\msvc-site-packages\debug\PyQt4
copy /Y %PYTHONHOME%\Lib\site-packages\PyQt4\sip.pyd  %PYTHONHOME%\msvc-site-packages\debug\PyQt4\sip.pyd
@set PYQT_ROOT_DEBUG=%BUILD_DIR%\debug
call try-mkdir.cmd %PYQT_ROOT_DEBUG%
cd /d %PYQT_ROOT_DEBUG%
call:do-build debug %BUILD_DIR%\%SRC_PKG% %EXTRACTED_SRC%

:: release build
@set PYQT_ROOT_RELEASE=%BUILD_DIR%\release
call try-mkdir.cmd %PYQT_ROOT_RELEASE%
cd /d %PYQT_ROOT_RELEASE%
if not exist %EXTRACTED_SRC% call:do-build release %BUILD_DIR%\%SRC_PKG% %EXTRACTED_SRC%

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Fix the pyqtconfig files
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@set PYQTCONFIG=%PYTHONHOME%\Lib\site-packages\PyQt4\pyqtconfig.py
move /Y %PYQTCONFIG% %PYQTCONFIG%.bak
call python %PYQT4_EXTRAS_DIR%\patch-pyqtconfig.py %PYQTCONFIG%.bak > %PYQTCONFIG%
del %PYQTCONFIG%.bak


::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Finalize
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call try-pause.cmd
goto:eof

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Functions
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: %1 type
:: %2 src_zip
:: %3 extracted source name
:do-build
@setlocal
@set _cwd_on_entry=%CD%
@set _buildtype=%1
@if not exist %3 call extract-zip-file.cmd %2 %CD%
:: patch source
cd %3
@echo Entered %CD%
@if not exist configure.py.orig (
  :: assume patches not applied
  call patch -p0 --input=%PYQT4_EXTRAS_DIR%\configure.py.patch --backup
  :: replace all Python.h instances with our wrap variant
  for /r %%f in (*.h) do (
    sed -i -e "s@<Python.h>@<wrappython.h>@" %%f
  )
  for /r %%f in (*.cpp*) do (
    sed -i -e "s@<Python.h>@<wrappython.h>@" %%f
  )
)

:: Generate qt.conf next to the qtdirs.exe so it knows where to find Qt
@if not exist %_buildtype% mkdir %_buildtype%
@set QT_CONF_FILE=%_buildtype%\qt.conf
@echo [Paths] > %QT_CONF_FILE%
@echo Prefix = %QT_ROOT:\=/% >> %QT_CONF_FILE%

@if "%_buildtype%" == "debug" ( set DEBUG_ARGS=-u --destdir=%PYTHONHOME%\msvc-site-packages\debug )

:: There is an issue compiling pylupdate. Moc hangs on translator.h in the makefile so we compile it first
pushd pylupdate
del moc_translator.cpp 2> nul
del moc_translator.obj 2> nul
@call moc.exe -o moc_translator.cpp translator.h
popd
@echo Running configure.py --confirm-license --no-qsci-api --no-designer-plugin %DEBUG_ARGS%
@call python configure.py --confirm-license --no-qsci-api --no-designer-plugin %DEBUG_ARGS%

@call nmake
@call nmake install

@cd %_cwd_on_entry%
goto:eof