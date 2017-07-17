"""The default pyqtconfig files are not relocatable. This
script replaces the generated file with one using relative
paths assuming it is part of our Python bundle
"""
from __future__ import print_function

import argparse
import re

PY_INSTALL_PREFIX_RE = re.compile(r"^\s*'pyqt_bin_dir':\s*'(.*)',\s*$")
QT_INSTALL_PREFIX_RE = re.compile(r"^\s*'qt_dir':\s*'(.*)',\s*$")

def create_install_prefix_re(content, cfg_line_re):
    """Creates a that will match against
    those lines containing the hard-coded Python sys.prefix.
    @param content The content of the file
    @param cfg_line_re A regex to match against a line in the config. It must contain
    at least 1 capture group to capture prefix itself
    """
    install_prefix = None
    for line in content:
        match = cfg_line_re.match(line)
        if match:
            install_prefix = match.group(1)
            break
    #endfor
    if install_prefix is None:
        raise RuntimeError("Unable to find line matching '{}'. Please check regex definition".format(cfg_line_re))
    # re.escape is not what we want as it escapes everything but alphanumeric characters
    # so we do it by hand
    # backslashes need to be escaped
    install_prefix = install_prefix.replace('\\', '\\\\')
    # period characters need to be escaped
    install_prefix = install_prefix.replace('.', '\.')
    return re.compile("'" + install_prefix + r"((\\\\)|/)?(.*)'")

def create_py_install_prefix_re(content):
    """Creates a regex that will match against
    those lines containing the hard-coded Python sys.prefix.
    """
    return create_install_prefix_re(content, PY_INSTALL_PREFIX_RE)

def create_qt_install_prefix_re(content):
    """Creates a regex that will match against
    those lines containing the hard-coded Qt paths in pyqtconfig
    """
    return create_install_prefix_re(content, QT_INSTALL_PREFIX_RE)

def patch_sys_prefix_line(line, regex):
    def repl(match):
        if match.group(1) is None and match.group(2) is None:
            return 'sys.prefix'
        else:
            return "os.path.join(sys.prefix, '" + match.group(3) + "')"
    return re.sub(regex, repl, line)

def patch_qt_dir_line(line, regex):
    def repl(match):
        if match.group(1) is None and match.group(2) is None:
            return "os.path.join(sys.prefix, '..', 'qt4')"
        else:
            return "os.path.join(sys.prefix, '..', 'qt4', '" + match.group(3) + "')"
    return re.sub(regex, repl, line)

# -------------------------------------------------------------------------------

if __name__ == '__main__':
    # Parse arguments
    parser = argparse.ArgumentParser()
    parser.add_argument("sipconfig_file",
                        help="Path to generated sipconfig file")
    args = parser.parse_args()

    sipconfig_in = args.sipconfig_file
    with open(sipconfig_in, 'r') as f:
        lines = f.readlines()

    sys_prefix_re, qt_prefix_re = create_py_install_prefix_re(lines), create_qt_install_prefix_re(lines)
    for line in lines:
        # the Qt paths can end up in unix style
        line = line.rstrip()
        if 'import sipconfig' in line:
            out = '\n'.join((line, 'import os', 'import sys'))
        elif "'pyqt_" in line:
            out = patch_sys_prefix_line(line, sys_prefix_re)
        else:
            out = patch_qt_dir_line(line, qt_prefix_re)
        print(out)
