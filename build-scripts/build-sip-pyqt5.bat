@setlocal enableextensions
::
:: Build script Sip/PyQt5. They generally should come as a pair so always build them together
@echo Building Sip/PyQt5

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Setup environment. Important to ensure correct detection of environment
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call %~dp0cmds\common-setup.cmd
@set SIP_EXTRAS_DIR=%~dp0extras\sip-pyqt5
@set INCLUDE=%INSTALL_PREFIX%\include;%INCLUDE%
@set LIB=%INSTALL_PREFIX%\lib;%LIB%
@set QT_ROOT=%INSTALL_PREFIX%\lib\qt5
@set PYTHONHOME=%INSTALL_PREFIX%\lib\python2.7
@set PATH_NO_QT=%INSTALL_PREFIX%\bin;%PYTHONHOME%;D:\Builds\jom;%PATH%
@set PATH=%QT_ROOT%\bin;%PATH_NO_QT%

@set BUILD_DIR=%BUILD_ROOT%\sip-pyqt5
@call try-mkdir %BUILD_DIR%
@cd %BUILD_DIR%

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: SIP
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@set SRC_PKG_URL="https://downloads.sourceforge.net/project/pyqt/sip/sip-4.19.3/sip-4.19.3.zip"
@set SRC_PKG=sip-4.19.3.zip
@set SIP_BUILD_DIR=%BUILD_DIR%\sip
call try-mkdir.cmd %SIP_BUILD_DIR%
cd /d %SIP_BUILD_DIR%
call download-file.cmd %SRC_PKG% %SRC_PKG_URL%
@set SIP_ROOT=%SIP_BUILD_DIR%\sip-4.19.3
if not exist %SIP_ROOT% (
  call extract-zip-file.cmd %SRC_PKG% %CD%
  :: Patch
  cd /d %SIP_ROOT%
  call patch -p0 --input=%SIP_EXTRAS_DIR%\sip-wrapython.patch --backup
  call python configure.py --platform=%QMAKESPEC%
  call nmake
  call nmake install
)

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: PyQt5. Use two build directories as the build is in place
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@set SRC_PKG_URL="https://downloads.sourceforge.net/project/pyqt/PyQt5/PyQt-5.8.2/PyQt5_gpl-5.8.2.zip"
@set SRC_PKG=PyQt5_gpl-5.8.2.zip
@set PYQT5_BUILD_DIR=%BUILD_DIR%\pyqt5
call try-mkdir.cmd %PYQT5_BUILD_DIR%
cd /d %PYQT5_BUILD_DIR%
call download-file.cmd %SRC_PKG% %SRC_PKG_URL%
@set PYQT5_ROOT=%PYQT5_BUILD_DIR%\PyQt5_gpl-5.8.2
@set QT_CONF_FILE=%PYQT5_ROOT%\qt.conf
if not exist %PYQT5_ROOT% (
  call extract-zip-file.cmd %SRC_PKG% %CD%
  cd %PYQT5_ROOT%
  :: patch
  call patch -p0 --input=%SIP_EXTRAS_DIR%\pyqt-wrappython.patch --backup
  echo [Paths] > %QT_CONF_FILE%
  echo Prefix = %QT_ROOT:\=/% >> %QT_CONF_FILE%
  call python configure.py --confirm-license --no-designer-plugin --spec=%QMAKESPEC%
  call jom -j8
  call nmake install
)

exit /b 0

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Fix the sipconfig file so that it is relocatable
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@set SIPCONFIG=%PYTHON_INSTALL_PREFIX%\Lib\site-packages\sipconfig.py
@set PYQTCONFIG=%PYTHON_INSTALL_PREFIX%\Lib\site-packages\PyQt5\pyqtconfig.py
@call python %SIP_EXTRAS_DIR%\fix-configs.py %SIPCONFIG% %PYQTCONFIG%
:: Overwrite the installed files
move /Y %SIPCONFIG%.fixed %SIPCONFIG%
move /Y %PYQTCONFIG%.fixed %PYQTCONFIG%


::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: release build
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@set PYQT_ROOT_RELEASE=%PYQT_ROOT%\release-build
@call:git-fetch %PYQT_REMOTE_URL% %PYQT_ROOT_RELEASE%
cd %PYQT_ROOT_RELEASE%
:: Generate qt.conf next to the qtdirs.exe so it knows where to find Qt
if not exist release mkdir release
@set QT_CONF_FILE=release\qt.conf
echo [Paths] > %QT_CONF_FILE%
echo Prefix = %QT_ROOT:\=/% >> %QT_CONF_FILE%

:: There is an issue compiling pylupdate. Moc hangs on translator.h in the makefile so we compile it first
::pushd pylupdate
::del moc_translator.cpp 2> nul
::del moc_translator.obj 2> nul
::@call moc.exe -o moc_translator.cpp translator.h
::popd
@call python configure.py --confirm-license --no-designer-plugin
@call jom -j8
@call nmake install

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: debug build
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@set PYQT_ROOT_DEBUG=%BUILD_DIR%\PyQt4\debug-build
@call:git-fetch %PYQT_REMOTE_URL% %PYQT_ROOT_DEBUG%
cd %PYQT_ROOT_DEBUG%
:: Generate qt.conf next to the qtdirs.exe so it knows where to find Qt
if not exist debug mkdir debug
@set QT_CONF_FILE=debug\qt.conf
echo [Paths] > %QT_CONF_FILE%
echo Prefix = %QT_ROOT:\=/% >> %QT_CONF_FILE%

:: There is an issue compiling pylupdate. Moc hangs on translator.h in the makefile so we compile it first
pushd pylupdate
del moc_translator.cpp 2> nul
del moc_translator.obj 2> nul
@call moc.exe -o moc_translator.cpp translator.h
popd
:: -u: Build with debug symbols
@call python configure.py --confirm-license --qsci-api --no-designer-plugin -u --destdir=%PYTHONHOME%\msvc-site-packages\debug
@call jom -j8
@call nmake install

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Fix the sipconfig/pyqtconfig files
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@set SIPCONFIG=%PYTHON_INSTALL_PREFIX%\Lib\site-packages\sipconfig.py
@set PYQTCONFIG=%PYTHON_INSTALL_PREFIX%\Lib\site-packages\PyQt4\pyqtconfig.py
@call python %SIP_EXTRAS_DIR%\fix-configs.py %SIPCONFIG% %PYQTCONFIG%
:: Overwrite the installed files
move /Y %SIPCONFIG%.fixed %SIPCONFIG%
move /Y %PYQTCONFIG%.fixed %PYQTCONFIG%

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Finalize
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call try-pause.cmd
goto:eof

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Functions
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: %1 Remote URL
:: %2 Destination
:git-fetch
if not exist %2 (
  echo Cloning from %1
  call git clone %1 %2
)
goto:eof