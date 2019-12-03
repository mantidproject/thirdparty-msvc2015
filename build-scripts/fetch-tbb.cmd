@setlocal enableextensions
::
:: Fetch tbb libraries and include the relevant libraries
::
@echo Setting up Intel tbb libraries

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Setup environment. Important to ensure correct detection of environment
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call %~dp0cmds\common-setup.cmd
@set TBB_EXTRAS_DIR=%dp0extras\tbb

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Download
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@set SRC_PKG_URL="https://github.com/intel/tbb/releases/download/2019_U9/tbb2019_20191006oss_win.zip"
@set SRC_PKG=tbb2019_20191006oss_win.zip
@set BUILD_DIR=%BUILD_ROOT%\tbb
@call try-mkdir.cmd %BUILD_DIR%
@cd %BUILD_DIR%
@call download-file.cmd %SRC_PKG% %SRC_PKG_URL%

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Extract manually and copy relevant parts
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@if not exist %SRC_ROOT% call 7z x %SRC_PKG% -o%BUILD_DIR% -y

:: chop off the _win.zip
@set SRC_ROOT=%BUILD_DIR%\%SRC_PKG:~0,-8%
@cd %SRC_ROOT%

:: Copy required files

:: Includes under the SRC_ROOT\include directory
@set INCLUDE_DIRS=serial tbb
for %%D in (%INCLUDE_DIRS%) do (
  rmdir /S /Q %INSTALL_PREFIX%\include\%%D
  xcopy include\%%D %INSTALL_PREFIX%\include\%%D /Y /I /E
)

:: Library export files
:: xcopy cmd by default copies all files from the given directory to the destination and does not include the directory itself
@set VC_DIR=intel64\vc14
del /Q %INSTALL_PREFIX%\lib\tbb*
xcopy lib\%VC_DIR% %INSTALL_PREFIX%\lib /Y /I

:: Runtime DLLs
del /Q %INSTALL_PREFIX%\bin\tbb*
xcopy bin\%VC_DIR% %INSTALL_PREFIX%\bin /Y /I

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Patch
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Post-process
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Finalize
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call try-pause.cmd
goto:eof