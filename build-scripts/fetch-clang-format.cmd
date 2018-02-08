@setlocal enableextensions
::
:: Fetch tbb libraries and include the relevant libraries
::
@echo Setting up clang format 6 tool

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Setup environment. Important to ensure correct detection of environment
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call %~dp0cmds\common-setup.cmd

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Download directly to bin
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Revision corresponds to clang-format-6
@set REVISION=320423
@set LLVM_MAJOR_VERS=6.0
@set LLVM_WIN_URL="http://prereleases.llvm.org/win-snapshots/"
@set LLVM_SVN_URL="https://llvm.org/svn/llvm-project/cfe/trunk"
@set BUILD_DIR=%BUILD_ROOT%\clang-format-%LLVM_MAJOR_VERS%

@if not exist %BUILD_DIR% mkdir %BUILD_DIR%
cd %BUILD_DIR%
call:download-if-not-exist clang-format-%LLVM_MAJOR_VERS%.exe %LLVM_WIN_URL%/clang-format-r%REVISION%.exe
call:download-if-not-exist ClangFormat-%LLVM_MAJOR_VERS%.vsix %LLVM_WIN_URL%/ClangFormat-r%REVISION%.vsix
call:download-if-not-exist git-clang-format "%LLVM_SVN_URL%/tools/clang-format/git-clang-format?p=%REVISION%"

:: patch git-clang-format-6 to look for versioned clang-format
@echo "Patching default clang-format binary command"
sed -e"s/config\.get('clangformat\.binary'.*/config.get('clangformat.binary', 'clang-format-%LLVM_MAJOR_VERS%'),/" git-clang-format > git-clang-format-%LLVM_MAJOR_VERS%

:: copy into bin
copy /Y clang-format-%LLVM_MAJOR_VERS%.exe %INSTALL_PREFIX%\bin
copy /Y ClangFormat-%LLVM_MAJOR_VERS%.vsix %INSTALL_PREFIX%\bin
copy /Y git-clang-format-%LLVM_MAJOR_VERS% %INSTALL_PREFIX%\bin

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Finalize
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@call try-pause.cmd
goto:eof

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Helpers
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:download-if-not-exist
@set _target=%1
@set _url=%2
@if not exist %_target% @call download-file.cmd %_target% %_url%
goto:eof
