@setlocal enableextensions
::
:: Build script Sip
:: Expected to be called from the PyQt build script with the first argument as the name of the
:: sip module

if "%2"=="" (
  @echo "Usage build-sip name-of-module build-root"
  exit /b 1
)
set SIP_MODULE=%1
@echo Building Python Sip as %1

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Setup environment. Important to ensure correct detection of environment
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call %~dp0cmds\common-setup.cmd
@set SIP_EXTRAS_DIR=%~dp0extras\sip
@set INCLUDE=%INSTALL_PREFIX%\include;%INCLUDE%
@set LIB=%INSTALL_PREFIX%\lib;%LIB%
@set PYTHONHOME=%INSTALL_PREFIX%\lib\python3.8
@set PATH=%INSTALL_PREFIX%\bin;%PYTHONHOME%;%PATH%

:: Clean
if exist %PYTHONHOME% (
  del %PYTHONHOME%\Lib\site-packages\sipconfig.*
  del %PYTHONHOME%\Lib\site-packages\sip*
)

@set BUILD_DIR=%2\sip
@call try-mkdir %BUILD_DIR%
@cd %BUILD_DIR%

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: SIP
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@set SRC_PKG_URL="https://sourceforge.net/projects/pyqt/files/sip/sip-4.19.13/sip-4.19.13.zip"
@set SRC_PKG=sip-4.19.13.zip
call download-file.cmd %SRC_PKG% %SRC_PKG_URL%
@set SIP_ROOT=%BUILD_DIR%\sip-4.19.13
if not exist %SIP_ROOT% call extract-zip-file.cmd %SRC_PKG% %CD%
cd /d %SIP_ROOT%
:: replace all Python.h instances with our wrap variant
for /r %%f in (*.h) do (
sed -i -e "s@<Python.h>@<wrappython.h>@" %%f
)
for /r %%f in (*.c*) do (
sed -i -e "s@<Python.h>@<wrappython.h>@" %%f
)

call python configure.py --platform=%QMAKESPEC% --sip-module "%SIP_MODULE%"
call nmake
call nmake install

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Fix the sipconfig file so that it is relocatable
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@set SIPCONFIG=%PYTHON_INSTALL_PREFIX%\Lib\site-packages\sipconfig.py
move /Y %SIPCONFIG% %SIPCONFIG%.bak
call python %SIP_EXTRAS_DIR%\patch-sipconfig.py %SIPCONFIG%.bak > %SIPCONFIG%
del %SIPCONFIG%.bak
