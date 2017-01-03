@setlocal enableextensions
:: Master build script for all dependencies.
::
:: The order here is important as some packages rely
:: on others.
::
:: See README.md for the prerequisites.
::
@echo Building Third Party Dependencies

:: Marker for other scripts to know they are children and not to pause
@set ALL_BUILD_RUNNING=1

cd /D %~dp0
:: dependents
@call fetch-python.bat
@call build-openssl.bat
@call build-szip.bat
@call build-zlib.bat
@call build-hdf5.bat

:: framework
@call build-boost.bat
@call build-gsl.bat
@call build-jsoncpp.bat
@call build-muparser.bat
@call build-nexus.bat
@call build-oce.bat
@call build-poco.bat
@call fetch-tbb.bat
@call fetch-flatbuffers.bat
@call build-librdkafka.bat

:: gui
@call build-qt4.bat
@call build-qscintilla2-qt4.bat
@call build-qwt5-qt4.bat
@call build-qwtplot3d-qt4.bat

