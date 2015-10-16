@setlocal enableextensions
::
:: Build script Sip/PyQt4. They generally should come as a pair so always build them together
@echo Building Sip/PyQt4

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Setup environment. Important to ensure correct detection of environment
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call %~dp0cmds\common-setup.cmd
@set SIP_EXTRAS_DIR=%~dp0extras\sip-pyqt4
:: Requires both python and Qt4
@set PATH=%INSTALL_ROOT%\bin;%INSTALL_ROOT%\lib\qt4\bin;%INSTALL_ROOT%\lib\python2.7;D:\Builds\jom;%PATH%

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: SIP
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@set SIP_PKG_URL="https://downloads.sourceforge.net/project/pyqt/sip/sip-4.16.9/sip-4.16.9.zip"
@set BUILD_DIR=%BUILD_ROOT%\sip-pyqt4
@set SIP_PKG=sip-4.16.9.zip
@set SIP_ROOT=%BUILD_DIR%\%SIP_PKG:~0,-4%
@call download-and-extract.cmd %BUILD_DIR%\%SIP_PKG% %SIP_PKG_URL%

cd %SIP_ROOT%
:: copy the required mkspec to the required folder
@xcopy /Y %INSTALL_ROOT%\lib\qt4\mkspecs\%QMAKESPEC%\qmake.conf specs\%QMAKESPEC%
@call python configure.py --platform=%QMAKESPEC%
@call nmake
@call nmake install

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: PyQt4
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@set PYQT4_PKG_URL="https://downloads.sf.net/project/pyqt/PyQt4/PyQt-4.11.4/PyQt-win-gpl-4.11.4.zip"
@set PYQT4_PKG=PyQt-win-gpl-4.11.4.zip
@set PYQT4_ROOT=%BUILD_DIR%\%PYQT4_PKG:~0,-4%
@call download-and-extract.cmd %BUILD_DIR%\%PYQT4_PKG% %PYQT4_PKG_URL%

cd %PYQT4_ROOT%
:: There is an issue compiling pylupdate. Moc hands on translator.h in the makefile so we compile it first
pushd pylupdate
del moc_translator.cpp 2> nul
del moc_translator.obj 2> nul
@call moc.exe -o moc_translator.cpp translator.h
popd
@call python configure.py --confirm-license --assume-shared --qsci-api -w --no-designer-plugin
:: jom doesn't seem to work correctly
@call nmake
@call nmake install

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Finalize
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call try-pause.cmd
goto:eof
