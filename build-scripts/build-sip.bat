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
@set SRC_PKG_URL="https://sourceforge.net/projects/pyqt/files/sip/sip-4.19.12/sip-4.19.12.zip"
@set SRC_PKG=sip-4.19.12.zip
call download-file.cmd %SRC_PKG% %SRC_PKG_URL%
@set SIP_ROOT=%BUILD_DIR%\sip-4.19.12
if not exist %SIP_ROOT% call extract-zip-file.cmd %SRC_PKG% %CD%
cd /d %SIP_ROOT%
:: Patch
if not exist siplib\apiversions.c.orig call patch -p0 --input=%SIP_EXTRAS_DIR%\apiversions.c.patch --backup
if not exist siplib\array.c.orig call patch -p0 --input=%SIP_EXTRAS_DIR%\array.c.patch --backup
if not exist siplib\array.h.orig call patch -p0 --input=%SIP_EXTRAS_DIR%\array.h.patch --backup
if not exist siplib\descriptors.c.orig call patch -p0 --input=%SIP_EXTRAS_DIR%\descriptors.c.patch --backup
if not exist siplib\int_convertors.c.orig call patch -p0 --input=%SIP_EXTRAS_DIR%\int_convertors.c.patch --backup
if not exist siplib\qtlib.c.orig call patch -p0 --input=%SIP_EXTRAS_DIR%\qtlib.c.patch --backup
if not exist siplib\sipint.h.orig call patch -p0 --input=%SIP_EXTRAS_DIR%\sipint.h.patch --backup
if not exist siplib\siplib.c.orig call patch -p0 --input=%SIP_EXTRAS_DIR%\siplib.c.patch --backup
if not exist siplib\sip.h.orig call patch -p0 --input=%SIP_EXTRAS_DIR%\sip.h.patch --backup
if not exist siplib\voidptr.c.orig call patch -p0 --input=%SIP_EXTRAS_DIR%\voidptr.c.patch --backup
if not exist sipgen\gencode.c.orig call patch -p0 --input=%SIP_EXTRAS_DIR%\gencode.c.patch --backup
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
