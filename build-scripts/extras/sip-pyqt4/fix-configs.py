"""The default sipconfig/pyqtconfig files are not relocatable. This
script replaces the generated file with one using relative
paths
"""
from __future__ import print_function
import argparse
import os

here = os.path.dirname(__file__)

SIPCONFIG_HEADER = os.path.join(here, 'sipconfig-header.txt')
SIPCONFIG_TAIL_MARKER = '_default_macros = {'

PYQT4CONFIG_HEADER = os.path.join(here, 'pyqt4config-header.txt')
PYQT4CONFIG_TAIL_MARKER = SIPCONFIG_TAIL_MARKER

# ------------------------------------------------------------------------------
def load_head(filename):
    """Loads and returns the given file as string
    """
    with open(filename, 'r') as f:
        return f.read()

# ------------------------------------------------------------------------------

def load_tail(filename, marker):
    """Load the given file and return text
    from the line given by marker onwards
    """
    with open(filename, 'r') as f:
        lines = f.readlines()
    marker_index = 0
    for line in lines:
        line = line.rstrip()
        if line == marker:
            break
        marker_index += 1

    return ''.join(lines[marker_index:])

# ------------------------------------------------------------------------------

def write_fixed_config(filename, head, tail):
    with open(filename, 'w') as f:
        f.write(head + tail)

#-------------------------------------------------------------------------------

if __name__ == '__main__':
    # Parse arguments
    parser = argparse.ArgumentParser()
    parser.add_argument("sipconfig_file",
                        help="Path to generated sipconfig file")
    parser.add_argument("pyqtconfig_file",
                        help="Path to generated pyqtconfig file")
    args = parser.parse_args()

    # sipconfig
    sipconfig_in = args.sipconfig_file
    sipconfig_head = load_head(SIPCONFIG_HEADER)
    sipconfig_tail = load_tail(sipconfig_in, SIPCONFIG_TAIL_MARKER)
    write_fixed_config(sipconfig_in + ".fixed",
                       sipconfig_head, sipconfig_tail)

    # pyqtconfig
    pyqtconfig_in = args.pyqtconfig_file
    pyqtconfig_head = load_head(PYQT4CONFIG_HEADER)
    pyqtconfig_tail = load_tail(sipconfig_in, PYQT4CONFIG_TAIL_MARKER)
    write_fixed_config(pyqtconfig_in + ".fixed",
                       pyqtconfig_head, pyqtconfig_tail)
