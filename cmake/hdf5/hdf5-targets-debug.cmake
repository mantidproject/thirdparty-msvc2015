#----------------------------------------------------------------
# Generated CMake target import file for configuration "Debug".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "hdf5::hdf5-static" for configuration "Debug"
set_property(TARGET hdf5::hdf5-static APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(hdf5::hdf5-static PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_DEBUG "C"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/lib/libhdf5_D.lib"
  )

list(APPEND _IMPORT_CHECK_TARGETS hdf5::hdf5-static )
list(APPEND _IMPORT_CHECK_FILES_FOR_hdf5::hdf5-static "${_IMPORT_PREFIX}/lib/libhdf5_D.lib" )

# Import target "hdf5::hdf5-shared" for configuration "Debug"
set_property(TARGET hdf5::hdf5-shared APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(hdf5::hdf5-shared PROPERTIES
  IMPORTED_IMPLIB_DEBUG "${_IMPORT_PREFIX}/lib/hdf5_D.lib"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/bin/hdf5_D.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS hdf5::hdf5-shared )
list(APPEND _IMPORT_CHECK_FILES_FOR_hdf5::hdf5-shared "${_IMPORT_PREFIX}/lib/hdf5_D.lib" "${_IMPORT_PREFIX}/bin/hdf5_D.dll" )

# Import target "hdf5::hdf5_hl-static" for configuration "Debug"
set_property(TARGET hdf5::hdf5_hl-static APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(hdf5::hdf5_hl-static PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_DEBUG "C"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/lib/libhdf5_hl_D.lib"
  )

list(APPEND _IMPORT_CHECK_TARGETS hdf5::hdf5_hl-static )
list(APPEND _IMPORT_CHECK_FILES_FOR_hdf5::hdf5_hl-static "${_IMPORT_PREFIX}/lib/libhdf5_hl_D.lib" )

# Import target "hdf5::hdf5_hl-shared" for configuration "Debug"
set_property(TARGET hdf5::hdf5_hl-shared APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(hdf5::hdf5_hl-shared PROPERTIES
  IMPORTED_IMPLIB_DEBUG "${_IMPORT_PREFIX}/lib/hdf5_hl_D.lib"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/bin/hdf5_hl_D.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS hdf5::hdf5_hl-shared )
list(APPEND _IMPORT_CHECK_FILES_FOR_hdf5::hdf5_hl-shared "${_IMPORT_PREFIX}/lib/hdf5_hl_D.lib" "${_IMPORT_PREFIX}/bin/hdf5_hl_D.dll" )

# Import target "hdf5::hdf5_cpp-static" for configuration "Debug"
set_property(TARGET hdf5::hdf5_cpp-static APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(hdf5::hdf5_cpp-static PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_DEBUG "CXX"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/lib/libhdf5_cpp_D.lib"
  )

list(APPEND _IMPORT_CHECK_TARGETS hdf5::hdf5_cpp-static )
list(APPEND _IMPORT_CHECK_FILES_FOR_hdf5::hdf5_cpp-static "${_IMPORT_PREFIX}/lib/libhdf5_cpp_D.lib" )

# Import target "hdf5::hdf5_cpp-shared" for configuration "Debug"
set_property(TARGET hdf5::hdf5_cpp-shared APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(hdf5::hdf5_cpp-shared PROPERTIES
  IMPORTED_IMPLIB_DEBUG "${_IMPORT_PREFIX}/lib/hdf5_cpp_D.lib"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/bin/hdf5_cpp_D.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS hdf5::hdf5_cpp-shared )
list(APPEND _IMPORT_CHECK_FILES_FOR_hdf5::hdf5_cpp-shared "${_IMPORT_PREFIX}/lib/hdf5_cpp_D.lib" "${_IMPORT_PREFIX}/bin/hdf5_cpp_D.dll" )

# Import target "hdf5::hdf5_hl_cpp-static" for configuration "Debug"
set_property(TARGET hdf5::hdf5_hl_cpp-static APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(hdf5::hdf5_hl_cpp-static PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_DEBUG "CXX"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/lib/libhdf5_hl_cpp_D.lib"
  )

list(APPEND _IMPORT_CHECK_TARGETS hdf5::hdf5_hl_cpp-static )
list(APPEND _IMPORT_CHECK_FILES_FOR_hdf5::hdf5_hl_cpp-static "${_IMPORT_PREFIX}/lib/libhdf5_hl_cpp_D.lib" )

# Import target "hdf5::hdf5_hl_cpp-shared" for configuration "Debug"
set_property(TARGET hdf5::hdf5_hl_cpp-shared APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(hdf5::hdf5_hl_cpp-shared PROPERTIES
  IMPORTED_IMPLIB_DEBUG "${_IMPORT_PREFIX}/lib/hdf5_hl_cpp_D.lib"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/bin/hdf5_hl_cpp_D.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS hdf5::hdf5_hl_cpp-shared )
list(APPEND _IMPORT_CHECK_FILES_FOR_hdf5::hdf5_hl_cpp-shared "${_IMPORT_PREFIX}/lib/hdf5_hl_cpp_D.lib" "${_IMPORT_PREFIX}/bin/hdf5_hl_cpp_D.dll" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
