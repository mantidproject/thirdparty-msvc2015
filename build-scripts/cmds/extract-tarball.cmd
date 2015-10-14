@setlocal
:: Extract a tarball file using 7z to a specified directory
:: %1 Archive to extract
:: %2 Destination directory
set _tarball=%1
if "%_tarball:~-7%"==".tar.gz" (
  set _tarfile=%_tarball:.gz=%
  set _extracted=%_tarball:.tar.gz=%
) else (
  if "%_tarball:~-8%"==".tar.bz2" (
    set _extracted=%_tarball:.tar.bz2=%
    set _tarfile=%_tarball:.bz2=%
  ) else (
    echo Unspported archive format '%_tarball%'
    exit /b 1
  )
)

if not exist %_extracted% (
  echo Extracting %_tarball%
  7z x %_tarball% -o%2 -y
  :: now extract .tar
  7z x %_tarfile% -o%2 -y
)
@endlocal