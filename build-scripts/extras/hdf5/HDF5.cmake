###############################################################################
# Cache file for HDF5 under Visual Studio
#
###############################################################################

# General Flags
set (BUILD_SHARED_LIBS ON CACHE BOOL "" FORCE)
set (BUILD_TESTING OFF CACHE BOOL "" FORCE)
set (HDF5_BUILD_EXAMPLES OFF CACHE BOOL "" FORCE)
set (HDF5_ENABLE_PARALLEL OFF CACHE BOOL "" FORCE)
set (HDF5_INSTALL_NO_DEVELOPMENT OFF CACHE BOOL "" FORCE)

# Component flags
set (HDF5_BUILD_TOOLS OFF CACHE BOOL "" FORCE)
set (HDF5_BUILD_CPP_LIB ON CACHE BOOL "" FORCE)
set (HDF5_BUILD_HL_LIB ON CACHE BOOL "" FORCE)
set (HDF5_BUILD_FORTRAN OFF CACHE BOOL "" FORCE)

# Third-party support
set (HDF5_ENABLE_Z_LIB_SUPPORT ON CACHE BOOL "" FORCE)
set (HDF5_ENABLE_SZIP_SUPPORT ON CACHE BOOL "" FORCE)
set (HDF5_ENABLE_SZIP_ENCODING OFF CACHE BOOL "" FORCE)
