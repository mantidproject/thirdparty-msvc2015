@setlocal enableextensions
::
:: Build script muParser
@echo Building muParser

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Setup environment. Important to ensure correct detection of environment
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call %~dp0cmds\common-setup.cmd
@set MUPSR_EXTRAS_DIR=%~dp0extras\muparser

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Download and unpack source.
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@set SRC_PKG_URL=https://github.com/beltoforion/muparser/archive/v2.2.6.1.zip
@set BUILD_DIR=%BUILD_ROOT%\muparser
@set SRC_PKG=v2.2.6.1.zip
@set SRC_ROOT=%BUILD_DIR%\muparser-2.2.6.1
@if not exist %SRC_ROOT% call download-and-extract.cmd %BUILD_DIR%\%SRC_PKG% %SRC_PKG_URL%

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Patch
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo Patching cmake files to add debug suffix
cd %SRC_ROOT%
@if not exist CMakeLists.txt.orig patch -p0 --input=%MUPSR_EXTRAS_DIR%\debug-suffix.patch --backup

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Build
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
mkdir cmakebuild
cd cmakebuild
cmake -G "Visual Studio 14 2015 Win64" -DBUILD_SHARED_LIBS=ON -DBUILD_TESTING=OFF "-DCMAKE_PREFIX_PATH:PATH=%INSTALL_PREFIX%" ^
 "-DCMAKE_INSTALL_PREFIX=%INSTALL_PREFIX%" %SRC_ROOT%
@call build-and-install.cmd %SRC_ROOT%\cmakebuild\build ALL_BUILD.vcxproj

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Finalize
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call try-pause.cmd
goto:eof
