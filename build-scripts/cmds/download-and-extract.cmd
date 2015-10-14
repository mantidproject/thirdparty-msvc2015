@setlocal
:: High-level command to download and extract an archive file
:: The destination directories will be created as required
:: %1 Local output destination to download archive
:: %2 Source URL
set output_path=%1
set output_dir=%~p1
set src_location=%2

if not exist %output_dir% mkdir %output_dir%
call download-file.cmd %output_path% %src_location%
if "%output_path:~-3%"=="zip" (
  call extract-zip-file.cmd %output_path% %output_dir%
) else (
  call extract-tarball.cmd %output_path% %output_dir%
)
@endlocal