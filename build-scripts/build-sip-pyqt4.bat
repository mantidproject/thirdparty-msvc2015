@setlocal enableextensions
::
:: Build script Sip/PyQt4. They generally should come as a pair so always build them together
@echo Building Sip/PyQt4

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Setup environment. Important to ensure correct detection of environment
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call %~dp0cmds\common-setup.cmd
@set SIP_EXTRAS_DIR=%~dp0extras\sip-pyqt4
@set INCLUDE=%INSTALL_ROOT%\include;%INCLUDE%
@set LIB=%INSTALL_ROOT%\lib;%LIB%
@set PATH_NO_QT=%INSTALL_ROOT%\bin;%INSTALL_ROOT%\lib\python2.7;D:\Builds\jom;%PATH%
@set PATH=%PATH_NO_QT%

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: SIP
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@set SIP_PKG_URL="https://downloads.sourceforge.net/project/pyqt/sip/sip-4.16.9/sip-4.16.9.zip"
@set BUILD_DIR=%BUILD_ROOT%\sip-pyqt4
@set SIP_PKG=sip-4.16.9.zip
@set SIP_ROOT=%BUILD_DIR%\%SIP_PKG:~0,-4%
@call download-and-extract.cmd %BUILD_DIR%\%SIP_PKG% %SIP_PKG_URL%

:: Standard Qt build
@set PATH=%INSTALL_ROOT%\lib\qt4\bin;%PATH_NO_QT%
echo %PATH%
cd %SIP_ROOT%
:: copy the required mkspec to the required folder
@copy /Y %INSTALL_ROOT%\lib\qt4\mkspecs\%QMAKESPEC%\qmake.conf specs\%QMAKESPEC%
@call python configure.py --platform=%QMAKESPEC%
@call nmake
@call nmake install

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: PyQt4 download
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@set PYQT4_PKG_URL="https://downloads.sf.net/project/pyqt/PyQt4/PyQt-4.11.4/PyQt-win-gpl-4.11.4.zip"
@set PYQT4_PKG=PyQt-win-gpl-4.11.4.zip
@set PYQT4_ROOT=%BUILD_DIR%\%PYQT4_PKG:~0,-4%
@call download-and-extract.cmd %BUILD_DIR%\%PYQT4_PKG% %PYQT4_PKG_URL%

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: release build with static Qt
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@set PATH=%BUILD_ROOT%\Qt-static\qt-everywhere-opensource-src-4.8.6\bin;%PATH_NO_QT%
cd %PYQT4_ROOT%
:: Disable phonon as it won't compile
if not exist configure.py.orig call patch -p0 --input=%SIP_EXTRAS_DIR%\pyqt4\configure.py.patch --backup

:: There is an issue compiling pylupdate. Moc hangs on translator.h in the makefile so we compile it first
pushd pylupdate
del moc_translator.cpp 2> nul
del moc_translator.obj 2> nul
@call moc.exe -o moc_translator.cpp translator.h
popd
@call python configure.py --confirm-license --qsci-api -w -g --no-designer-plugin
:: jom doesn't seem to work correctly
@call nmake
@call nmake install

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Fix the sipconfig/pyqtconfig files
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@set SIPCONFIG=%PYTHON_INSTALL_ROOT%\Lib\site-packages\sipconfig.py
@set PYQTCONFIG=%PYTHON_INSTALL_ROOT%\Lib\site-packages\PyQt4\pyqtconfig.py
@call python %SIP_EXTRAS_DIR%\fix-configs.py %SIPCONFIG% %PYQTCONFIG%
:: Overwrite the installed files
move /Y %SIPCONFIG%.fixed %SIPCONFIG%
move /Y %PYQTCONFIG%.fixed %PYQTCONFIG%

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Finalize
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call try-pause.cmd
goto:eof
