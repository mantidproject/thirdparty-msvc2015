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
@set BUILD_DIR=%BUILD_ROOT%\zlib
@set SRC_PKG=ZLib.tar.gz
@call download-and-extract.cmd %BUILD_DIR%\%SRC_PKG% %SRC_PKG_URL%

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Build
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call cmake-build-and-install %BUILD_DIR%\ZLib\ %ZLIB_EXTRAS_DIR%\zlib.cmake %INSTALL_ROOT% zlib.vcxproj
:: remove unwanted files
for %%F in (FAQ README INDEX RELEASE_HDF.txt) do ( del %INSTALL_ROOT%\%%F )

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Finalize
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call try-pause.cmd
goto:eof
