@setlocal enableextensions
::
:: Build script for the Boost libraries for Mantid. The following libraries
:: are built in both release and debug mode:
::   * date_time
::   * regex
::   * python
@echo Building boost

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Setup environment. Important to ensure correct detection of environment
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call %~dp0cmds\common-setup.cmd
@set BOOST_EXTRAS_DIR=%~dp0extras\boost
:: Boost needs to find Python
@set PATH=%PYTHON_INSTALL_ROOT%;%PATH%

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Download and unpack source
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@set SRC_PKG_URL="http://downloads.sourceforge.net/project/boost/boost/1.59.0/boost_1_59_0.zip?r=http%3A%2F%2Fwww.boost.org%2Fusers%2Fhistory%2Fversion_1_59_0.html&ts=1443101740&use_mirror=kent"
@set SRC_PKG=boost_1_59_0.zip
@set BUILD_DIR=%BUILD_ROOT%\boost

@call try-mkdir.cmd %BUILD_DIR%
@cd %BUILD_DIR%
@call download-file.cmd %SRC_PKG% %SRC_PKG_URL%

set BOOST_ROOT=%BUILD_DIR%\boost_1_59_0
@call extract-zip-file.cmd %SRC_PKG% %CD%

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Patch
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
cd %BOOST_ROOT%
if not exist include\boost\type_traits\intrinsics.hpp.orig call patch -p0 --input=%BOOST_EXTRAS_DIR%\type-traits-160.patch --backup

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Build & Install
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@cd %BOOST_ROOT%
:: Bootstrap b2 executable
if not exist b2.exe @call bootstrap.bat

:: Remove old includes, dlls & libs in INSTALL_ROOT as `install` command only copies what is not currently there
if exist "%INSTALL_ROOT%\include\boost" (
  rmdir /S /Q "%INSTALL_ROOT%\include\boost"
  del "%INSTALL_ROOT%\lib\boost*.lib"
  del "%INSTALL_ROOT%\lib\boost*.dll"
)

:: Build libraries with no external dependencies
:: --layout=tagged ensures the the include directory is %prefix%/include/boost and not %prefix%/include/boost_X_XX_X/boost
set COMMON_BUILD_OPTS=link=shared threading=multi address-model=64 runtime-link=shared
@call b2.exe %COMMON_BUILD_OPTS% --with-date_time --with-regex --with-python variant=release variant=debug install --prefix=%INSTALL_ROOT% --layout=tagged

:: We want the dlls in bin but b2 won't allow that
echo Moving dlls to %INSTALL_ROOT%\bin
@move /Y %INSTALL_ROOT%\lib\boost*.dll %INSTALL_ROOT%\bin

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Finalize
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call try-pause.cmd
