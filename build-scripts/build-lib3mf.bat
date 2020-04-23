@setlocal enableextensions
::
@echo Building Lib3MF

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Setup environment. Important to ensure correct detection of environment
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call %~dp0cmds\common-setup.cmd
@set LIB3MF_EXTRAS_DIR=%~dp0extras\lib3mf

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Download and unpack source.
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@set SRC_PKG_URL="https://github.com/3MFConsortium/lib3mf/archive/v2.0.0.zip"
@set BUILD_DIR=%BUILD_ROOT%\lib3mf
@set SRC_PKG=2.0.0.zip
@set SRC_ROOT=%BUILD_DIR%\lib3mf-2.0.0
@if not exist %SRC_ROOT% call download-and-extract.cmd %BUILD_DIR%\%SRC_PKG% %SRC_PKG_URL%

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Patch
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Clean old install
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@if exist %INSTALL_ROOT%%\include\lib3mf (
  rmdir /S /Q %INSTALL_ROOT%%\include\lib3mf
)

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Build
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call cmake-build-and-install %SRC_ROOT%\ %LIB3MF_EXTRAS_DIR%\lib3mf.cmake %INSTALL_PREFIX% ALL_BUILD.vcxproj

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Finalize
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call try-pause.cmd
goto:eof