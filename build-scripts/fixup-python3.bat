@setlocal enableextensions
::
:: Assuming Python 3.8 has been installed into lib\python3.8
:: Patches are applied to fix several issues
::
@echo Setting up bundled Python distribution

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Setup environment. Important to ensure correct detection of environment
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call %~dp0cmds\common-setup.cmd
set PYTHON_EXTRAS_DIR=%~dp0\extras\python


if not exist %PYTHON_INSTALL_PREFIX% (
  @echo Cannot find Python installed in %PYTHON_INSTALL_PREFIX%
  exit /b 1
)

:: special wrappython.h header to avoid requireing a debug Python interpreter
copy /Y %PYTHON_EXTRAS_DIR%\wrappython.h %PYTHON_INSTALL_PREFIX%\Include
:: sitecustomize to set PATH to thridparty dependencies
copy /Y %PYTHON_EXTRAS_DIR%\sitecustomize.py %PYTHON_INSTALL_PREFIX%\Lib\site-packages

:: site-packages
@echo Installing site-packages
%PYTHON_EXE% -m pip install -r %~dp0\requirements.txt

:: replace the .exe launchers with relocatable files
set PYTHON_EXE=%PYTHON_INSTALL_PREFIX%\python.exe
set WRITE_LAUNCHER=%PYTHON_EXTRAS_DIR%\write-launcher-script.py
set PYTHON_SITE_PACKAGES=%PYTHON_INSTALL_PREFIX%\Lib\site-packages

@call:write-python-launcher Babel-2.7.0
@call:write-python-launcher chardet-3.0.4
@call:write-python-launcher flake8-3.7.9
@call:write-python-launcher ipython-7.10.2
@call:write-python-launcher numpy-1.17.4
@call:write-python-launcher Pygments-2.5.2
@call:write-python-launcher pip-19.2.3
@call:write-python-launcher pyflakes-2.1.1
@call:write-python-launcher setuptools-41.2.0
@call:write-python-launcher Sphinx-2.3.0

:: delete some exes that are not required as others exist that cover them
del /Q %PYTHON_INSTALL_PREFIX%\Scripts\pip3.8.exe
del /Q %PYTHON_INSTALL_PREFIX%\Scripts\easy_install-3.8.exe

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
:write-python-launcher
%PYTHON_EXE% %WRITE_LAUNCHER% --rm_exe %PYTHON_SITE_PACKAGES%\%1.dist-info\entry_points.txt

@goto:eof