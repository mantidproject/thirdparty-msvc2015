@setlocal enableextensions
::
:: Build script for the rdKafka library for Mantid. The following libraries
:: are built in both release and debug mode:
@echo Building LibRDKafka

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Setup environment. Important to ensure correct detection of environment
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call %~dp0cmds\common-setup.cmd

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Download and unpack source
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@set SRC_PKG_URL="https://github.com/edenhill/librdkafka/archive/v0.9.2.zip"
@set SRC_PKG=v0.9.2.zip
@set BUILD_DIR=%BUILD_ROOT%\librdkafka

@call try-mkdir.cmd %BUILD_DIR%
@cd %BUILD_DIR%
@call download-file.cmd %SRC_PKG% %SRC_PKG_URL%

set LIBRDKAFKA_ROOT=%BUILD_DIR%\librdkafka-0.9.2
@call extract-zip-file.cmd %SRC_PKG% %CD%


::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Build
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@set VS_BUILD_DIR=%LIBRDKAFKA_ROOT%\win32
@cd %VS_BUILD_DIR%

:: Download nuget for missing packages
@set NUGET_PKG_URL="https://dist.nuget.org/win-x86-commandline/latest/nuget.exe"
@set NUGET_PKG=nuget.exe
@call download-file.cmd %NUGET_PKG% %NUGET_PKG_URL%

::Assume OpenSSL has already been downloaded
@set PATH=%PATH%;%INSTALL_ROOT%\include;%INSTALL_ROOT%\bin;
::install missing packages
nuget install packages.config -outputdirector %VS_BUILD_DIR%\packages

@call:build-rdkafka Release
@call:build-rdkafka Debug

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Install
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
if not exist %INSTALL_ROOT%\include\librdkafka mkdir %INSTALL_ROOT%\include\librdkafka
xcopy %LIBRDKAFKA_ROOT%\src-cpp\*.h %INSTALL_ROOT%\include\librdkafka /Y

@call:install-libs-Release
@call:install-libs-Debug

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Functions
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: %1 Configuration to build: Release/Debug
:build-rdkafka
msbuild /nologo /p:Configuration=%1 /p:Platform=x64 /p:PlatformToolset=v140 %VS_BUILD_DIR%\librdkafka.sln
goto:eof

:install-libs-Release
xcopy %VS_BUILD_DIR%\x64\Release\librdkafkacpp.lib %INSTALL_ROOT%\lib /Y /I
xcopy %VS_BUILD_DIR%\x64\Release\librdkafkacpp.pdb %INSTALL_ROOT%\bin /Y /I
xcopy %VS_BUILD_DIR%\x64\Release\librdkafkacpp.dll %INSTALL_ROOT%\bin /Y /I
goto:eof

:install-libs-Debug
copy %VS_BUILD_DIR%\x64\Debug\librdkafkacpp.lib %INSTALL_ROOT%\lib\librdkafkacppd.lib /Y 
copy %VS_BUILD_DIR%\x64\Debug\librdkafkacpp.pdb %INSTALL_ROOT%\bin\librdkafkacppd.pdb /Y 
copy %VS_BUILD_DIR%\x64\Debug\librdkafkacpp.dll %INSTALL_ROOT%\bin\librdkafkacppd.dll /Y 
goto:eof