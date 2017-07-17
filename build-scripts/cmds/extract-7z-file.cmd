@setlocal
:: Extract a zip file using 7z to a specified directory
:: %1 Archive to extract
:: %2 Destination directory
set infile=%1
set extracted=%infile:.7z=%
if not exist %extracted% (
  echo Extracting %1
  7z x %1 -o%2 -y > nul
)
@endlocal