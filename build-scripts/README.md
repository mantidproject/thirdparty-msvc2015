Build Scripts for Third Party on Windows
========================================

Current prerequisites:

* Visual Studio (see `common-setup.cmd`)
* [ActiveState Perl](http://www.activestate.com/activeperl) - (For Perl, the one in git doesn't work when building OpenSSL)
* [7-zip](http://www.7-zip.org/)
* [Git](https://git-scm.com/downloads) - (For cURL)
* [CMake](http://www.cmake.org)

For installing certain Python packages you will require:

* VC++ for Python2.7 - http://aka.ms/vcpython27. It gets installed in %LOCALAPPDATA%\Programs\Common\Microsoft\Visual C++ for Python\9.0

We should probably have bootstrap script for all this stuff