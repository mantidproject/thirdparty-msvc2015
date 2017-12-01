@setlocal enableextensions enabledelayedexpansion
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
@set INSTALL_PREFIX_UNIX=%INSTALL_PREFIX:\=/%
@set LOCAL_INSTALL_PREFIX=%BUILD_DIR%\localinstall
@set LOCAL_INSTALL_UNIX=%LOCAL_INSTALL_PREFIX:\=/%

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
 "-DCMAKE_PREFIX_PATH=%INSTALL_PREFIX:\\=/%;%LOCAL_INSTALL_UNIX%" ^
 "-DJPEG_DIR:PATH=%LOCAL_INSTALL_UNIX/cmake/JPEG"
@call build-and-install.cmd %HDF4_SRC_ROOT%\build ALL_BUILD.vcxproj

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Nexus
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@echo Building NeXus
@set NXS_PKG_URL="https://github.com/nexusformat/code/archive/4.3.3.zip"
@set NXS_PKG=4.3.3.zip
@set NXS_SRC_ROOT=%BUILD_DIR%\code-4.3.3
if not exist %NXS_SRC_ROOT% call download-and-extract.cmd %BUILD_DIR%\%NXS_PKG% %NXS_PKG_URL%

cd %NXS_SRC_ROOT%
if not exist cmake_include\FindHDF4.cmake.orig patch -p0 --input=%NEXUS_EXTRAS_DIR%\FindHDF4.cmake.patch --backup

:: HDF libraries. Scripts require an environment variable
@set HDF4_ROOT=%LOCAL_INSTALL_UNIX%
@set HDF5_ROOT=%INSTALL_PREFIX_UNIX%
@call cmake-configure.cmd %NXS_SRC_ROOT%\ "-C%NEXUS_EXTRAS_DIR%\nexus.cmake" "-DCMAKE_INSTALL_PREFIX=%LOCAL_INSTALL_UNIX%"
@call build-release-and-debug.cmd %NXS_SRC_ROOT%\build\src\NeXus_Shared_Library.vcxproj %NXS_SRC_ROOT%\build\src\INSTALL.vcxproj
@call build-release-and-debug.cmd %NXS_SRC_ROOT%\build\bindings\cpp\NeXus_CPP_Shared_Library.vcxproj %NXS_SRC_ROOT%\build\bindings\cpp\INSTALL.vcxproj
@call build-release-and-debug.cmd %NXS_SRC_ROOT%\build\include\INSTALL.vcxproj

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Install - move from local to global
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
if not exist %INSTALL_PREFIX%\include\nexus mkdir %INSTALL_PREFIX%\include\nexus
@xcopy %LOCAL_INSTALL_PREFIX%\include\nexus\* %INSTALL_PREFIX%\include\nexus /Y /I
@xcopy %LOCAL_INSTALL_PREFIX%\include\napi.h %INSTALL_PREFIX%\include /Y /I
@xcopy %LOCAL_INSTALL_PREFIX%\include\napiu.h %INSTALL_PREFIX%\include /Y /I
@xcopy %LOCAL_INSTALL_PREFIX%\bin\libNeXus-0*.dll %INSTALL_PREFIX%\bin /Y
@xcopy %LOCAL_INSTALL_PREFIX%\bin\libNeXusCPP-0*.dll %INSTALL_PREFIX%\bin /Y
@xcopy %LOCAL_INSTALL_PREFIX%\lib\nexus\libNeXus-0*.lib %INSTALL_PREFIX%\lib /Y
@xcopy %LOCAL_INSTALL_PREFIX%\lib\nexus\libNeXusCPP-0*.lib %INSTALL_PREFIX%\lib /Y

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Install Python bindings
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@set PYTHON_SITE_PACKAGES=%INSTALL_PREFIX%\lib\python2.7\Lib\site-packages
@set NXS_INSTALL_DIR=%PYTHON_SITE_PACKAGES%\nxs
@if not exist %NXS_INSTALL_DIR% mkdir %NXS_INSTALL_DIR%
@xcopy %NXS_SRC_ROOT%\bindings\python\nxs\* %NXS_INSTALL_DIR%

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Finalize
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call try-pause.cmd
goto:eof
