"""
Script to move a client to different position on the screen.

define possible positions in 'position_dict', execute them in 'snap_to'
"""

import math
import os
from Xlib import display

# TODO: Add option to take specific geometries from the fifo and move the
#       window to that. e.g. if line matches a regex, interpret it as a
#       geometry and snap to that.
#
#       Make resize check that the resizing doesn't send the window off the
#       screen
#
#       Could also add option to move a bit at a time (+5/-5)
#       etc. Though it's not much of a benefit - this could allow batch files
#       to be cat'ed into the fifo as a set of motions to make (which seems
#       cool to me).
#
#       Convert Xlib to python3 - will take a long time before I know what's
#                                 happening let alone be able to modify it.

borders = {'top': 0.006,
           'side': 0.004}

taskbarheight = 15

position_dict = {'tl': lambda g: (edges['top'], edges['left']),
                 'tr': lambda g: (edges['top'], edges['right'] - g.width),
                 'bl': lambda g: (edges['bottom'] - g.height, edges['left']),
                 'br': lambda g: (edges['bottom'] - g.height,
                                  edges['right'] - g.width)
                 }

abstract_sizes = {'small': (0.35, 0.5),
                  'normal': (0.48, 0.47),
                  'long': (0.3, 1)}


def snap_to(position):
    """Given 'position' key, move focussed client to that position"""
    # dsp, and position_dict are global variables
    window = dsp.get_input_focus().focus
    geometrynow = window.get_geometry()
    ypos, xpos = position_dict[position](geometrynow)
    window.configure(x=xpos, y=ypos)
    dsp.flush()


def resize(size):
    """Given a 'size', resize client accordingly"""
    # dsp, and position_dict are global variables
    window = dsp.get_input_focus().focus
    height, width = sizes[size]
    window.configure(height=height, width=width)
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


def find_edges_in_pixels(scr):
    """Convert the hard-coded borders to edges scaled to screen size"""
    # Assume want symmetry - if don't code it different later
    # Haven't accounted for status bar here - assume small enough that it
    # doesn't matter.
    top = math.floor(scr.height_in_pixels * borders['top'])
    bottom = scr.height_in_pixels - top
    left = math.floor(scr.width_in_pixels * borders['side'])
    right = scr.width_in_pixels - left
    # Remember to account for taskbar
    return {'top': top + taskbarheight, 'bottom': bottom, 'left': left, 'right': right}


def create_actual_sizes(scr):
    """Convert the hard-coded sizes into sizes scaled to screen size"""
    def conv(tup):
        """Convert percentages to pixels"""
        return (math.floor(tup[0] * scr.height_in_pixels),
                math.floor(tup[1] * scr.width_in_pixels))
    return {key: conv(val) for key, val in abstract_sizes.iteritems()}


if __name__ == "__main__":
    dsp = display.Display()
    scre = dsp.screen()
    root = scre.root
    edges = find_edges_in_pixels(scre)
    sizes = create_actual_sizes(scre)
    # Initialise the starting positions
    # Want a function that finds the current position.
    # Problem is get_geometry always gives 0, 0 for position
    # something to do with reparenting?
    os.mkfifo('snap_file')
    for line in follow('snap_file'):
        if line in position_dict:
            snap_to(line)
        elif line in sizes:
            resize(line)
        else:
            break
    os.remove('snap_file')
