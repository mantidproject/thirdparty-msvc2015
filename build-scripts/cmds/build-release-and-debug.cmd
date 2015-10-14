@setlocal
:: High-level command to build a set VS projects in both debug and release
:: %1-%9 Paths to projects to build
set project_files=%1 %2 %3 %4 %5 %6 %7 %8 %9
for %%P in (%project_files%) do (
  @call:do-build-release-and-debug %%P
)
@endlocal
goto:eof

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Functions
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: %1 Project file path
:do-build-release-and-debug
msbuild /nologo /p:Configuration=Release %1
msbuild /nologo /p:Configuration=Debug %1
goto:eof