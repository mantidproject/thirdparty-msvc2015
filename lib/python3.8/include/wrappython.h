// Copyright &copy; 2015 ISIS Rutherford Appleton Laboratory, NScD Oak Ridge
// National Laboratory & European Spallation Source

// This file is part of Mantid.

// Mantid is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 3 of the License, or
// (at your option) any later version.

// Mantid is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

// File change history is stored at: <https://github.com/mantidproject/mantid>.
// Code Documentation is available at: <http://doxygen.mantidproject.org>

// This file serves as a wrapper around <Python.h>
// which disables the default MSVC  behavior so that a program may be compiled 
// in debug mode without requiring a special debugging build of the Python library.

// It is a heavily modified version of <boost/python/detail/wrap_python.hpp> with most
// details regarding older compilers removed

//  To use the Python debugging library, #define MANTID_DEBUG_PYTHON on the
//  compiler command-line.

#ifdef _DEBUG
# ifndef MANTID_DEBUG_PYTHON
#  undef _DEBUG // Don't let Python force the debug library just because we're debugging.
#  define DEBUG_UNDEFINED_FROM_WRAP_PYTHON_H
# endif
#endif

# include <pyconfig.h>
# include <Python.h>

#ifdef DEBUG_UNDEFINED_FROM_WRAP_PYTHON_H
# undef DEBUG_UNDEFINED_FROM_WRAP_PYTHON_H
# define _DEBUG
#endif
