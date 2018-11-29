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
:: HDF
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@echo Downloading HDF Dependencies
@set CMAKEHDF_PKG_URL="https://support.hdfgroup.org/ftp/HDF/HDF_Current/src/CMake-hdf-4.2.13.tar.gz"
@set CMAKEHDF_PKG=CMake-hdf-4.2.13.tar.gz
@set CMAKEHDF_SRC_ROOT=%BUILD_DIR%\CMake-hdf-4.2.13
if not exist %CMAKEHDF_SRC_ROOT% call download-and-extract.cmd %BUILD_DIR%\%CMAKEHDF_PKG% %CMAKEHDF_PKG_URL%

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: JPEG
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@echo Building JPEG dependency
@set JPEG_PKG_URL=%CMAKEHDF_SRC_ROOT%\JPEG8d.tar.gz
@set JPEG_PKG=%JPEG_PKG_URL%
@set JPEG_SRC_ROOT=%CMAKEHDF_SRC_ROOT%\JPEG8d
if not exist %JPEG_SRC_ROOT% call download-and-extract.cmd %JPEG_PKG% %JPEG_PKG_URL%

cd %JPEG_SRC_ROOT%
@call cmake-configure.cmd %JPEG_SRC_ROOT%\ "-C%NEXUS_EXTRAS_DIR%\jpeg.cmake" "-DCMAKE_INSTALL_PREFIX=%LOCAL_INSTALL_PREFIX%"
@call build-and-install.cmd %JPEG_SRC_ROOT%\build ALL_BUILD.vcxproj

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: HDF4
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@set HDF4_SRC_ROOT=%CMAKEHDF_SRC_ROOT%\hdf-4.2.13
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
@set NXS_PKG_URL="https://github.com/nexusformat/code/archive/v4.4.3.zip"
@set NXS_PKG=4.4.3.zip
@set NXS_SRC_ROOT=%BUILD_DIR%\code-4.4.3
if not exist %NXS_SRC_ROOT% call download-and-extract.cmd %BUILD_DIR%\%NXS_PKG% %NXS_PKG_URL%

cd %NXS_SRC_ROOT%
if not exist bindings/cpp/NeXusFile.cpp.orig patch -p0 --input=%NEXUS_EXTRAS_DIR%\NeXusFile.cpp.patch --backup
if not exist cmake_include\FindHDF4.cmake.orig patch -p0 --input=%NEXUS_EXTRAS_DIR%\FindHDF4.cmake.patch --backup

:: HDF libraries. Scripts require an environment variable
@set HDF4_ROOT=%LOCAL_INSTALL_UNIX%
@set HDF5_ROOT=%INSTALL_PREFIX_UNIX%
@call cmake-configure.cmd %NXS_SRC_ROOT%\ -C%NEXUS_EXTRAS_DIR%\nexus.cmake "-DCMAKE_INSTALL_PREFIX=%LOCAL_INSTALL_UNIX%" "-DENABLE_CXX=ON" "-DENABLE_HDF4=ON" "-DCMAKE_DEBUG_POSTFIX=D"
@call build-release-and-debug.cmd %NXS_SRC_ROOT%\build\src\NeXus_Shared_Library.vcxproj %NXS_SRC_ROOT%\build\src\INSTALL.vcxproj
@call build-release-and-debug.cmd %NXS_SRC_ROOT%\build\bindings\cpp\NeXus_CPP_Shared_Library.vcxproj %NXS_SRC_ROOT%\build\bindings\cpp\INSTALL.vcxproj
@call build-release-and-debug.cmd %NXS_SRC_ROOT%\build\include\INSTALL.vcxproj

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Install - move from local to global
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
if not exist %INSTALL_PREFIX%\include\nexus mkdir %INSTALL_PREFIX%\include\nexus
@xcopy %LOCAL_INSTALL_PREFIX%\include\nexus\* %INSTALL_PREFIX%\include\nexus /Y /I
@xcopy %LOCAL_INSTALL_PREFIX%\include\nexus\napi.h %INSTALL_PREFIX%\include /Y /I
@xcopy %LOCAL_INSTALL_PREFIX%\include\nexus\napiu.h %INSTALL_PREFIX%\include /Y /I
@xcopy %LOCAL_INSTALL_PREFIX%\bin\libNeXus-0*.dll %INSTALL_PREFIX%\bin /Y
@xcopy %LOCAL_INSTALL_PREFIX%\bin\libNeXusCPP-0*.dll %INSTALL_PREFIX%\bin /Y
@xcopy %LOCAL_INSTALL_PREFIX%\lib\libNeXus-0*.lib %INSTALL_PREFIX%\lib /Y
@xcopy %LOCAL_INSTALL_PREFIX%\lib\libNeXusCPP-0*.lib %INSTALL_PREFIX%\lib /Y


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
