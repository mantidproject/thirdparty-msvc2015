@setlocal enableextensions
::
:: Build script for the Qt5 libraries for Mantid.
:: It requires zlib to have been built and installed
:: It also requires the Windows 10 SDK to build the QtWebEngine
::
:: **WARNING**: Building QtWebEngine generates very nested directories that can
:: lead to the builds hitting the maximum allowed number of characters in a file path.
:: Qt is therefore built in the root directory, different to other build scripts
@echo Building Qt5

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Setup environment.
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call %~dp0cmds\common-setup.cmd
:: This will need to be changed depending on the version of the SDK that is installed
@set WINDOWS_SDK_PATH=C:\Program Files (x86)\Windows Kits\10\bin\10.0.15063.0\x64

:: Setup Ruby, currently hard coded to known installation directory
@set RUBY_VARS_CMD=C:\Ruby24-x64\bin\setrbvars.cmd
@if not exist %RUBY_VARS_CMD% (
  echo Unable to find Ruby setup script. Please check the installation directory in this script
  exit /b 1
)
@call %RUBY_VARS_CMD%
:: Require ICU development build for webkit in addition to other includes
@set ICU_PREFIX=D:\Builds\icu4c-57-1\icu
@set INCLUDE=%INSTALL_PREFIX%\include;%ICU_PREFIX%\include;%INCLUDE%
@set LIB=%INSTALL_PREFIX%\lib;%ICU_PREFIX%\lib64;%LIB%
@set PATH=%INSTALL_PREFIX%\bin;%ICU_PREFIX%\bin64;%ICU_PREFIX%\lib64;%WINDOWS_SDK_PATH%;%PATH%

@set QT_EXTRAS_DIR=%~dp0extras\qt5
@set NJOBS=8

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Download and unpack jom. Enables parallel builds on Windows with nmake
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@set JOM_SRC_URL="https://download.qt.io/official_releases/jom/jom_1_1_2.zip"
@set JOM_SRC_PKG=jom_1_1_2.zip
@set JOM_DIR=%BUILD_ROOT%\jom
@call try-mkdir.cmd %JOM_DIR%
@cd /d %JOM_DIR%

@if not exist %JOM_DIR%\jom.exe (
  call download-file.cmd %JOM_SRC_PKG% %JOM_SRC_URL%
  call extract-zip-file.cmd %JOM_SRC_PKG% %CD%
)
@set PATH=%PATH%;%JOM_DIR%;C:\cygwin64\bin

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Download and unpack Qt source
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@set SRC_PKG_URL="http://www.mirrorservice.org/sites/download.qt-project.org/archive/qt/5.8/5.8.0/single/qt-everywhere-opensource-src-5.8.0.7z"
@set SRC_PKG=qt-everywhere-opensource-src-5.8.0.7z
@set BUILD_DIR=D:\Qt5

call try-mkdir.cmd %BUILD_DIR%
cd /d %BUILD_DIR%
call download-file.cmd %SRC_PKG% %SRC_PKG_URL%
:: We rename the unzipped directory to shorten it to avoid problems with file paths that are too long
@set UNZIPPED_DIR=qt-everywhere-opensource-src-5.8.0
@set SHORT_DIR=qt-src-5.8.0
@set QT_ROOT=%BUILD_DIR%\%SHORT_DIR%
if not exist %QT_ROOT% (
  call extract-7z-file.cmd %SRC_PKG% %CD%
  rename %UNZIPPED_DIR% %SHORT_DIR%
)

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Configure & build
:: See https://wiki.qt.io/Building_Qt_5_from_Git
:: Requires python for webengine build
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

@set PATH=%QT_ROOT%\qtbase\bin;%QT_ROOT%\gnuwin32\bin;%PYTHON_INSTALL_PREFIX%;%PATH%
@cd %QT_ROOT%
:: configure. It seems that configure.bat calls a hard exit and so results in the script not progressing any further
:: when it is successful. For this reason we wrap the call in another cmd process so we can wait here until it stops.
@set LOCAL_QT_INSTALL_PREFIX=%INSTALL_PREFIX%\lib\qt5
@set SKIPPED_MODULES=-skip qtconnectivity -skip qtcharts -skip qtwebkit -skip qtwebkit-examples -skip qtpurchasing -skip qtdatavis3d -skip qtsensors -skip qtwinextras -skip qtx11extras -skip qtwayland -skip qtserialport -skip qtlocation -skip qtmacextras -skip qtmultimedia -skip qtquick1 -skip qtscript -skip qtgamepad -skip qtspeech
@set PLATFORM=-platform win32-msvc2015
@set MISC_OPTS=-debug-and-release -opensource -confirm-license -openssl-runtime -opengl desktop -no-dbus -no-plugin-manifests -nomake examples -nomake tests
%COMSPEC% /C "%QT_ROOT%\configure %PLATFORM% %MISC_OPTS% %SKIPPED_MODULES% -prefix %LOCAL_QT_INSTALL_PREFIX%"
if not ERRORLEVEL 0 (
  echo Error running configure
  exit /b %ERRORLEVEL%
)
jom.exe -j%NJOBS%
if not ERRORLEVEL 0 (
  echo Error during compilation
  exit /b %ERRORLEVEL% 
)
nmake install

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Deployment configuration
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Qt builds are by default tied to their build location. A qt.conf file is required to be portable
@set QT_CONF_FILE=%LOCAL_QT_INSTALL_PREFIX%\bin\qt.conf
echo [Paths] > %QT_CONF_FILE%
echo Prefix = .. >> %QT_CONF_FILE%
:: A copy is required in the lib folder too
copy %QT_CONF_FILE% %LOCAL_QT_INSTALL_PREFIX%\lib\qt.conf

:: remove stuff we don't want to keep
::for %%D in (demos doc examples tests) do rmdir /S /Q %QT_INSTALL_PREFIX%\%%D
::for %%F in (q3porting.xml) do del %QT_INSTALL_PREFIX%\%%F

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Finalize
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call try-pause.cmd
goto:eof
