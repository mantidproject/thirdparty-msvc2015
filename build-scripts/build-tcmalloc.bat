@setlocal enableextensions
::
:: Build script for tcmalloc
@echo Building tcmalloc

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Setup environment. Important to ensure correct detection of environment
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call %~dp0cmds\common-setup.cmd
@set TCM_EXTRAS_DIR=%~dp0extras\gperftools

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Clone our fork that adds 64-bit support to the tcmalloc project file
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@set REMOTE_URL="https://github.com/martyngigg/gperftools.git"
@set SHA1=1ae022ade2c1c591ac5b1edef19dc2ff65f821a4
@set BUILD_DIR=%BUILD_ROOT%\gperftools
@set SRC_ROOT=%BUILD_DIR%\gperftools
if not exist %SRC_ROOT% (
  @call git clone %REMOTE_URL% %SRC_ROOT%
  cd %SRC_ROOT%
) else (
  cd %SRC_ROOT%
  @call git pull --rebase
)
@call git checkout %SHA1%

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Build
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
set TCMALLOC_MINIMAL_DIR=vsprojects\libtcmalloc_minimal
@call build-release-and-debug.cmd %TCMALLOC_MINIMAL_DIR%\libtcmalloc_minimal.vcxproj

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Install
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: These are runtime only libraries so only install dlls
copy /Y %SRC_ROOT%\%TCMALLOC_MINIMAL_DIR%\x64\Release\libtcmalloc_minimal.dll %INSTALL_ROOT%\bin
copy /Y %SRC_ROOT%\%TCMALLOC_MINIMAL_DIR%\x64\Debug\libtcmalloc_minimal-debug.dll %INSTALL_ROOT%\bin

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Finalize
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call try-pause.cmd
goto:eof
