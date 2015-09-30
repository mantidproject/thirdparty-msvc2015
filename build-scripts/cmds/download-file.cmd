@setlocal
:: Download a file using cURL
:: @param %1 Output name
:: @param %2 URL of resource
:: @param %3 Optional extra arguments
if not exist %1 (
  set destination=%1
  set url=%2
  echo Downloading file %1
  rem cURL manual suggests some bad cgi implementations
  rem fail if the user agent is not Mozilla/4.0
  curl %2 %3 --progress-bar -L --output %1
  ) else (
  echo Skipping download, %1 already exists
)
@endlocal