#----------------------------------------------------------------
# Generated CMake target import file for configuration "Debug".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "szip-static" for configuration "Debug"
set_property(TARGET szip-static APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(szip-static PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_DEBUG "C"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/lib/libszip_D.lib"
  )

list(APPEND _IMPORT_CHECK_TARGETS szip-static )
list(APPEND _IMPORT_CHECK_FILES_FOR_szip-static "${_IMPORT_PREFIX}/lib/libszip_D.lib" )

# Import target "szip-shared" for configuration "Debug"
set_property(TARGET szip-shared APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(szip-shared PROPERTIES
  IMPORTED_IMPLIB_DEBUG "${_IMPORT_PREFIX}/lib/szip_D.lib"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/bin/szip_D.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS szip-shared )
list(APPEND _IMPORT_CHECK_FILES_FOR_szip-shared "${_IMPORT_PREFIX}/lib/szip_D.lib" "${_IMPORT_PREFIX}/bin/szip_D.dll" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
