@setlocal
:: High-level command to build and install a cmake configure VS project
:: %1 The build root containing the CMakeCache.txt
:: %2-%9 Projects to build
set build_dir=%1
set project_files=%2 %3 %4 %5 %6 %7 %8 %9
cd %build_dir%
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