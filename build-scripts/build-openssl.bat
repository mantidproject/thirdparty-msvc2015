@setlocal enableextensions
::
:: Build script for openssl
::
@echo Building openssl

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Setup environment. Important to ensure correct detection of environment
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call %~dp0cmds\common-setup.cmd

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Download and unpack source
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@set SRC_PKG_URL=ftp://ftp.openssl.org/source/openssl-1.0.2d.tar.gz
@set SRC_PKG=openssl-1.0.2d.tar.gz
@set BUILD_DIR=%BUILD_ROOT%\openssl

@call try-mkdir.cmd %BUILD_DIR%
@cd %BUILD_DIR%
@call download-file.cmd %SRC_PKG% %SRC_PKG_URL%

:: Requires 2 steps to extract with 7zip
@set BUILD_ROOT=%SRC_PKG:.tar.gz=%
if not exist %BUILD_ROOT% (
  7z x %SRC_PKG% -y
  7z x %SRC_PKG:.gz=% -y
)
@cd %BUILD_ROOT%
:: release build
@ perl Configure VC-WIN64A --prefix=%INSTALL_ROOT%
@ call ms\do_win64a
@ nmake -f ms\ntdll.mak
@ nmake -f ms\ntdll.mak install

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Finalize
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call try-pause.cmd
