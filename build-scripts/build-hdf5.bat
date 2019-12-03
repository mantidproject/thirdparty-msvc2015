@setlocal enableextensions enabledelayedexpansion
::
:: Build script for HDF5, ZLib and SZip. It requires ZLib and SZip
:: to have been installed into INSTALL_PREFIX first
@echo Building HDF5

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Setup environment. Important to ensure correct detection of environment
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call %~dp0cmds\common-setup.cmd
@set HDF5_EXTRAS_DIR=%~dp0extras\hdf5

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Download and unpack source. We use the HDF5 patched source that has been
:: patched to build with CMake
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: When the version is updated, update the --hdf5-version= version for h5py below
@set SRC_PKG_URL="https://www.hdfgroup.org/package/hdf5-1-10-5-zip/?wpdmdl=13572&refresh=5de6201156f221575362577"
@set BUILD_DIR=%BUILD_ROOT%\hdf5
@set SRC_PKG=hdf5-1.10.5.zip
@call download-and-extract.cmd %BUILD_DIR%\%SRC_PKG% %SRC_PKG_URL%

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Patches
:: Patch files were generated by looking at the changes from the following commits to VTK:
::   - https://gitlab.kitware.com/ben.boeckel/vtk/commit/718941125d967015e366172dd09793268f4c9eb5
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo Patching cmake files for Visual Studio 2015
@set SRC_ROOT=%BUILD_DIR%\%SRC_PKG:.zip=%\
::cd %SRC_ROOT%
::@if not exist config\cmake_ext_mod\HDFTests.c.orig patch -p0 --input=%HDF5_EXTRAS_DIR%\HDFTests.c.patch --backup
::@if not exist config\cmake_ext_mod\ConfigureChecks.cmake.orig patch -p0 --input=%HDF5_EXTRAS_DIR%\ConfigureChecks.cmake.patch --backup

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Build
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@del /Q %INSTALL_PREFIX%\include\H5*
@del /Q %INSTALL_PREFIX%\hdf5*
@call cmake-configure %SRC_ROOT%\ -C "%SRC_ROOT%\config\cmake\cacheinit.cmake" -C "%HDF5_EXTRAS_DIR%\hdf5.cmake" ^
 "-DCMAKE_PREFIX_PATH:PATH=%INSTALL_PREFIX%" "-DCMAKE_INSTALL_PREFIX=%INSTALL_PREFIX%"
 @call build-and-install.cmd %SRC_ROOT%\build ALL_BUILD.vcxproj
:: remove unwanted files
for %%F in (COPYING USING_HDF5_CMake.txt USING_HDF5_VS.txt Release.txt) do ( del %INSTALL_PREFIX%\%%F )

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Build h5py against this version
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@set SRC_PKG_URL=https://github.com/h5py/h5py/archive/2.5.0.zip
@set SRC_PKG=h5py-2.5.0.zip
cd %BUILD_DIR%
@call download-and-extract.cmd %BUILD_DIR%\!SRC_PKG! !SRC_PKG_URL!

echo Patching files for Visual Studio 2015
@set SRC_ROOT=h5py-2.5.0
cd !SRC_ROOT!
@if not exist setup_build.py.orig patch -p0 --input=%HDF5_EXTRAS_DIR%\h5py-setup_build.py.patch --backup

:: use compiler already initialized
@set DISTUTILS_USE_SDK=1
@set MSSdk=1
cd %BUILD_DIR%\h5py-2.5.0
%PYTHON_INSTALL_PREFIX%\python setup.py configure --hdf5=%INSTALL_PREFIX% --hdf5-version=1.10.5
%PYTHON_INSTALL_PREFIX%\python setup.py install

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Finalize
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call try-pause.cmd
goto:eof
