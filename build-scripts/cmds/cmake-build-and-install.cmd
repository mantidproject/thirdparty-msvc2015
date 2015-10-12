@setlocal
:: High-level command to build a cmake project
:: It requires a cache file to set any cmake options and then
:: builds both release & debug configurations
:: %1 The root of the source code. The build will happen in %1\build
:: %2 Cache file options. Should include -C prefix for each file
:: %3 Install prefix for the library destinations
:: %4-%9 Projects to build
set src_dir=%1
set build_dir=%1\build
set cache_file=%2
echo %cache_file%
set install_prefix=%3
set project_files=%4 %5 %6 %7 %8 %9
call cmake-configure %src_dir% -C "%cache_file%" "-DCMAKE_INSTALL_PREFIX=%install_prefix%"
call build-and-install %build_dir% %project_files%
@endlocal
goto:eof
