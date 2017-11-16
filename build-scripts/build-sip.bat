@setlocal enableextensions
::
:: Build script Sip
@echo Building Python Sip

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Setup environment. Important to ensure correct detection of environment
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call %~dp0cmds\common-setup.cmd
@set SIP_EXTRAS_DIR=%~dp0extras\sip
@set INCLUDE=%INSTALL_PREFIX%\include;%INCLUDE%
@set LIB=%INSTALL_PREFIX%\lib;%LIB%
@set PYTHONHOME=%INSTALL_PREFIX%\lib\python2.7
@set PATH=%INSTALL_PREFIX%\bin;%PYTHONHOME%;%PATH%

:: Clean
if exist %PYTHONHOME% (
  del %PYTHONHOME%\Lib\site-packages\sipconfig.*
  del %PYTHONHOME%\Lib\site-packages\sip*
)

@set BUILD_DIR=%BUILD_ROOT%\sip
@call try-mkdir %BUILD_DIR%
@cd %BUILD_DIR%

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: SIP
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@set SRC_PKG_URL="https://downloads.sourceforge.net/project/pyqt/sip/sip-4.19.3/sip-4.19.3.zip"
@set SRC_PKG=sip-4.19.3.zip
call download-file.cmd %SRC_PKG% %SRC_PKG_URL%
@set SIP_ROOT=%BUILD_DIR%\sip-4.19.3
if not exist %SIP_ROOT% call extract-zip-file.cmd %SRC_PKG% %CD%
cd /d %SIP_ROOT%
:: Patch
if not exist siplib\sip.h.in.orig call patch -p0 --input=%SIP_EXTRAS_DIR%\sip-wrapython.patch --backup
if not exist siputils.py.orig call patch -p0 --input=%SIP_EXTRAS_DIR%\siputils-no-debug.patch --backup
call python configure.py --platform=%QMAKESPEC%
call nmake
call nmake install

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Fix the sipconfig file so that it is relocatable
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@set SIPCONFIG=%PYTHON_INSTALL_PREFIX%\Lib\site-packages\sipconfig.py
move /Y %SIPCONFIG% %SIPCONFIG%.bak
call python %SIP_EXTRAS_DIR%\patch-sipconfig.py %SIPCONFIG%.bak > %SIPCONFIG%
del %SIPCONFIG%.bak

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Finalize
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call try-pause.cmd
goto:eof
