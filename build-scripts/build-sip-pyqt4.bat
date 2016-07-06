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
@set QT_ROOT=%INSTALL_ROOT%\lib\qt4
@set PYTHONHOME=%INSTALL_ROOT%\lib\python2.7
@set PATH_NO_QT=%INSTALL_ROOT%\bin;%PYTHONHOME%;D:\Builds\jom;%PATH%
@set PATH=%QT_ROOT%\bin;%PATH_NO_QT%

@set BUILD_DIR=%BUILD_ROOT%\sip-pyqt4
@call try-mkdir %BUILD_DIR%
@cd %BUILD_DIR%

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: SIP
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@set SIP_REMOTE_URL="https://github.com/martyngigg/sip-msvc.git"
@set SIP_ROOT=%BUILD_DIR%\sip-msvc
@call:git-fetch %SIP_REMOTE_URL% %SIP_ROOT%

cd %SIP_ROOT%
@echo Copying wrappython.h to Python include
copy /Y %SIP_ROOT%\contrib\wrappython.h %PYTHON_INSTALL_ROOT%\Include\wrappython.h
:: copy the required mkspec to the required folder
@copy /Y %INSTALL_ROOT%\lib\qt4\mkspecs\%QMAKESPEC%\qmake.conf specs\%QMAKESPEC%
@call python configure.py --platform=%QMAKESPEC%
@call nmake
@call nmake install

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: PyQt4 (release/build). Use two build directoriesas the build is in place
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@set QMAKESPEC=%QT_ROOT%\mkspecs\win32-msvc2015
@set PYQT_REMOTE_URL="https://github.com/martyngigg/pyqt-msvc.git"
@set PYQT_ROOT=%BUILD_DIR%\PyQt4
if not exist %PYQT_ROOT% mkdir %PYQT_ROOT%
cd %PYQT_ROOT%

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
pushd pylupdate
del moc_translator.cpp 2> nul
del moc_translator.obj 2> nul
@call moc.exe -o moc_translator.cpp translator.h
popd
@call python configure.py --confirm-license --qsci-api --no-designer-plugin
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
@set SIPCONFIG=%PYTHON27_INSTALL_ROOT%\Lib\site-packages\sipconfig.py
@set PYQTCONFIG=%PYTHON27_INSTALL_ROOT%\Lib\site-packages\PyQt4\pyqtconfig.py
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