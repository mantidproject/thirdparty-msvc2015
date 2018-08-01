@setlocal enableextensions
::
@echo Building Eigen3

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Setup environment. Important to ensure correct detection of environment
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call %~dp0cmds\common-setup.cmd
@set EIGEN_EXTRAS_DIR=%~dp0extras\eigen3

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Download and unpack source.
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@set SRC_PKG_URL="https://bitbucket.org/eigen/eigen/get/3.3.4.zip"
@set BUILD_DIR=%BUILD_ROOT%\eigen3
@set SRC_PKG=3.3.4.zip
@set SRC_ROOT=%BUILD_DIR%\eigen-eigen-5a0156e40feb
@if not exist %SRC_ROOT% call download-and-extract.cmd %BUILD_DIR%\%SRC_PKG% %SRC_PKG_URL%

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Patch
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Clean old install
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@if exist %INSTALL_ROOT%%\include\eigen3 (
  rmdir /S /Q %INSTALL_ROOT%%\include\eigen3
)

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Build
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call cmake-build-and-install %SRC_ROOT%\ %EIGEN_EXTRAS_DIR%\eigen3.cmake %INSTALL_PREFIX% ALL_BUILD.vcxproj

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Finalize
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call try-pause.cmd
goto:eof
