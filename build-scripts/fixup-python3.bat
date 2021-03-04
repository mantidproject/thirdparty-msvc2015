@setlocal enableextensions
::
:: Assuming Python 3.8 has been installed into lib\python3.8
:: Install requirements as specified by pip requirements file.
::
@echo Setting up bundled Python distribution

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Setup environment. Important to ensure correct detection of environment
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call %~dp0cmds\common-setup.cmd
set PYTHON_EXTRAS_DIR=%~dp0\extras\python
set PYTHON_EXE=%PYTHON_INSTALL_PREFIX%\python.exe
set WRITE_LAUNCHER=%PYTHON_EXTRAS_DIR%\write-launcher-script.py
set PYTHON_SITE_PACKAGES=%PYTHON_INSTALL_PREFIX%\Lib\site-packages

if not exist %PYTHON_INSTALL_PREFIX% (
  @echo Cannot find Python installed in %PYTHON_INSTALL_PREFIX%
  exit /b 1
)

:: special wrappython.h header to avoid requireing a debug Python interpreter
if not exist %PYTHON_INSTALL_PREFIX%\Include\wrappython.h (
  copy /Y %PYTHON_EXTRAS_DIR%\wrappython.h %PYTHON_INSTALL_PREFIX%\Include
)
if not exist %PYTHON_INSTALL_PREFIX%\Lib\site-packages\sitecustomize.py (
  :: sitecustomize to set PATH to thirdparty dependencies
  copy /Y %PYTHON_EXTRAS_DIR%\sitecustomize.py %PYTHON_INSTALL_PREFIX%\Lib\site-packages\sitecustomize.py
)

:: site-packages
@echo Installing site-packages
%PYTHON_EXE% -m pip install -r %~dp0\python-pip-requirements.txt
IF %ERRORLEVEL% NEQ 0 (
   @echo Error installing pip packages
   exit /b %ERRORLEVEL%
) 

:: replace the .exe launchers with relocatable files
@call:write-python-launcher Babel-2.7.0
@call:write-python-launcher chardet-3.0.4
@call:write-python-launcher flake8-3.7.9
@call:write-python-launcher ipython-7.10.2
@call:write-python-launcher jsonschema-3.2.0
@call:write-python-launcher jupyter_client-5.3.4
@call:write-python-launcher jupyter_core-4.6.1
@call:write-python-launcher nbformat-5.0.3
@call:write-python-launcher nbconvert-5.6.1
@call:write-python-launcher notebook-6.0.2
@call:write-python-launcher numpy-1.17.4
@call:write-python-launcher Pygments-2.5.2
@call:write-python-launcher pip-19.2.3
@call:write-python-launcher pyflakes-2.1.1
@call:write-python-launcher qtconsole-4.6.0
@call:write-python-launcher setuptools-41.2.0
@call:write-python-launcher Sphinx-2.3.0
@call:write-python-launcher identify-2.1.0
@call:write-python-launcher pre_commit-2.10.1
@call:write-python-launcher virtualenv-20.4.2
@call:write-python-launcher nodeenv-1.5.0

:: delete some exes that are not required as others exist that cover them
del /Q %PYTHON_INSTALL_PREFIX%\Scripts\pip3.8.exe
del /Q %PYTHON_INSTALL_PREFIX%\Scripts\easy_install-3.8.exe

:: apply patches
if not exist %PYTHON_INSTALL_PREFIX%\Lib\site-packages\tornado\platform\asyncio.py.orig (
    call patch -p0 --input=%PYTHON_EXTRAS_DIR%\win32-asyncio-selector.patch
)

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Finalize
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call try-pause.cmd
goto:eof

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Functions
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:: Write a launcher script for a Python script. By default setuptools writes
:: a .exe file that is hardwired for the path on the machine it was installed
:: on so is not relocatable
:write-python-launcher
%PYTHON_EXE% %WRITE_LAUNCHER% --rm_exe %PYTHON_SITE_PACKAGES%\%1.dist-info\entry_points.txt

@goto:eof