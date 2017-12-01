Build Scripts for Third Party on Windows
========================================

Current prerequisites:

* Visual Studio (see `common-setup.cmd`)
* [ActiveState Perl](http://www.activestate.com/activeperl) - (For Perl, the one in git doesn't work when building OpenSSL)
* [7-zip](http://www.7-zip.org/)
* [Git](https://git-scm.com/downloads) - (For cURL)
* [CMake](http://www.cmake.org)
* [Ruby](https://rubyinstaller.org/downloads/) - Required for building Qt5 with webkit
* [Cygwin](https://www.cygwin.com/) - Required for building ICU. Make sure you install dos2unix, make, binutils


VC++ for Python
---------------

For installing certain Python packages you will require:

* VC++ for Python2.7 - http://aka.ms/vcpython27. It gets installed in %LOCALAPPDATA%\Programs\Common\Microsoft\Visual C++ for Python\9.0.

In order to use this through `distutils` some setup steps are required before being able to call `python setup.py`:

```
call "%LOCALAPPDATA%\Programs\Common\Microsoft\Visual C++ for Python\9.0\vcvarsall.bat" amd64
set DISTUTILS_USE_SDK=1
set MSSdk=1
```

Inelastic Fortran Modules
-------------------------

The Inelastic fortran modules can be built by the `build-inelastic-fortran.cmd` script. It requires that
the Intel Visual Composer XE Fortran compiler along with the VC++ for Python is installed.

It is **not** included in the main buld script at this time.
