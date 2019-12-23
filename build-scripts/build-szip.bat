@setlocal enableextensions
::
:: Build script for SZip.
@echo Building SZip

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Setup environment. Important to ensure correct detection of environment
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call %~dp0cmds\common-setup.cmd
@set SZIP_EXTRAS_DIR=%~dp0extras\szip

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Download and unpack source. We use the HDF5 patched source that has been
:: patched to build with CMake
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@set SRC_PKG_URL="https://support.hdfgroup.org/ftp/lib-external/szip/2.1.1/src/szip-2.1.1.tar.gz"
@set BUILD_DIR=%BUILD_ROOT%\szip
@set SRC_PKG=szip-2.1.1.tar.gz
@call download-and-extract.cmd %BUILD_DIR%\%SRC_PKG% %SRC_PKG_URL%

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Patch
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::echo Patching cmake files for Visual Studio 2015
::@set SRC_ROOT=%BUILD_DIR%\%SRC_PKG:.tar.gz=%\
::cd %SRC_ROOT%
::@if not exist config\cmake\szip-config.cmake.in.orig patch -p0 --input=%SZIP_EXTRAS_DIR%\szip-config.cmake.in.patch --backup

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Build
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call cmake-build-and-install %BUILD_DIR%\szip-2.1.1\ %SZIP_EXTRAS_DIR%\szip.cmake %INSTALL_PREFIX% ALL_BUILD.vcxproj
:: remove unwanted files
for %%F in (COPYING README INSTALL RELEASE.txt) do ( del %INSTALL_PREFIX%\%%F )

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Finalize
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call try-pause.cmd
goto:eof
