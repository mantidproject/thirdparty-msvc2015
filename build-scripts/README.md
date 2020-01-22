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

These currently require gcc < 5 to build and run correctly as they use legacy Fortran options:

* [tdm64-gcc-4.6.1.exe](https://sourceforge.net/projects/tdm-gcc/files/TDM-GCC%20Installer/Previous/1.1006.0/tdm64-gcc-4.6.1.exe/download)
* [gcc-4.6.1-tdm64-1-fortran.zip](https://sourceforge.net/projects/tdm-gcc/files/TDM-GCC%20Old%20Releases/TDM-GCC%204.6%20series/4.6.1-tdm64-1/gcc-4.6.1-tdm64-1-fortran.zip/download)

Install gcc then unzip gfortran into the same folder.

The build script assumes they are installed C:\MinGW64.

It is **not** included in the main buld script at this time.
