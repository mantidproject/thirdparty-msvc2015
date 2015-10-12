@setlocal enableextensions
::
:: Build script for ZLib
@echo Building zlib

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Setup environment. Important to ensure correct detection of environment
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call %~dp0cmds\common-setup.cmd
@set ZLIB_EXTRAS_DIR=%~dp0extras\zlib

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Download and unpack source. We use the HDF5 patched source that has been
:: patched to build with CMake
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@set SRC_PKG_URL="http://www.hdfgroup.org/ftp/HDF5/current/src/CMake/CMake-files/ZLib.tar.gz"
@set SRC_PKG=ZLib.tar.gz
@set BUILD_DIR=%BUILD_ROOT%\zlib

@call try-mkdir.cmd %BUILD_DIR%
@cd %BUILD_DIR%
@call download-file.cmd %SRC_PKG% %SRC_PKG_URL%

@set ZLIB_ROOT=%BUILD_DIR%\ZLib
@if not exist %ZLIB_ROOT% @call extract-tarball.cmd %SRC_PKG% %CD%
cd %ZLIB_ROOT%

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Build
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@if not exist %ZLIB_ROOT%\build mkdir %ZLIB_ROOT%\build
cd %ZLIB_ROOT%\build
cmake -G"Visual Studio 14 2015 Win64" -C %ZLIB_EXTRAS_DIR%\zlib.cmake -DCMAKE_INSTALL_PREFIX=%INSTALL_ROOT% ..
@call:build-project zlib.vcxproj

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Install
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call:build-project INSTALL.vcxproj

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Finalize
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call try-pause.cmd
goto:eof

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Functions
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: %1 Project file path
:build-project
msbuild /nologo /p:Configuration=Release %1
msbuild /nologo /p:Configuration=Debug %1
goto:eof