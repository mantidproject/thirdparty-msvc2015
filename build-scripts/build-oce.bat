@setlocal enableextensions
::
:: Build script OCE - community edition of opencascade that is used
:: on the other OSs. Only a subset of the libraries are used
@echo Building OCE

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Setup environment. Important to ensure correct detection of environment
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call %~dp0cmds\common-setup.cmd
@set OCE_EXTRAS_DIR=%~dp0extras\oce

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Download and unpack source.
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@set SRC_PKG_URL="https://github.com/tpaviot/oce/archive/OCE-0.17.tar.gz"
@set BUILD_DIR=%BUILD_ROOT%\oce
@set SRC_PKG=OCE-0.17.tar.gz
@set SRC_ROOT=%BUILD_DIR%\oce-OCE-0.17
if not exist %SRC_ROOT% call download-and-extract.cmd %BUILD_DIR%\%SRC_PKG% %SRC_PKG_URL%

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Patch
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
echo Patching source for Visual Studio
cd %SRC_ROOT%
@if not exist src\Interface\Interface_STAT.cxx.orig patch -p1 --input=%OCE_EXTRAS_DIR%\msvc-2015-fixes.patch --backup

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Build
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: TKBO,TKBRep,TKernel,TKG2d,TKG3d,TKGeomAlgo,TKGeomBase,TKMath,TKPrim
::,TKTopAlgo
@call cmake-configure %SRC_ROOT%\ -C "%OCE_EXTRAS_DIR%\oce.cmake" ^
 "-DCMAKE_INSTALL_PREFIX=%INSTALL_ROOT%" "-DOCE_INSTALL_PREFIX=%INSTALL_ROOT%"
cd %SRC_ROOT%\build\adm\cmake

:: Requires 2 calls to build all as the script can only take 8 project arguments
set PROJECTS=TKBO\TKBO.vcxproj TKBRep\TKBRep.vcxproj TKernel\TKernel.vcxproj ^
 TKG2d\TKG2d.vcxproj TKG3d\TKG3d.vcxproj
@call build-and-install %PROJECTS%
set PROJECTS=TKGeomAlgo\TKGeomAlgo.vcxproj TKGeomBase\TKGeomBase.vcxproj ^
 TKMath\TKMath.vcxproj TKMesh\TKMesh.vcxproj TKPrim\TKPrim.vcxproj TKTopAlgo\TKTopAlgo.vcxproj
@call build-and-install %PROJECTS%
cd %SRC_ROOT%\build
@call build-release-and-debug INSTALL.vcxproj

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Post-install
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: install target creates a INSTALL_ROOT\Win64\{bin\lib} directory. We don't want this
move /Y %INSTALL_ROOT%\Win64\bin\* %INSTALL_ROOT%\bin\
move /Y %INSTALL_ROOT%\Win64\lib\* %INSTALL_ROOT%\lib\
rmdir /S /Q %INSTALL_ROOT%\Win64\

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Finalize
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call try-pause.cmd
goto:eof
