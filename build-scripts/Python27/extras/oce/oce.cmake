###############################################################################
# Cache file for OCE under Visual Studio
###############################################################################

# General Flags
set (BUILD_SHARED_LIBS ON CACHE BOOL "" FORCE)
set (OCE_COPY_HEADERS_BUILD ON CACHE BOOL "" FORCE)
# We don't have tbb
set (OCE_MULTITHREAD_LIBRARY "" CACHE STRING "" FORCE)
set (OCE_TESTING OFF CACHE BOOL "" FORCE)
set (OCE_COVERAGE OFF CACHE BOOL "" FORCE)

# Components
set (OCE_DRAW OFF CACHE BOOL "" FORCE)
set (OCE_DATAEXCHANGE OFF CACHE BOOL "" FORCE)
set (OCE_OCAF OFF CACHE BOOL "" FORCE)
set (OCE_VISUALISATION OFF CACHE BOOL "" FORCE)
