@setlocal
:: Extract a tarball file using 7z to a specified directory
:: %1 Archive to extract
:: %2 Destination directory
set _tarball=%1
set _extracted=%_tarball:.tar.gz=%
if not exist %_extracted% (
  echo Extracting %_tarball%
  7z x %_tarball% -o%2 -y
  :: now extract .tar
  7z x %_tarball:.gz=% -y
)
@endlocal