@setlocal enableextensions
::
:: Build script for scipp
::
@echo Building SciPP
@echo OFF

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Setup environment. Important to ensure correct detection of environment
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call %~dp0cmds\common-setup.cmd
@set SCIPP_EXTRAS_DIR=%~dp0extras\scipp

@cd %BUILD_ROOT%

if not exist "%BUILD_ROOT%\scipp" (
  @git clone https://github.com/scipp/scipp
  @cd scipp
  @git submodule init
  @git submodule update
  patch -p0 --input=%SCIPP_EXTRAS_DIR%\runtime_config.py.patch --backup
  @cd ..
  mkdir scipp\build
  mkdir scipp\install
)

@cd scipp/build

%INSTALL_PREFIX%\lib\python3.8\python.exe -m pip install appdirs python-configuration

cmake .. -G"Visual Studio 16 2019" -A x64 -DBENCHMARK_DOWNLOAD_DEPENDENCIES=OFF -DBENCHMARK_ENABLE_INSTALL=OFF -DBENCHMARK_ENABLE_LTO=OFF -DBENCHMARK_ENABLE_GTEST_TESTS=OFF -DBENCHMARK_ENABLE_TESTING=OFF -DBENCHMARK_ENABLE_LIBCXX=OFF -DBENCHMARK_ENABLE_EXCEPTIPONS=OFF -DCMAKE_INSTALL_PREFIX=../install -DWITH_CXX_TEST=OFF -DCMAKE_INTERPROCEDURAL_OPTIMIZATION=ON -DDYNAMIC_LIB=OFF -DPYTHON_EXECUTABLE=%INSTALL_PREFIX%\lib\python3.8\python.exe -DCMAKE_BUILD_TYPE=Release

msbuild /nologo /p:Configuration=Release /p:Platform=x64 ALL_BUILD.vcxproj
msbuild /nologo /p:Configuration=Release /p:Platform=x64 INSTALL.vcxproj

if not exist "%INSTALL_PREFIX%\lib\python3.8\Lib\scipp" (
mkdir %INSTALL_PREFIX%\lib\python3.8\Lib\scipp
)
xcopy /E /Y ..\install\scipp\* %INSTALL_PREFIX%\lib\python3.8\Lib\scipp

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Finalize
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call try-pause.cmd