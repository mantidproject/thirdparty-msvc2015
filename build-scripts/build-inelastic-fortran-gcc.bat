@setlocal enableextensions
::
:: Build script for Inelastic Python modules
:: It requires the Intel Composer XE Fortran compiler for Windows
::
:: NOTE: The built .pyd modules must be copied to the repository by hand
@echo Building Inelastic Python modules

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Setup environment. Do not use the common set up script as we use
:: the intel fortran compiler plus MSVC 9
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@set PATH=C:\Perl64\bin;C:\Program Files (x86)\CMake\bin;C:\Program Files (x86)\Git\bin;C:\Program Files\7-Zip;%~dp0\cmds;C:\MinGW64\bin;%PATH%

:: Install root for dependencies (goes via a 'function' to make it absolute)
@call:set-python-root %~dp0..\
@set PYTHON_EXE=%PYTHON_INSTALL_PREFIX%\python.exe
@set F2PY_SCRIPT=%PYTHON_INSTALL_PREFIX%\Scripts\f2py.py

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Source
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@set REMOTE_URL="https://github.com/mantidproject/3rdpartysources.git"
@set BUILD_ROOT=%~d0\Builds\fortran-modules
if not exist %BUILD_ROOT% mkdir %BUILD_ROOT%
cd %BUILD_ROOT%
@call:git-fetch %REMOTE_URL% 3rdpartysources
cd 3rdpartysources\Fortran\Indirect

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: AbsCorrection
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
cd AbsCorrection
@call:compile-module cylabs_win64 cylabs cylabs_main.f90 cylabs_subs.f90
@call:compile-module muscat_win64 muscat muscat_data_main.f90 muscat_data.f90 muscat_geom.f90

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Bayes
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
cd ..\Bayes
@call:compile-module QLdata_win64 qldata QLdata_main.f90 QLdata_subs.f90 ^
  Bayes.f90 Four.f90 Util.f90
@call:compile-module QLres_win64 qlres QLres_main.f90 QLres_subs.f90 BlrRes.f90 ^
  Bayes.f90 Four.f90 Util.f90
@call:compile-module QLse_win64 qlstexp QLse_main.f90 QLse_subs.f90 BlrRes.f90 ^
  Bayes.f90 Four.f90 Util.f90 Simopt.f90
@call:compile-module Quest_win64 quest Quest_main.f90 Quest_subs.f90 BlrRes.f90 ^
  Bayes.f90 Four.f90 Util.f90 Simopt.f90
@call:compile-module ResNorm_win64 resnorm ResNorm_main.f90 ResNorm_subs.f90 ^
  BlrRes.f90 Bayes.f90 Four.f90 Util.f90

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Finalize
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call try-pause.cmd
goto:eof

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Functions
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:set-python-root
set PYTHON_INSTALL_PREFIX=%~f1\lib\python2.7
goto:eof

:: %1 Remote URL
:: %2 Destination
:git-fetch
if not exist %2 (
  call git clone %1 %2
)
goto:eof

:: %1 Output module name
:: %2 routine
:: %3-%9 source files
:compile-module
setlocal
set modname=%1
set routine=%2
%PYTHON_EXE% %F2PY_SCRIPT% --verbose -c --fcompiler=gnu95 --compiler=mingw32 ^
  -m %modname% %3 only: %routine% : %4 %5 %6 %7 %8 %9 
endlocal
goto:eof

