:: Create directory if it does not exist
:: @param %1 Name of the directory
if not exist %1 (
  @mkdir %1
)
