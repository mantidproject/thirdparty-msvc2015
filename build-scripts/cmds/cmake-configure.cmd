@setlocal
:: High-level command to configure a cmake project for a specific Visual Studio Version
:: It requires a cache file to set any cmake options and then
:: builds both release & debug configurations
:: %1 The root of the source code. The build will happen in %1\build
:: %2-%9 All other options are passed to cmake
set generator=Visual Studio 14 2015 Win64
set src_root=%1
set build_dir=%~p1build
if not exist %build_dir% mkdir %build_dir%
cd %build_dir%
cmake -G "%generator%" -DCMAKE_SYSTEM_VERSION=%SDK_VERSION% %2 %3 %4 %5 %6 %7 %8 %9 %src_root%
@endlocal
