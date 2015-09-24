@setlocal enableextensions
::
:: Build script for the Boost libraries for Mantid
::
@echo Building boost

:: Setup build environment
@call %~dp0cmds\common-setup.cmd

:: Download the source package
@set SRC_PKG_URL="http://downloads.sourceforge.net/project/boost/boost/1.59.0/boost_1_59_0.zip?r=http%3A%2F%2Fwww.boost.org%2Fusers%2Fhistory%2Fversion_1_59_0.html&ts=1443101740&use_mirror=kent"
@set SRC_PKG=boost_1_59_0.zip
@set BUILD_DIR=%~dp0\builds\boost

@call try-mkdir.cmd %BUILD_DIR%
@cd %BUILD_DIR%
@call download-file.cmd %SRC_PKG% %SRC_PKG_URL%
@call extract-zip-file.cmd %SRC_PKG% %CD%

:: return to where we were
@cd %~dp0

pause

goto:eof
