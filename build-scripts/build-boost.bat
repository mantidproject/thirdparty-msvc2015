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
::Fetch Microsoft MPI
@set MS_MPI_SDK_PACKAGE_URL="https://download.microsoft.com/download/B/2/E/B2EB83FE-98C2-4156-834A-E1711E6884FB/msmpisdk.msi"
@set MS_MPI_SDK_PACKAGE=msmpisdk.msi
@set MS_MPI_PACKAGE_URL="https://download.microsoft.com/download/B/2/E/B2EB83FE-98C2-4156-834A-E1711E6884FB/MSMpiSetup.exe"
@set MS_MPI_PACKAGE=MSMpiSetup.exe

::Fetch Boost 1.64.0
@set SRC_PKG_URL="https://sourceforge.net/projects/boost/files/boost/1.63.0/boost_1_63_0.zip"
@set SRC_PKG=boost_1_63_0.zip
@set BUILD_DIR=%BUILD_ROOT%\boost



@call try-mkdir.cmd %BUILD_DIR%
@cd %BUILD_DIR%

::install MS MPI if it doesnt exit
if not exist "C:/Program Files/Microsoft MPI" (
    call download-file.cmd %MS_MPI_PACKAGE% %MS_MPI_PACKAGE_URL%
    call %BUILD_DIR%\MSMpiSetup.exe
)

::install MS MPI SDK if it doesnt exist
if not exist "C:/Program Files (x86)/Microsoft SDKs/MPI" (
    call download-file.cmd %MS_MPI_SDK_PACKAGE% %MS_MPI_SDK_PACKAGE_URL%
    call msiexec.exe /i %BUILD_DIR%\msmpisdk.msi
)

::move MS MPI into repo
xcopy "C:\Program Files (x86)\Microsoft SDKs\MPI\Include\*.h" %INSTALL_ROOT%\include /Y /I
if not exist %INSTALL_ROOT%\include\x64 call try-mkdir.cmd %INSTALL_ROOT%\include\x64
xcopy "C:\Program Files (x86)\Microsoft SDKs\MPI\Include\x64\*.h" %INSTALL_ROOT%\include /Y /I
xcopy "C:\Program Files (x86)\Microsoft SDKs\MPI\Lib\x64\*.lib" %INSTALL_ROOT%\lib /Y /I
xcopy "C:\Program Files (x86)\Microsoft SDKs\MPI\Lib\x64\*.lib" %INSTALL_ROOT%\lib /Y /I

@call download-file.cmd %SRC_PKG% %SRC_PKG_URL%

set BOOST_ROOT=%BUILD_DIR%\boost_1_63_0
@call extract-zip-file.cmd %SRC_PKG% %CD%

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Patch
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
cd %BOOST_ROOT%
if not exist include\boost\type_traits\visualc.hpp.orig call patch -p0 --input=%BOOST_EXTRAS_DIR%\visualc.hpp.patch --backup

:: use custom project configuration which includes mpi build
xcopy %INSTALL_ROOT%\build-scripts\extras\boost\project-config.jam %BOOST_ROOT% /Y /I

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
@call b2.exe -j 8 %COMMON_BUILD_OPTS% --with-date_time --with-regex --with-python --with-serialization --with-filesystem --with-mpi variant=release variant=debug install --prefix=%INSTALL_ROOT% --layout=tagged
:: We want the dlls in bin but b2 won't allow that
echo Moving dlls to %INSTALL_ROOT%\bin
@move /Y %INSTALL_ROOT%\lib\boost*.dll %INSTALL_ROOT%\bin

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Finalize
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call try-pause.cmd