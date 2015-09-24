:: Download a file using cURL
:: @param %1 Output name
:: @param %2 URL of resource
if not exist %1 (
  @echo Downloading file %1
  curl -L -o %1 %2
) else (
  @echo Skipping download, %1 already exists
)

