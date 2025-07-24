#!/usr/bin/env python3

import re
import sys
import itertools as itt

def gather_sections(lines):
    ret = []
    current_section = None
    for line in lines:
        line = line.strip()
        if re.match(r'^P\d', line):
            if current_section:
                ret.append(current_section)
            current_section = [line]
            continue
        assert current_section is not None
        # Ignore any empty lines in any section.
        if not line:
            continue
        current_section.append(line)
    if current_section:
        ret.append(current_section)
    return ret

def merge_sections(section_list):
    ret = []
    line_args = []
    padding_lengths = None
    for args in itt.zip_longest(*section_list, fillvalue=' '):
        line_args.append(args)
        cur_lengths = [len(x) for x in args]
        if padding_lengths:
            padding_lengths = [max(a, b) for a, b in
                               zip(padding_lengths, cur_lengths)]
        else:
            padding_lengths = cur_lengths
    format_string = '|'.join('{{: <{}}}'.format(n + 1)
                             for n in padding_lengths)
    format_string += ' ;'
    for args in line_args:
        ret.append(format_string.format(*args))
    return '\n'.join(ret)

if __name__ == '__main__':
    print(merge_sections(gather_sections(sys.stdin)))
