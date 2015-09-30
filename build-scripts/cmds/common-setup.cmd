::
:: Sets up the environment required for building under Visual Studio (64-bit) and
:: defines extra functions extra

:: Current version of VS
@set VS_VERSION=140
@call "%VS140COMNTOOLS%\..\..\VC\vcvarsall.bat" amd64

:: Assume perl, cmake, git, 7-zip is in standard windows location. Perl needs to be before Git to pick up the activestate version
@set PATH=C:\Perl64\bin;C:\Program Files (x86)\CMake\bin;C:\Program Files (x86)\Git\bin;C:\Program Files\7-Zip;%~dp0;%PATH%

:: Build root - Defaults to [Drive]:\Builds
@set BUILD_ROOT=%~d0\Builds

:: Install root for dependencies (goes via a 'function' to make it absolute)
@call:set-install-root %~dp0..\..

:: This will be used by a lot of scripts
@set PYTHON_INSTALL_ROOT=%INSTALL_ROOT%\lib\python2.7

goto:eof

:set-install-root
set INSTALL_ROOT=%~f1
goto:eof
