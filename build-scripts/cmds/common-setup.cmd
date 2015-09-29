::
:: Sets up the environment required for building under Visual Studio (64-bit) and
:: defines extra functions extra

:: Current version of VS
@set VS_VERSION=140
@call "%VS140COMNTOOLS%\..\..\VC\vcvarsall.bat" amd64

:: Assume cmake, git, 7-zip is in standard windows location
@set PATH=C:\Program Files (x86)\CMake\bin;C:\Program Files (x86)\Git\bin;C:\Program Files\7-Zip;%~dp0;%PATH%

:: Build root - Defaults to [Drive]:\Builds
@set BUILD_ROOT=%~d0\Builds

:: Install root for dependencies (goes via a 'function' to make it absolute)
@call:set-install-root %~dp0..\..\
goto:eof

:set-install-root
set INSTALL_ROOT=%~f1
goto:eof
