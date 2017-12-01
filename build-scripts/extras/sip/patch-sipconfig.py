"""The default sipconfig files are not relocatable. This
script replaces the generated file with one using relative
paths.
"""
from __future__ import print_function

import argparse
import re

INSTALL_PREFIX_RE = re.compile(r"^\s*'default_bin_dir':\s*'(.*)',\s*$")

def create_regex(content):
    """Create a regex based on the given content.
    Searches for INSTALL_PREFIX_KEY and assumes
    this forms the prefix for all other replacements
    """
    install_prefix = None
    for line in content:
        match = INSTALL_PREFIX_RE.match(line)
        if match:
            install_prefix = match.group(1)
            break
    #endfor
    if install_prefix is None:
        raise RuntimeError("Unable to find line matching '{}'. Please check regex definition".format(INSTALL_PREFIX_RE))

    # re.escape is not what we want as it escapes everything but alphanumeric characters
    # so we do it by hand
    # backslashes need to be escaped
    install_prefix = install_prefix.replace('\\', '\\\\')
    # period characters need to be escaped
    install_prefix = install_prefix.replace('.', '\.')
    return re.compile("'" + install_prefix + r"(\\\\)?(.*)'")

def patch_line(line, regex):
    def repl(match):
        if match.group(1) is None:
            return 'sys.prefix'
        else:
            return "os.path.join(sys.prefix, '" + match.group(2) + "')"
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

    regex = create_regex(lines)
    for line in lines:
        out_line = patch_line(line.rstrip(), regex)
        print(out_line)
