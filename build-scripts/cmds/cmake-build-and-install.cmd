@setlocal
:: High-level command to build a cmake project
:: It requires a cache file to set any cmake options and then
:: builds both release & debug configurations
:: %1 The root of the source code. The build will happen in %1\build
:: %2 Path to the cache file to setup the cmake options
:: %3 Install prefix for the library destinations
:: %4-%9 Projects to build
set build_dir=%~p1build
set cache_file=%2
set install_prefix=%3
set project_files=%4 %5 %6 %7 %8 %9
if not exist %build_dir% mkdir %build_dir%
cd %build_dir%
cmake -G"Visual Studio 14 2015 Win64" -C %cache_file% -DCMAKE_INSTALL_PREFIX=%install_prefix% ..
for %%P in (%project_files%) do (
  @call:build-release-and-debug %%P
  @call:build-release-and-debug INSTALL.vcxproj
)
@endlocal
goto:eof

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Functions
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: %1 Project file path
:build-release-and-debug
msbuild /nologo /p:Configuration=Release %1
msbuild /nologo /p:Configuration=Debug %1
goto:eof