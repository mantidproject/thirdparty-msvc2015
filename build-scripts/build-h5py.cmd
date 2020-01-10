@setlocal enableextensions enabledelayedexpansion
::
:: Build script for h5py. It requires HDF5 to have been built first.
:: This scirpt is callable from another and requires the version of HD5
:: to be passed in as the first argument
set HDF5_VERSION=%1
@echo Building h5Py against HDF5 version %HDF_VERSION%

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Setup environment. Important to ensure correct detection of environment
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call %~dp0cmds\common-setup.cmd
set BUILD_DIR=%BUILD_ROOT%\h5py

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Download and extract
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@set SRC_PKG_URL=https://github.com/h5py/h5py/archive/2.10.0.zip
@set SRC_PKG=h5py-2.10.0.zip
cd %BUILD_DIR%
@call download-and-extract.cmd %BUILD_DIR%\!SRC_PKG! !SRC_PKG_URL!

:: use compiler already initialized
@set DISTUTILS_USE_SDK=1
@set MSSdk=1
cd %BUILD_DIR%\h5py-2.10.0
%PYTHON_INSTALL_PREFIX%\python setup.py configure --hdf5=%INSTALL_PREFIX% --hdf5-version=%HDF5_VERSION%
%PYTHON_INSTALL_PREFIX%\python setup.py install

