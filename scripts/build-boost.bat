@setlocal enableextensions
::
:: Build script for the Boost libraries for Mantid. The following libraries
:: are built in both release and debug mode:
::   * date_time
::   * regex
::
@echo Building boost

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Setup environment. Important to ensure correct detection of environment
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call %~dp0cmds\common-setup.cmd

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Download and unpack source
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@set SRC_PKG_URL="http://downloads.sourceforge.net/project/boost/boost/1.59.0/boost_1_59_0.zip?r=http%3A%2F%2Fwww.boost.org%2Fusers%2Fhistory%2Fversion_1_59_0.html&ts=1443101740&use_mirror=kent"
@set SRC_PKG=boost_1_59_0.zip
@set BUILD_DIR=%~dp0\builds\boost

@call try-mkdir.cmd %BUILD_DIR%
@cd %BUILD_DIR%
@call download-file.cmd %SRC_PKG% %SRC_PKG_URL%

set BOOST_ROOT=%BUILD_DIR%\boost_1_59_0
if not exist %BOOST_ROOT% @call extract-zip-file.cmd %SRC_PKG% %CD%

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Build
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@cd %BOOST_ROOT%
:: Bootstrap b2 executable
@call bootstrap.bat

:: Build libraries with no external dependencies
:: --layout=tagged ensures the the include directory is %prefix%/include/boost and not %prefix%/include/boost_X_XX_X/boost
set COMMON_BUILD_OPTS=link=shared threading=multi address-model=64 runtime-link=shared
@call b2.exe %COMMON_BUILD_OPTS% --with-date_time --with-regex variant=release variant=debug install --prefix=%INSTALL_ROOT% --layout=tagged

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Finalize
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@cd %~dp0

pause
