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

@call download-and-extract.cmd %BUILD_DIR%\%SRC_PKG% %SRC_PKG_URL%

@cd %BUILD_DIR%\openssl-1.0.2d
:: release build
@ perl Configure VC-WIN64A --prefix=%INSTALL_PREFIX%
@ call ms\do_win64a
@ nmake -f ms\ntdll.mak
@ nmake -f ms\ntdll.mak install

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Finalize
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call try-pause.cmd
