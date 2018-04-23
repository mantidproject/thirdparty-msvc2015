::
:: Sets up the environment required for building under Visual Studio (64-bit) and
:: defines extra functions extra

:: Current version of VS
@set VS_VERSION=140
:: Build for Windows 7
@set SDK_VERSION=8.1
@call "%VS140COMNTOOLS%\..\..\VC\vcvarsall.bat" amd64 %SDK_VERSION%

@set CMAKE_GENERATOR="Visual Studio 14 2015 Win64"
@set QMAKESPEC=win32-msvc2015
:: Number of jobs to run in parallel when using jom
@set NJOBS=8

:: Also put the debug runtime libraries on the PATH
@set VC_RUNTIME_DEBUG=%VS140COMNTOOLS%\..\..\VC\redist\debug_nonredist\x64\Microsoft.VC140.DebugCRT

:: Assume perl, cmake, git, 7-zip is in standard windows location. Perl needs to be before Git to pick up the activestate version
@set PATH=%PATH%;C:\Perl64\bin;C:\Program Files (x86)\CMake\bin;C:\Program Files\Git\usr\bin;C:\Program Files\Git\mingw64\bin;C:\Program Files\7-Zip;%VC_RUNTIME_DEBUG%;%~dp0;

:: Build root - Defaults to [Drive]:\Builds
@set BUILD_ROOT=%~d0\Builds

:: Install root for dependencies (goes via a 'function' to make it absolute)
@call:set-install-root %~dp0..\..

:: This will be used by a lot of scripts
@set PYTHON_INSTALL_PREFIX=%INSTALL_PREFIX%\lib\python2.7
goto:eof

:set-install-root
set INSTALL_PREFIX=%~f1
goto:eof
