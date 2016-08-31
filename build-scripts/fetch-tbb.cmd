@setlocal enableextensions
::
:: Fetch tbb libraries and include the relevant libraries
::
@echo Setting up Intel tbb libraries

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Setup environment. Important to ensure correct detection of environment
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call %~dp0cmds\common-setup.cmd

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Download
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@set SRC_PKG_URL="https://www.threadingbuildingblocks.org/sites/default/files/software_releases/windows/tbb44_20160526oss_win_0.zip"
@set SRC_PKG=tbb44_20160526oss_win_0.zip
@set BUILD_DIR=%BUILD_ROOT%\tbb
@call try-mkdir.cmd %BUILD_DIR%
@cd %BUILD_DIR%
@call download-file.cmd %SRC_PKG% %SRC_PKG_URL%

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Extract manually and copy relevant parts
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@if not exist %SRC_ROOT% call 7z x %SRC_PKG% -o%BUILD_DIR% -y

:: chop off the _win_0.zip
@set SRC_ROOT=%BUILD_DIR%\%SRC_PKG:~0,-10%
@cd %SRC_ROOT%

:: Copy required files

:: Includes under the SRC_ROOT\include directory
@set INCLUDE_DIRS=serial tbb
for %%D in (%INCLUDE_DIRS%) do (
  xcopy include\%%D %INSTALL_ROOT%\include\%%D /Y /I /E
)

:: Library export files
:: xcopy cmd by default copies all files from the given directory to the destination and does not include the directory itself
@set VC_DIR=intel64\vc14
xcopy lib\%VC_DIR% %INSTALL_ROOT%\lib /Y /I

:: Runtime DLLs
xcopy bin\%VC_DIR% %INSTALL_ROOT%\bin /Y /I

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Post-process
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Finalize
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call try-pause.cmd
goto:eof