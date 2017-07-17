@setlocal enableextensions
::
:: Build script for the rdKafka library for Mantid. The following libraries
:: are built in both release and debug mode:
@echo Building LibRDKafka

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Setup environment. Important to ensure correct detection of environment
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call %~dp0cmds\common-setup.cmd
@set LIBRDKAFKA_EXTRAS_DIR=%~dp0extras\librdkafka

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Download and unpack source
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@set SRC_PKG_URL="https://github.com/edenhill/librdkafka/archive/v0.9.4.zip"
@set SRC_PKG=v0.9.4.zip
@set BUILD_DIR=%BUILD_ROOT%\librdkafka

@call try-mkdir.cmd %BUILD_DIR%
@cd %BUILD_DIR%
@call download-file.cmd %SRC_PKG% %SRC_PKG_URL%

@set LIBRDKAFKA_ROOT=%BUILD_DIR%\librdkafka-0.9.4
@call extract-zip-file.cmd %SRC_PKG% %CD%

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Patch source
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
cd %LIBRDKAFKA_ROOT%
@call patch -p0 --input=%LIBRDKAFKA_EXTRAS_DIR%\win32_config.h.patch --backup

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Build
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@set VS_BUILD_DIR=%LIBRDKAFKA_ROOT%\win32
@cd %VS_BUILD_DIR%

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Patch build files
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@set MANTIDTHIRDPARTY=%INSTALL_PREFIX%
@call patch -p0 --input=%LIBRDKAFKA_EXTRAS_DIR%\librdkafka.sln.patch --backup
@call patch -p0 --input=%LIBRDKAFKA_EXTRAS_DIR%\librdkafka.vcxproj.patch --backup
@call patch -p0 --input=%LIBRDKAFKA_EXTRAS_DIR%\librdkafkacpp.vcxproj.patch --backup

@call:build-rdkafka Release
@call:build-rdkafka Debug

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Install
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
if not exist %INSTALL_PREFIX%\include\librdkafka mkdir %INSTALL_PREFIX%\include\librdkafka
xcopy %LIBRDKAFKA_ROOT%\src-cpp\*.h %INSTALL_PREFIX%\include\librdkafka /Y
xcopy %LIBRDKAFKA_ROOT%\src\*.h %INSTALL_PREFIX%\include\librdkafka /Y

@call:install-libs Release
@call:install-libs Debug

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Finalize
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call try-pause.cmd
goto:eof

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Functions
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: %1 Configuration to build: Release/Debug
:build-rdkafka
msbuild /nologo /p:Configuration=%1 /p:PlatformToolset=v140 /p:Platform="x64" %VS_BUILD_DIR%\librdkafka.sln
goto:eof

:: %1 Configuration to build: Release/Debug
:install-libs
xcopy %VS_BUILD_DIR%\outdir\v140\x64\%1\librdkafka*.lib %INSTALL_PREFIX%\lib /Y /I
xcopy %VS_BUILD_DIR%\outdir\v140\x64\%1\librdkafka*.pdb %INSTALL_PREFIX%\bin /Y /I
xcopy %VS_BUILD_DIR%\outdir\v140\x64\%1\librdkafka*.dll %INSTALL_PREFIX%\bin /Y /I
goto:eof
