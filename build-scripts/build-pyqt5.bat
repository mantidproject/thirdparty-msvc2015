@setlocal enableextensions
::
:: Build script PyQt5.
@echo Building PyQt5

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Setup environment. Important to ensure correct detection of environment
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call %~dp0cmds\common-setup.cmd
@set PYQT5_EXTRAS_DIR=%~dp0extras\pyqt5
@set INCLUDE=%INSTALL_PREFIX%\include;%INCLUDE%
@set RCPATH="C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\bin\x86_amd64"
@set LIB=%INSTALL_PREFIX%\lib;%LIB%
@set QT_ROOT=%INSTALL_PREFIX%\lib\qt5
@set PYTHONHOME=%INSTALL_PREFIX%\lib\python3.8
@set PATH_NO_QT=%INSTALL_PREFIX%\bin;%PYTHONHOME%;C:\Builds\jom;%PATH%
@set PATH=%QT_ROOT%\bin;%PATH_NO_QT%;%RCPATH%

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Clean any old build
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
if exist %PYTHONHOME%\Lib\site-packages\PyQt5 (
  :: assume a build has been done with this script
  rmdir /S /Q %PYTHONHOME%\Lib\site-packages\PyQt5
  rmdir /S /Q %PYTHONHOME%\msvc-site-packages\debug\PyQt5
  del %PYTHONHOME%\pylupdate5.bat
  del %PYTHONHOME%\pyrcc5.bat
  del %PYTHONHOME%\pyuic5.bat
)

@set BUILD_DIR=%BUILD_ROOT%\pyqt5
@call try-mkdir %BUILD_DIR%
@cd %BUILD_DIR%

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Build private sip module
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call %~dp0build-sip PyQt5.sip %BUILD_DIR%

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Use two build directories as the build is inplace
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@set QMAKESPEC=%QT_ROOT%\mkspecs\win32-msvc
@set SRC_PKG_URL="https://sourceforge.net/projects/pyqt/files/PyQt5/PyQt-5.11.3/PyQt5_gpl-5.11.3.zip"
@set SRC_PKG=PyQt5_gpl-5.11.3.zip
@set EXTRACTED_SRC=PyQt5_gpl-5.11.3
call download-file.cmd %SRC_PKG% %SRC_PKG_URL%

:: debug build first so that release exes for pyrcc etc are installed over the debug ones
:: Copy private PyQt5.sip from release to debug as sip won't have done this
copy /Y %PYTHONHOME%\Lib\site-packages\PyQt5\sip.pyd  %PYTHONHOME%\msvc-site-packages\debug\PyQt5
copy /Y %PYTHONHOME%\Lib\site-packages\PyQt5\sip.pyi  %PYTHONHOME%\msvc-site-packages\debug\PyQt5
@set PYQT_ROOT_DEBUG=%BUILD_DIR%\debug
call try-mkdir.cmd %PYQT_ROOT_DEBUG%
cd /d %PYQT_ROOT_DEBUG%
call:do-build debug %BUILD_DIR%\%SRC_PKG% %EXTRACTED_SRC%

:: release build
@set PYQT_ROOT_RELEASE=%BUILD_DIR%\release
call try-mkdir.cmd %PYQT_ROOT_RELEASE%
cd /d %PYQT_ROOT_RELEASE%
call:do-build release %BUILD_DIR%\%SRC_PKG% %EXTRACTED_SRC%

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
  call patch -p0 --input=%PYQT5_EXTRAS_DIR%\configure.py.patch --backup
  call patch -p0 --input=%PYQT5_EXTRAS_DIR%\findqtdll.patch --backup
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

set BUILD_ARGS=--verbose --confirm-license --link-full-dll --no-qsci-api --no-designer-plugin --disable=QtNfc --disable=QtQuick --disable=QtQml --disable=QtQuickWidgets
@if "%_buildtype%" == "debug" ( set DEBUG_ARGS=-u --destdir=%PYTHONHOME%\msvc-site-packages\debug )
@echo Running configure.py %BUILD_ARGS% %DEBUG_ARGS%
@echo %QT_ROOT%
@call python configure.py %BUILD_ARGS% %DEBUG_ARGS%

REM :: jom seems to have an issue with parallel builds
if exist C:\Builds\jom\jom.exe (
  @call jom /J 24
) else (
  @call nmake
)
@call nmake install

@cd %_cwd_on_entry%
goto:eof

