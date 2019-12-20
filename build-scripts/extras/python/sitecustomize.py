"""
Attempts to detect if this bundle is run from a development build and updates the PATH
if so to find all depedent libraries. A packaged bundle has all DLLs in the main bin directory
and requires no further updating. In this case we can safely assume this bundle is only
ever used on a Windows platform. This trick is based on the similar find_qt functionality
in PyQt5.__init__.
"""

def find_thirdparty():
    import os, sys

    executable = sys.executable
    # don't do anything unless we are Python
    if "python" not in executable:
        return

    marker_dll = '\\zlib.dll'
    # Look for a "marker" dll to signify we are in a development build layout
    py_exe_dir = os.path.dirname(executable)
    if os.path.isfile(py_exe_dir + marker_dll):
        # this looks like a package bundle where all dependent DLLs are in the same directory.
        # nothing to do
        return
    
    # We assume the layout of the thirdparty directory has DLLs in bin, lib\\qt4 and lib\\qt5
    thirdparty_lib = os.path.dirname(py_exe_dir)
    thirdparty_bin = os.path.dirname(thirdparty_lib) + "\\bin"
    extra_paths = (thirdparty_bin, thirdparty_lib + "\\qt4\\bin",
                   thirdparty_lib + "\\qt5\\bin")
    for dll_dir in extra_paths:
        # Add it to the search path for this process if it exists
        if os.path.isdir(dll_dir):
            os.add_dll_directory(dll_dir)
    # Update PATH as add_dll_directory does not do this
    os.environ["PATH"] = ";".join(extra_paths) + ";" + os.environ["PATH"]


find_thirdparty()
del find_thirdparty