:: Calls pause if we are not running as a child of the build-all script
if "%ALL_BUILD_RUNNING%"=="" (
  pause
)