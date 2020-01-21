"""
Attempts to detect if this bundle is run from a development build and updates the DLL search path
to find all thirdparty libraries. A packaged bundle has all DLLs in the main bin directory
and requires no action.

This bundle is assumed to only be used on Windows. This trick is based on the similar find_qt functionality
in PyQt5.__init__.
"""

def find_thirdparty():
    import os, sys

    # Look for a "marker" DLL that indicates that this looks like the layout in a user package.
    py_exe_dir = os.path.normpath(os.path.dirname(os.__file__) + '\\..')
    marker_dll = '\\zlib.dll'
    if os.path.isfile(py_exe_dir + marker_dll):
        # this looks like a package bundle where all dependent DLLs are in the same directory.
        # nothing to do.
        return

    # We assume the layout of the thirdparty directory has DLLs in bin, lib\\qt4 and lib\\qt5
    thirdparty_lib = os.path.dirname(py_exe_dir)
    thirdparty_bin = os.path.dirname(thirdparty_lib) + "\\bin"
    
    extra_paths = (
        py_exe_dir,  # required for C++ tests that embed Python to find Python DLL
        thirdparty_bin,
        thirdparty_lib + "\\qt4\\bin",
        thirdparty_lib + "\\qt4\\lib",
        thirdparty_lib + "\\qt5\\bin",
        thirdparty_lib + "\\qt5\\lib"
    )
    for dll_dir in extra_paths:
        # Add it to the search path for this process if it exists
        if os.path.isdir(dll_dir):
            os.add_dll_directory(dll_dir)
    # Update PATH as add_dll_directory does not do this
    os.environ["PATH"] = ";".join(extra_paths) + ";" + os.environ["PATH"]


find_thirdparty()
del find_thirdparty