@setlocal enableextensions
::
:: Build script for the lz4 library for Mantid. The following libraries
:: are built in both release and debug mode:
@echo Building lz4

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Setup environment. Important to ensure correct detection of environment
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call %~dp0cmds\common-setup.cmd

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Download and unpack source
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@set SRC_PKG_URL="https://github.com/lz4/lz4/archive/v1.8.0.zip"
@set SRC_PKG=v1.8.0.zip
@set BUILD_DIR=%BUILD_ROOT%\lz4

@call try-mkdir.cmd %BUILD_DIR%
@cd %BUILD_DIR%
@call download-file.cmd %SRC_PKG% %SRC_PKG_URL%
@set LZ4_ROOT=%BUILD_DIR%\lz4-1.8.0
@call extract-zip-file.cmd %SRC_PKG% %CD%

@set VS_BUILD_DIR=%LZ4_ROOT%\Visual\VS2010
@cd %VS_BUILD_DIR%

devenv lz4.sln /upgrade
@call:build-lz4 Release
@call:build-lz4 Debug


@call try-mkdir.cmd %INSTALL_PREFIX%\include\lz4
xcopy %LZ4_ROOT%\lib\*.h %INSTALL_PREFIX%\include\lz4 /Y

@call:install-libs Release
@call:install-libs Debug
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Functions
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: %1 Configuration to build: Release/Debug
:build-lz4
msbuild /nologo /p:Configuration=%1 /p:PlatformToolset=v140 /p:Platform="x64" %VS_BUILD_DIR%\lz4.sln
goto:eof

:: %1 Configuration to build: Release/Debug
:install-libs
IF %1 == Release (
    xcopy %VS_BUILD_DIR%\bin\x64_%1\liblz4.lib %INSTALL_PREFIX%\lib /Y /I
    xcopy %VS_BUILD_DIR%\bin\x64_%1\liblz4.pdb %INSTALL_PREFIX%\bin /Y /I
    xcopy %VS_BUILD_DIR%\bin\x64_%1\liblz4.dll %INSTALL_PREFIX%\bin /Y /I
) ELSE (
    xcopy %VS_BUILD_DIR%\bin\x64_%1\liblz4.lib %INSTALL_PREFIX%\lib\liblz4_d.lib /Y /I
    xcopy %VS_BUILD_DIR%\bin\x64_%1\liblz4.pdb %INSTALL_PREFIX%\bin\liblz4_d.pdb /Y /I
    xcopy %VS_BUILD_DIR%\bin\x64_%1\liblz4.dll %INSTALL_PREFIX%\bin\liblz4_d.dll /Y /I
)
goto:eof