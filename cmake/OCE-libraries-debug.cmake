#----------------------------------------------------------------
# Generated CMake target import file for configuration "Debug".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "TKernel" for configuration "Debug"
set_property(TARGET TKernel APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(TKernel PROPERTIES
  IMPORTED_IMPLIB_DEBUG "${_IMPORT_PREFIX}/Win64/lib/TKerneld.lib"
  IMPORTED_LINK_INTERFACE_LIBRARIES_DEBUG "ws2_32;advapi32;gdi32;user32;kernel32;psapi"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/Win64/bin/TKerneld.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS TKernel )
list(APPEND _IMPORT_CHECK_FILES_FOR_TKernel "${_IMPORT_PREFIX}/Win64/lib/TKerneld.lib" "${_IMPORT_PREFIX}/Win64/bin/TKerneld.dll" )

# Import target "TKMath" for configuration "Debug"
set_property(TARGET TKMath APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(TKMath PROPERTIES
  IMPORTED_IMPLIB_DEBUG "${_IMPORT_PREFIX}/Win64/lib/TKMathd.lib"
  IMPORTED_LINK_INTERFACE_LIBRARIES_DEBUG "TKernel"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/Win64/bin/TKMathd.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS TKMath )
list(APPEND _IMPORT_CHECK_FILES_FOR_TKMath "${_IMPORT_PREFIX}/Win64/lib/TKMathd.lib" "${_IMPORT_PREFIX}/Win64/bin/TKMathd.dll" )

# Import target "TKG2d" for configuration "Debug"
set_property(TARGET TKG2d APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(TKG2d PROPERTIES
  IMPORTED_IMPLIB_DEBUG "${_IMPORT_PREFIX}/Win64/lib/TKG2dd.lib"
  IMPORTED_LINK_INTERFACE_LIBRARIES_DEBUG "TKernel;TKMath"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/Win64/bin/TKG2dd.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS TKG2d )
list(APPEND _IMPORT_CHECK_FILES_FOR_TKG2d "${_IMPORT_PREFIX}/Win64/lib/TKG2dd.lib" "${_IMPORT_PREFIX}/Win64/bin/TKG2dd.dll" )

# Import target "TKG3d" for configuration "Debug"
set_property(TARGET TKG3d APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(TKG3d PROPERTIES
  IMPORTED_IMPLIB_DEBUG "${_IMPORT_PREFIX}/Win64/lib/TKG3dd.lib"
  IMPORTED_LINK_INTERFACE_LIBRARIES_DEBUG "TKMath;TKernel;TKG2d"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/Win64/bin/TKG3dd.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS TKG3d )
list(APPEND _IMPORT_CHECK_FILES_FOR_TKG3d "${_IMPORT_PREFIX}/Win64/lib/TKG3dd.lib" "${_IMPORT_PREFIX}/Win64/bin/TKG3dd.dll" )

# Import target "TKGeomBase" for configuration "Debug"
set_property(TARGET TKGeomBase APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(TKGeomBase PROPERTIES
  IMPORTED_IMPLIB_DEBUG "${_IMPORT_PREFIX}/Win64/lib/TKGeomBased.lib"
  IMPORTED_LINK_INTERFACE_LIBRARIES_DEBUG "TKernel;TKMath;TKG2d;TKG3d"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/Win64/bin/TKGeomBased.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS TKGeomBase )
list(APPEND _IMPORT_CHECK_FILES_FOR_TKGeomBase "${_IMPORT_PREFIX}/Win64/lib/TKGeomBased.lib" "${_IMPORT_PREFIX}/Win64/bin/TKGeomBased.dll" )

# Import target "TKBRep" for configuration "Debug"
set_property(TARGET TKBRep APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(TKBRep PROPERTIES
  IMPORTED_IMPLIB_DEBUG "${_IMPORT_PREFIX}/Win64/lib/TKBRepd.lib"
  IMPORTED_LINK_INTERFACE_LIBRARIES_DEBUG "TKMath;TKernel;TKG2d;TKG3d;TKGeomBase"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/Win64/bin/TKBRepd.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS TKBRep )
list(APPEND _IMPORT_CHECK_FILES_FOR_TKBRep "${_IMPORT_PREFIX}/Win64/lib/TKBRepd.lib" "${_IMPORT_PREFIX}/Win64/bin/TKBRepd.dll" )

# Import target "TKGeomAlgo" for configuration "Debug"
set_property(TARGET TKGeomAlgo APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(TKGeomAlgo PROPERTIES
  IMPORTED_IMPLIB_DEBUG "${_IMPORT_PREFIX}/Win64/lib/TKGeomAlgod.lib"
  IMPORTED_LINK_INTERFACE_LIBRARIES_DEBUG "TKernel;TKMath;TKG3d;TKG2d;TKGeomBase;TKBRep"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/Win64/bin/TKGeomAlgod.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS TKGeomAlgo )
list(APPEND _IMPORT_CHECK_FILES_FOR_TKGeomAlgo "${_IMPORT_PREFIX}/Win64/lib/TKGeomAlgod.lib" "${_IMPORT_PREFIX}/Win64/bin/TKGeomAlgod.dll" )

# Import target "TKTopAlgo" for configuration "Debug"
set_property(TARGET TKTopAlgo APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(TKTopAlgo PROPERTIES
  IMPORTED_IMPLIB_DEBUG "${_IMPORT_PREFIX}/Win64/lib/TKTopAlgod.lib"
  IMPORTED_LINK_INTERFACE_LIBRARIES_DEBUG "TKMath;TKernel;TKG2d;TKG3d;TKGeomBase;TKBRep;TKGeomAlgo"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/Win64/bin/TKTopAlgod.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS TKTopAlgo )
list(APPEND _IMPORT_CHECK_FILES_FOR_TKTopAlgo "${_IMPORT_PREFIX}/Win64/lib/TKTopAlgod.lib" "${_IMPORT_PREFIX}/Win64/bin/TKTopAlgod.dll" )

# Import target "TKPrim" for configuration "Debug"
set_property(TARGET TKPrim APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(TKPrim PROPERTIES
  IMPORTED_IMPLIB_DEBUG "${_IMPORT_PREFIX}/Win64/lib/TKPrimd.lib"
  IMPORTED_LINK_INTERFACE_LIBRARIES_DEBUG "TKBRep;TKernel;TKMath;TKG2d;TKGeomBase;TKG3d;TKTopAlgo"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/Win64/bin/TKPrimd.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS TKPrim )
list(APPEND _IMPORT_CHECK_FILES_FOR_TKPrim "${_IMPORT_PREFIX}/Win64/lib/TKPrimd.lib" "${_IMPORT_PREFIX}/Win64/bin/TKPrimd.dll" )

# Import target "TKBO" for configuration "Debug"
set_property(TARGET TKBO APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(TKBO PROPERTIES
  IMPORTED_IMPLIB_DEBUG "${_IMPORT_PREFIX}/Win64/lib/TKBOd.lib"
  IMPORTED_LINK_INTERFACE_LIBRARIES_DEBUG "TKBRep;TKTopAlgo;TKMath;TKernel;TKG2d;TKG3d;TKGeomAlgo;TKGeomBase;TKPrim"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/Win64/bin/TKBOd.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS TKBO )
list(APPEND _IMPORT_CHECK_FILES_FOR_TKBO "${_IMPORT_PREFIX}/Win64/lib/TKBOd.lib" "${_IMPORT_PREFIX}/Win64/bin/TKBOd.dll" )

# Import target "TKHLR" for configuration "Debug"
set_property(TARGET TKHLR APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(TKHLR PROPERTIES
  IMPORTED_IMPLIB_DEBUG "${_IMPORT_PREFIX}/Win64/lib/TKHLRd.lib"
  IMPORTED_LINK_INTERFACE_LIBRARIES_DEBUG "TKBRep;TKernel;TKMath;TKGeomBase;TKG2d;TKG3d;TKGeomAlgo;TKTopAlgo"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/Win64/bin/TKHLRd.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS TKHLR )
list(APPEND _IMPORT_CHECK_FILES_FOR_TKHLR "${_IMPORT_PREFIX}/Win64/lib/TKHLRd.lib" "${_IMPORT_PREFIX}/Win64/bin/TKHLRd.dll" )

# Import target "TKMesh" for configuration "Debug"
set_property(TARGET TKMesh APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(TKMesh PROPERTIES
  IMPORTED_IMPLIB_DEBUG "${_IMPORT_PREFIX}/Win64/lib/TKMeshd.lib"
  IMPORTED_LINK_INTERFACE_LIBRARIES_DEBUG "TKBRep;TKMath;TKernel;TKG2d;TKG3d;TKGeomBase;TKTopAlgo;TKGeomAlgo"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/Win64/bin/TKMeshd.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS TKMesh )
list(APPEND _IMPORT_CHECK_FILES_FOR_TKMesh "${_IMPORT_PREFIX}/Win64/lib/TKMeshd.lib" "${_IMPORT_PREFIX}/Win64/bin/TKMeshd.dll" )

# Import target "TKShHealing" for configuration "Debug"
set_property(TARGET TKShHealing APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(TKShHealing PROPERTIES
  IMPORTED_IMPLIB_DEBUG "${_IMPORT_PREFIX}/Win64/lib/TKShHealingd.lib"
  IMPORTED_LINK_INTERFACE_LIBRARIES_DEBUG "TKBRep;TKernel;TKMath;TKG2d;TKTopAlgo;TKG3d;TKGeomBase;TKGeomAlgo;ws2_32"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/Win64/bin/TKShHealingd.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS TKShHealing )
list(APPEND _IMPORT_CHECK_FILES_FOR_TKShHealing "${_IMPORT_PREFIX}/Win64/lib/TKShHealingd.lib" "${_IMPORT_PREFIX}/Win64/bin/TKShHealingd.dll" )

# Import target "TKXMesh" for configuration "Debug"
set_property(TARGET TKXMesh APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(TKXMesh PROPERTIES
  IMPORTED_IMPLIB_DEBUG "${_IMPORT_PREFIX}/Win64/lib/TKXMeshd.lib"
  IMPORTED_LINK_INTERFACE_LIBRARIES_DEBUG "TKBRep;TKMath;TKernel;TKG2d;TKMesh"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/Win64/bin/TKXMeshd.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS TKXMesh )
list(APPEND _IMPORT_CHECK_FILES_FOR_TKXMesh "${_IMPORT_PREFIX}/Win64/lib/TKXMeshd.lib" "${_IMPORT_PREFIX}/Win64/bin/TKXMeshd.dll" )

# Import target "TKBool" for configuration "Debug"
set_property(TARGET TKBool APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(TKBool PROPERTIES
  IMPORTED_IMPLIB_DEBUG "${_IMPORT_PREFIX}/Win64/lib/TKBoold.lib"
  IMPORTED_LINK_INTERFACE_LIBRARIES_DEBUG "TKBRep;TKTopAlgo;TKMath;TKernel;TKPrim;TKG2d;TKG3d;TKShHealing;TKGeomBase;TKGeomAlgo;TKBO"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/Win64/bin/TKBoold.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS TKBool )
list(APPEND _IMPORT_CHECK_FILES_FOR_TKBool "${_IMPORT_PREFIX}/Win64/lib/TKBoold.lib" "${_IMPORT_PREFIX}/Win64/bin/TKBoold.dll" )

# Import target "TKFillet" for configuration "Debug"
set_property(TARGET TKFillet APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(TKFillet PROPERTIES
  IMPORTED_IMPLIB_DEBUG "${_IMPORT_PREFIX}/Win64/lib/TKFilletd.lib"
  IMPORTED_LINK_INTERFACE_LIBRARIES_DEBUG "TKBRep;TKernel;TKMath;TKGeomBase;TKGeomAlgo;TKG2d;TKTopAlgo;TKG3d;TKBool;TKShHealing"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/Win64/bin/TKFilletd.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS TKFillet )
list(APPEND _IMPORT_CHECK_FILES_FOR_TKFillet "${_IMPORT_PREFIX}/Win64/lib/TKFilletd.lib" "${_IMPORT_PREFIX}/Win64/bin/TKFilletd.dll" )

# Import target "TKFeat" for configuration "Debug"
set_property(TARGET TKFeat APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(TKFeat PROPERTIES
  IMPORTED_IMPLIB_DEBUG "${_IMPORT_PREFIX}/Win64/lib/TKFeatd.lib"
  IMPORTED_LINK_INTERFACE_LIBRARIES_DEBUG "TKBRep;TKTopAlgo;TKGeomAlgo;TKMath;TKernel;TKGeomBase;TKPrim;TKG2d;TKBO;TKG3d;TKBool"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/Win64/bin/TKFeatd.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS TKFeat )
list(APPEND _IMPORT_CHECK_FILES_FOR_TKFeat "${_IMPORT_PREFIX}/Win64/lib/TKFeatd.lib" "${_IMPORT_PREFIX}/Win64/bin/TKFeatd.dll" )

# Import target "TKOffset" for configuration "Debug"
set_property(TARGET TKOffset APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(TKOffset PROPERTIES
  IMPORTED_IMPLIB_DEBUG "${_IMPORT_PREFIX}/Win64/lib/TKOffsetd.lib"
  IMPORTED_LINK_INTERFACE_LIBRARIES_DEBUG "TKFillet;TKBRep;TKTopAlgo;TKMath;TKernel;TKGeomBase;TKG2d;TKG3d;TKGeomAlgo;TKShHealing;TKBO;TKPrim;TKBool"
  IMPORTED_LOCATION_DEBUG "${_IMPORT_PREFIX}/Win64/bin/TKOffsetd.dll"
  )

list(APPEND _IMPORT_CHECK_TARGETS TKOffset )
list(APPEND _IMPORT_CHECK_FILES_FOR_TKOffset "${_IMPORT_PREFIX}/Win64/lib/TKOffsetd.lib" "${_IMPORT_PREFIX}/Win64/bin/TKOffsetd.dll" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
