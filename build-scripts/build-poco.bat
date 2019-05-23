@setlocal enableextensions
::
:: Build script for the Poco libraries for Mantid. All libraries are built.
:: Requires OpenSSL to have been built and installed in INSTALL_PREFIX
::
@echo Building poco

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Setup environment. Important to ensure correct detection of environment
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call %~dp0cmds\common-setup.cmd

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Download and unpack source
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@set SRC_PKG_URL="https://github.com/pocoproject/poco/archive/poco-1.6.1-release.zip"
@set SRC_PKG=poco-1.6.1-release.zip
@set BUILD_DIR=%BUILD_ROOT%\poco

@call try-mkdir.cmd %BUILD_DIR%
@cd %BUILD_DIR%
@call download-file.cmd %SRC_PKG% %SRC_PKG_URL%

@set POCO_ROOT=%BUILD_DIR%\poco-poco-1.6.1-release
@if not exist %POCO_ROOT% @call extract-zip-file.cmd %SRC_PKG% %CD%

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Build
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@cd %POCO_ROOT%
set VS_SUFFIX=140
set OPENSSL_INCLUDE=%INSTALL_PREFIX%\include
set OPENSSL_LIB=%INSTALL_PREFIX%\lib
set INCLUDE=%INCLUDE%;%OPENSSL_INCLUDE%
set LIB=%LIB%;%OPENSSL_LIB%
set LIBRARIES=Foundation XML JSON Util Net Zip Crypto NetSSL_OpenSSL

for %%C in (%LIBRARIES%) do (
  call:build-project %%C\%%C_x64_vs%VS_SUFFIX%.vcxproj release_shared
  if ERRORLEVEL exit /b 1
  call:build-project %%C\%%C_x64_vs%VS_SUFFIX%.vcxproj debug_shared
  if ERRORLEVEL exit /b 1
)

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Install
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
rmdir /S /Q %INSTALL_PREFIX%\include\Poco
rmdir /S /Q %INSTALL_PREFIX%\bin\Poco*.dll
rmdir /S /Q %INSTALL_PREFIX%\lib\Poco*.lib
for %%C in (%LIBRARIES%) do xcopy %%C\include %INSTALL_PREFIX%\include /Y /E
xcopy %POCO_ROOT%\bin64\*.dll %INSTALL_PREFIX%\bin /Y
xcopy %POCO_ROOT%\lib64\*.lib %INSTALL_PREFIX%\lib /Y

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Finalize
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call try-pause.cmd
goto:eof

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Functions
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:build-project
set BUILD_TOOL=msbuild
set ACTION=/t:build
set EXTRASW=/m
set USEENV=/p:UseEnv=true

%BUILD_TOOL% %USEENV% %EXTRASW% %ACTION% /p:Configuration=%2 %1
if ERRORLEVEL exit /b 1
goto:eof