#----------------------------------------------------------------
# Generated CMake target import file for configuration "Debug".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "szip" for configuration "Debug"
set_property(TARGET szip APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(szip PROPERTIES
  IMPORTED_IMPLIB_DEBUG "${_IMPORT_PREFIX}/lib/szip_D.lib"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/bin/szip_D.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS szip )
list(APPEND _IMPORT_CHECK_FILES_FOR_szip "${_IMPORT_PREFIX}/lib/szip_D.lib" "${_IMPORT_PREFIX}/bin/szip_D.dll" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
