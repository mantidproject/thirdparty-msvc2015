@setlocal enableextensions
::
:: Build script NeXus. It also builds a static HDF4 and jpeg library for
:: its own use. It requires ZLib and SZip to have been built
@echo Building NeXus

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Setup environment. Important to ensure correct detection of environment
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call %~dp0cmds\common-setup.cmd
@set NEXUS_EXTRAS_DIR=%~dp0extras\nexus

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Overall build
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@set BUILD_DIR=%BUILD_ROOT%\nexus
@set LOCAL_INSTALL_PREFIX=%BUILD_DIR%\localinstall

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: JPEG
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@echo Building JPEG dependency
@set JPEG_PKG_URL="http://www.hdfgroup.org/ftp/HDF/HDF_Current/src/CMake/CMake-files/JPEG8b.tar.gz"
@set JPEG_PKG=JPEG8b.tar.gz
@set JPEG_SRC_ROOT=%BUILD_DIR%\JPEG8b
if not exist %JPEG_SRC_ROOT% call download-and-extract.cmd %BUILD_DIR%\%JPEG_PKG% %JPEG_PKG_URL%

cd %JPEG_SRC_ROOT%
if not exist config\cmake\JPEG-config.cmake.install.in.orig patch -p0 --input=%NEXUS_EXTRAS_DIR%\JPEG-config.cmake.install.in.patch --backup
@call cmake-configure.cmd %JPEG_SRC_ROOT%\ "-C%NEXUS_EXTRAS_DIR%\jpeg.cmake" "-DCMAKE_INSTALL_PREFIX=%LOCAL_INSTALL_PREFIX%"
@call build-and-install.cmd %JPEG_SRC_ROOT%\build ALL_BUILD.vcxproj

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: HDF4
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@echo Building HDF4 dependency
@set HDF4_PKG_URL="http://www.hdfgroup.org/ftp/HDF/HDF_Current/src/hdf-4.2.11.zip"
@set HDF4_PKG=hdf-4.2.11.zip
@set HDF4_SRC_ROOT=%BUILD_DIR%\hdf-4.2.11
if not exist %HDF4_SRC_ROOT% call download-and-extract.cmd %BUILD_DIR%\%HDF4_PKG% %HDF4_PKG_URL%

cd %HDF4_SRC_ROOT%
if not exist config\cmake_ext_mod\HDFTests.c.orig patch -p0 --input=%NEXUS_EXTRAS_DIR%\HDFTests.c.patch --backup
if not exist config\cmake_ext_mod\ConfigureChecks.cmake.orig patch -p0 --input=%NEXUS_EXTRAS_DIR%\ConfigureChecks.cmake.patch --backup
@call cmake-configure.cmd %HDF4_SRC_ROOT%\ "-C%NEXUS_EXTRAS_DIR%\hdf4.cmake" "-DCMAKE_INSTALL_PREFIX=%LOCAL_INSTALL_PREFIX%" ^
 "-DCMAKE_PREFIX_PATH=%INSTALL_ROOT:\\=/%;%LOCAL_INSTALL_PREFIX:\\=/%" ^
 "-DJPEG_DIR:PATH=%LOCAL_INSTALL_PREFIX:\\=/%/cmake/JPEG"
@call build-and-install.cmd %HDF4_SRC_ROOT%\build ALL_BUILD.vcxproj
 
 
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Nexus
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

@set SRC_PKG_URL="https://github.com/nexusformat/code/archive/4.3.3.zip"
@set SRC_PKG=4.3.3.zip
@set SRC_ROOT=%BUILD_DIR%\code-4.3.3
if not exist %SRC_ROOT% call download-and-extract.cmd %BUILD_DIR%\%SRC_PKG% %SRC_PKG_URL%

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Patch
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Build
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::@call cmake-build-and-install %SRC_ROOT%\ %JSONCPP_EXTRAS_DIR%\jsoncpp.cmake %INSTALL_ROOT% src\lib_json\jsoncpp_lib.vcxproj

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Finalize
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call try-pause.cmd
goto:eof
