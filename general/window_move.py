"""
Script to move a client to different position on the screen.

define possible positions in 'position_dict', execute them in 'snap_to'
"""

import os
import time
from Xlib import display

# TODO: To generalise the script: find the desktop size and use fractions of
#       that size.
#
#       Add option to take specific geometries from the fifo and move the
#       window to that. e.g. if line matches a regex, interpret it as a
#       geometry and snap to that.
#
#       Could also add option to move a bit at a time (+5/-5)
#       etc. Though it's not much of a benefit - this could allow batch files
#       to be cat'ed into the fifo as a set of motions to make (which seems
#       cool to me).
#
#       Ideal - have a fifo, to pass information, but somehow read blockingly
#               instead of waiting every time there's no extra line.
#
#       Convert Xlib to python3 - will take a long time before I know what's
#                                 happening let alone be able to modify it.

medium_dict = {'tr': (709, 20, 644, 364),
               'tl': (9, 20, 644, 364),
               'bl': (9, 400, 644, 364),
               'br': (709, 400, 644, 364)}

small_dict = {'tr': (675, 20, 683, 263),
              'tl': (9, 20, 683, 263),
              'bl': (9, 497, 683, 263),
              'br': (675, 497, 683, 263)}


def snap_to(position):
    """Given 'position' key, move focussed client to that position"""
    # dsp, and position_dict are global variables
    window = dsp.get_input_focus().focus
    # Change function to accept a geometry, then add another function between
    # the call and this to find geometry (other function would use screen size
    # and get percentage positions).
    # geometrynow = window.get_geometry()
    xpos, ypos, width, height = position_dict[position]
    window.configure(x=xpos, y=ypos, width=width, height=height)
    dsp.flush()


def readoneline(infile):
    """
    Use the blocking open of a fifo to blockingly read one line only

    This means I don't have a loop going over and over again - I have a loop
    that waits for a signal
    """
    with open(infile) as blckread:
        return blckread.readline()


def follow(myfile):
    """similar to tail -f, mainly comes fom www.dabeaz.com/generators/"""
    while True:
        retline = readoneline(myfile)
        if not retline:
            continue
        yield retline.strip()


if __name__ == "__main__":
    dsp = display.Display()
    root = dsp.screen().root
    # Initialise the starting positions
    # Want a function that finds the current position.
    # Problem is get_geometry always gives 0, 0 for position
    current_pos = 'tr'
    # Finding original size not a problem - will implement when am finding
    # original position.
    position_dict = medium_dict
    os.mkfifo('snap_file')
    validpos = ['tr', 'tl', 'bl', 'br']
    sizes = {'small': small_dict, 'medium': medium_dict}
    for line in follow('snap_file'):
        if line in validpos:
            current_pos = line
        elif line in sizes:
            position_dict = sizes[line]
        else:
            break
        snap_to(current_pos)
    os.remove('snap_file')
