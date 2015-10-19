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
@set SRC_PKG_URL="https://docs.google.com/uc?export=download&id=0BzuB-ydOOoduejdwdTQwcF9JLTA"
@set BUILD_DIR=%BUILD_ROOT%\muparser
@set SRC_PKG=muparser_v2_2_4.zip
@set SRC_ROOT=%BUILD_DIR%\muparser_v2_2_4
@if not exist %SRC_ROOT% call download-and-extract.cmd %BUILD_DIR%\%SRC_PKG% %SRC_PKG_URL%

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Patch
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Build
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Set configure options for static, release and debug builds
cd %SRC_ROOT%
sed -e's/DEBUG = 0/DEBUG = 1/' build\makefile.vc > build\makefile.vc.debug
cd build
nmake -f makefile.vc
nmake -f makefile.vc.debug

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Install
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
xcopy %SRC_ROOT%\include\*.h %INSTALL_ROOT%\include /Y /I
xcopy %SRC_ROOT%\lib\*.lib %INSTALL_ROOT%\lib /Y /I

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Finalize
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call try-pause.cmd
goto:eof
