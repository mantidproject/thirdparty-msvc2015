@setlocal enableextensions
::
:: Download Python and set up the bundle.
:: Patches are applied to fix several issues
::
@echo Setting up bundled Python distribution

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Setup environment. Important to ensure correct detection of environment
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call %~dp0cmds\common-setup.cmd

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Download msi and unpack
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@set SRC_PKG=python-2.7.10.amd64.msi
@set SRC_PKG_URL=https://www.python.org/ftp/python/2.7.10/%SRC_PKG%
@set BUILD_DIR=%BUILD_ROOT%\python

@call try-mkdir.cmd %BUILD_DIR%
@cd %BUILD_DIR%
call download-file.cmd %BUILD_DIR%\%SRC_PKG% %SRC_PKG_URL%

set PYTHON_INSTALL_ROOT=%INSTALL_ROOT%\lib\python2.7
if not exist %PYTHON_INSTALL_ROOT% (
  @echo Extracting Python bundle to %PYTHON_INSTALL_ROOT%
  msiexec /a %BUILD_DIR%\%SRC_PKG% /q TARGETDIR=%PYTHON_INSTALL_ROOT%
  :: delete the msi that is also extracted
  del /Q %PYTHON_INSTALL_ROOT%\%SRC_PKG%
)

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Patches
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
set EXTRAS_DIR=%~dp0\extras\python
@echo Patching uuid.py
@call:try-patch %PYTHON_INSTALL_ROOT%\Lib %PYTHON_INSTALL_ROOT%\Lib\uuid.py %EXTRAS_DIR%\uuid-nt.patch

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: setuptools + site packages
:: Force use of "natural" installers rather than executables as the executables
:: are not relocatable
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
set SETUPTOOLS_LAUNCHER=natural
set PYTHON_SCRIPTS_DIR=%PYTHON_INSTALL_ROOT%\Scripts
@echo Installing pip
if not exist %PYTHON_INSTALL_ROOT%\Lib\site-packages\pip (
@ call download-file.cmd %BUILD_DIR%\get-pip.py https://bootstrap.pypa.io/get-pip.py
  %PYTHON_INSTALL_ROOT%\python.exe %BUILD_DIR%\get-pip.py
  rem remove all Scripts\*.exe files as they will only work on the machine they
  rem were built on
  del /Q %PYTHON_SCRIPTS_DIR%\*.exe
  rem install our hand-written launcher python scripts and create .cmd files to start them
  for %%f in (%EXTRAS_DIR%\*.pya) do (
    copy %%f %PYTHON_SCRIPTS_DIR%
    rem create command
    call:write-python-launcher %PYTHON_SCRIPTS_DIR%\%%~nxf %PYTHON_SCRIPTS_DIR%\%%~nf.cmd
  )
)

:: packages
:: numpy
@call download-file.cmd "numpy-1.9.3+mkl-cp27-none-win_amd64.whl" "http://www.lfd.uci.edu/~gohlke/pythonlibs/xmshzit7/numpy-1.9.3+mkl-cp27-none-win_amd64.whl"
@call %PYTHON_INSTALL_ROOT%\Scripts\pip.cmd install -U "numpy-1.9.3+mkl-cp27-none-win_amd64.whl"

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Finalize
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call try-pause.cmd
goto:eof

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Functions
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Patch a file if it has not been patched already
:: %1 Directory of file to patch
:: %2 File to be patched
:: %3 Patch file
:try-patch
if not exist %2.orig (
  patch -b --directory=%1  -i %3
)
goto:eof

:: Write a launcher script for a Python script. By default setuptools writes
:: a .exe file that is hardwired for the path on the machine it was installed
:: on so is not relocatable
:: %1 Path to the py(a) file that needs to be launched
:: %2 Path to write the launcher file
:write-python-launcher
@setlocal
@set _pya_file=%~nx1
@set _exec_file=%2
@echo @echo off> %_exec_file%
@echo setlocal enableextensions>> %_exec_file%
@echo :: easy_install launcher script. Uses a relative path to the Python>> %_exec_file%
@echo :: executable to ensure it is relocatable>> %_exec_file%
@echo set _scripts_dir=%%~dp0>> %_exec_file%
@echo %%_scripts_dir%%\..\python.exe %%_scripts_dir%%%_pya_file% %%*>> %_exec_file%
@endlocal
@goto:eof