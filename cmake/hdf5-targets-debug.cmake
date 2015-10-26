#----------------------------------------------------------------
# Generated CMake target import file for configuration "Debug".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "hdf5" for configuration "Debug"
set_property(TARGET hdf5 APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(hdf5 PROPERTIES
  IMPORTED_IMPLIB_DEBUG "${_IMPORT_PREFIX}/lib/hdf5_D.lib"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/bin/hdf5_D.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS hdf5 )
list(APPEND _IMPORT_CHECK_FILES_FOR_hdf5 "${_IMPORT_PREFIX}/lib/hdf5_D.lib" "${_IMPORT_PREFIX}/bin/hdf5_D.dll" )

# Import target "hdf5_hl" for configuration "Debug"
set_property(TARGET hdf5_hl APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(hdf5_hl PROPERTIES
  IMPORTED_IMPLIB_DEBUG "${_IMPORT_PREFIX}/lib/hdf5_hl_D.lib"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/bin/hdf5_hl_D.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS hdf5_hl )
list(APPEND _IMPORT_CHECK_FILES_FOR_hdf5_hl "${_IMPORT_PREFIX}/lib/hdf5_hl_D.lib" "${_IMPORT_PREFIX}/bin/hdf5_hl_D.dll" )

# Import target "hdf5_cpp" for configuration "Debug"
set_property(TARGET hdf5_cpp APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(hdf5_cpp PROPERTIES
  IMPORTED_IMPLIB_DEBUG "${_IMPORT_PREFIX}/lib/hdf5_cpp_D.lib"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/bin/hdf5_cpp_D.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS hdf5_cpp )
list(APPEND _IMPORT_CHECK_FILES_FOR_hdf5_cpp "${_IMPORT_PREFIX}/lib/hdf5_cpp_D.lib" "${_IMPORT_PREFIX}/bin/hdf5_cpp_D.dll" )

# Import target "hdf5_hl_cpp" for configuration "Debug"
set_property(TARGET hdf5_hl_cpp APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(hdf5_hl_cpp PROPERTIES
  IMPORTED_IMPLIB_DEBUG "${_IMPORT_PREFIX}/lib/hdf5_hl_cpp_D.lib"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/bin/hdf5_hl_cpp_D.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS hdf5_hl_cpp )
list(APPEND _IMPORT_CHECK_FILES_FOR_hdf5_hl_cpp "${_IMPORT_PREFIX}/lib/hdf5_hl_cpp_D.lib" "${_IMPORT_PREFIX}/bin/hdf5_hl_cpp_D.dll" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
