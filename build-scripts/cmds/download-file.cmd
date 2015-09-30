:: Download a file using cURL
:: @param %1 Output name
:: @param %2 URL of resource
:: @param %* Pass all other options to curl 
if not exist %1 (
  echo Downloading file %1
  rem cURL manual suggests some bad cgi implementations
  rem fail if the user agent is not Mozilla/4.0
  curl %* --progress-bar -L --output %1
  ) else (
  echo Skipping download, %1 already exists
)