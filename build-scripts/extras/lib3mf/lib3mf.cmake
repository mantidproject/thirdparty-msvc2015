###############################################################################
# Cache file for Lib3MF under Visual Studio
###############################################################################

# Tests/googletest subfolder missing a cmake file so sidestep problem by turning off tests
set (LIB3MF_TESTS "OFF" CACHE STRING "" FORCE)

set (CMAKE_INSTALL_INCLUDEDIR "include/lib3mf" CACHE STRING "" FORCE)

set (CMAKE_DEBUG_POSTFIX "_d" CACHE STRING "" FORCE)