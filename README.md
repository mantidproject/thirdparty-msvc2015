Mantid Dependencies for Visual Studio 2015 (64-bit only)
========================================================

The `build-scripts` directory contains the scripts used to build all of the binaries.

The binaries are managed with [Git Large File Storage](https://git-lfs.github.com/). Installation of the client is required in order to download the assets successfully.

Interplay with Mantid Repository
--------------------------------

Mantid does **not** automatically track this repository. Instead a [Bootstrap.cmake](https://github.com/mantidproject/mantid/blob/master/buildconfig/CMake/Bootstrap.cmake) config file in the main mantid repository  contains a variable `THIRD_PARTY_GIT_SHA1` that defines the snapshot of this repository to use for a given build.

Updating a Dependency
---------------------

All builds **must** be managed by a build script so that the configuration of the build is well documented. The requirements for the
buildscripts are listed in [build-scripts/README.md](build-scripts/README.md).


To update a dependency:

* create branch
* find the appropriate script or add one for a new dependency in `build-scripts` and make any necessary updates to build the new/updated library. The libraries should be installed in the with the root of this repository as their install prefix.
* open a pull request

Updating Mantid
---------------

To test mantid against the new libraries create a new branch in [mantid](../../../mantid) and update `THIRD_PARTY_GIT_SHA1` in [Bootstrap.cmake](https://github.com/mantidproject/mantid/blob/master/buildconfig/CMake/Bootstrap.cmake) with the SHA1 of the last commit of the pull request from above. Add a link & comment in the new mantid PR that the associated PR in this repository should be merged when that one is merged.
