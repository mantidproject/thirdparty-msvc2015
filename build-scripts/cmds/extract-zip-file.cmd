@setlocal
:: Extract a zip file using 7z to a specified directory
:: %1 Archive to extract
:: %2 Destination directory
set _zipfile=%1
if not exist %_zipfile:.zip=% (
  echo Extracting %1
  7z x %1 -o%2 -y
)
@endlocal