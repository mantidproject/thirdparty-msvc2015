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
@set PATH=%PYTHON_INSTALL_PREFIX%;%PATH%

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Download and unpack source
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::Fetch Boost 1.66.0
@set SRC_PKG_URL="https://sourceforge.net/projects/boost/files/boost/1.66.0/boost_1_66_0.zip"
@set SRC_PKG=boost_1_66_0.zip
@set BUILD_DIR=%BUILD_ROOT%\boost

@call try-mkdir.cmd %BUILD_DIR%
@cd %BUILD_DIR%
@call download-file.cmd %SRC_PKG% %SRC_PKG_URL%
set BOOST_ROOT=%BUILD_DIR%\boost_1_66_0
@call extract-zip-file.cmd %SRC_PKG% %CD%

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Patch
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
cd %BOOST_ROOT%

:: use custom project configuration which includes mpi build
xcopy %INSTALL_ROOT%\build-scripts\extras\boost\project-config.jam %BOOST_ROOT% /Y /I

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Build & Install
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Remove old includes, dlls & libs in INSTALL_PREFIX as `install` command only copies what is not currently there
if exist "%INSTALL_PREFIX%\include\boost" (
  rmdir /S /Q "%INSTALL_PREFIX%\include\boost"
  del "%INSTALL_PREFIX%\lib\boost*.lib"
  del "%INSTALL_PREFIX%\lib\boost*.dll"
)

@cd %BOOST_ROOT%
:: Bootstrap b2 executable
if not exist b2.exe @call bootstrap.bat

:: Build libraries with no external dependencies
:: --layout=tagged ensures the the include directory is %prefix%/include/boost and not %prefix%/include/boost_X_XX_X/boost
set COMMON_BUILD_OPTS=toolset=msvc-14.0 link=shared threading=multi address-model=64 runtime-link=shared
set WITH_LIBS=--with-date_time --with-regex --with-python --with-serialization --with-filesystem
@call b2.exe %COMMON_BUILD_OPTS% %WITH_LIBS% variant=release variant=debug install --prefix=%INSTALL_PREFIX% --layout=tagged

:: We want the dlls in bin but b2 won't allow that
echo Moving dlls to %INSTALL_PREFIX%\bin
@move /Y %INSTALL_PREFIX%\lib\boost*.dll %INSTALL_PREFIX%\bin

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Finalize
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call try-pause.cmd