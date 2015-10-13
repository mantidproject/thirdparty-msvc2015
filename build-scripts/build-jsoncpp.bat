@setlocal enableextensions
::
:: Build script JsonCPP
@echo Building JSONCpp

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Setup environment. Important to ensure correct detection of environment
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call %~dp0cmds\common-setup.cmd
@set JSONCPP_EXTRAS_DIR=%~dp0extras\jsoncpp

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Download and unpack source.
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@set SRC_PKG_URL="https://github.com/open-source-parsers/jsoncpp/archive/0.10.5.zip"
@set BUILD_DIR=%BUILD_ROOT%\jsoncpp
@set SRC_PKG=0.10.5.zip
@set SRC_ROOT=%BUILD_DIR%\jsoncpp-0.10.5
@if not exist %SRC_ROOT% call download-and-extract.cmd %BUILD_DIR%\%SRC_PKG% %SRC_PKG_URL%

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Patch
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Build
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call cmake-build-and-install %SRC_ROOT%\ %JSONCPP_EXTRAS_DIR%\jsoncpp.cmake %INSTALL_ROOT% src\lib_json\jsoncpp_lib.vcxproj

:: TKBO,TKBRep,TKernel,TKG2d,TKG3d,TKGeomAlgo,TKGeomBase,TKMath,TKPrim
::,TKTopAlgo
::@call cmake-configure %SRC_ROOT%\ -C "%OCE_EXTRAS_DIR%\oce.cmake" ^
:: "-DCMAKE_INSTALL_PREFIX=%INSTALL_ROOT%" "-DOCE_INSTALL_PREFIX=%INSTALL_ROOT%"
::cd %SRC_ROOT%\build\adm\cmake

:: Requires 2 calls to build all as the script can only take 8 project arguments
::set PROJECTS=TKBO\TKBO.vcxproj TKBRep\TKBRep.vcxproj TKernel\TKernel.vcxproj ^
:: TKG2d\TKG2d.vcxproj TKG3d\TKG3d.vcxproj
::@call build-and-install %PROJECTS%
::set PROJECTS=TKGeomAlgo\TKGeomAlgo.vcxproj TKGeomBase\TKGeomBase.vcxproj ^
:: TKMath\TKMath.vcxproj TKMesh\TKMesh.vcxproj TKPrim\TKPrim.vcxproj TKTopAlgo\TKTopAlgo.vcxproj
::@call build-and-install %PROJECTS%


::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Finalize
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call try-pause.cmd
goto:eof
