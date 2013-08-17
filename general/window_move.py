"""
Script to move a client to different position on the screen.

define possible positions in 'position_dict', execute them in 'snap_to'

This version uses a fifo, it seems the best method for this simple use, but if
I ever find a reason to extend it, I'll want to switch to sockets.
"""

import math
import os
from Xlib import display
import atexit

# TODO: Add option to take specific geometries from the fifo and move the
#       window to that. e.g. if line matches a regex, interpret it as a
#       geometry and snap to that.
#
#       Add option to daemonize
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
taskbarheight = 15


#
# Functions to move/resize
#
def snap_to(pos_func, disp):
    """Given 'position' function, move focussed client accordingly"""
    window = disp.get_input_focus().focus
    geometrynow = window.get_geometry()
    ypos, xpos = pos_func(geometrynow)
    window.configure(x=xpos, y=ypos)
    disp.flush()


def resize(size, disp, edgepos):
    """Given a 'size', resize client accordingly"""
    window = disp.get_input_focus().focus
    height, width = size
    geom = find_geom(window)
    window.configure(height=height, width=width)
    if geom.x + width > edgepos['right'] or geom.y + height > edgepos['bot']:
        geom.x -= max(geom.x + width - edgepos['right'], 0)
        geom.y -= max(geom.y + height - edgepos['bot'], 0)
        window.configure(x=geom.x, y=geom.y)
    disp.flush()


#
# Functions to convert percentage values to pixel values
#
def find_edges_in_pixels(scr, borders):
    """Convert the hard-coded borders to edges scaled to screen size"""
    # Assume want symmetry - if don't code it different later
    # Only partially accounted for status bar here (not accounted in SIZE of
    # border) - assume small enough that it doesn't matter.
    top = math.floor(scr.height_in_pixels * borders['top'])
    bottom = scr.height_in_pixels - top
    left = math.floor(scr.width_in_pixels * borders['side'])
    right = scr.width_in_pixels - left
    return {'top': top + taskbarheight, 'bot': bottom,
            'left': left, 'right': right}


def create_actual_sizes(scr, abs_sizes):
    """Convert the hard-coded sizes into sizes scaled to screen size"""
    def conv(tup):
        """Convert percentages to pixels"""
        return (math.floor(tup[0] * scr.height_in_pixels),
                math.floor(tup[1] * scr.width_in_pixels))
    return {key: conv(val) for key, val in abs_sizes.iteritems()}


def find_geom(win):
    """Find position of window, account for reparenting window managers"""
    # y position will always be greater that 0 because of the taskbar
    while win.get_geometry().y == 0:
        win = win.query_tree().parent
    return win.get_geometry()


#
# Functions to get input
#
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


#
# Main
#
def main():
    """Create display object, define position functions and edges, start the
    main loop"""
    dsp = display.Display()
    scre = dsp.screen()
    # Note sure if I'd prefer global variables and not passing as many
    # variables to functions.
    #
    # Think I'd prefer it that way for the script as it is, but if I ever want
    # to use it in a larger project, the more general functions are better
    myborders = {'top': 0.006,
                 'side': 0.004}

    position_dict = {'tl': lambda g: (edges['top'], edges['left']),
                     'tr': lambda g: (edges['top'], edges['right'] - g.width),
                     'bl': lambda g: (edges['bot'] - g.height, edges['left']),
                     'br': lambda g: (edges['bot'] - g.height,
                                      edges['right'] - g.width)
                     }

    abstract_sizes = {'small': (0.35, 0.5),
                      'normal': (0.45, 0.47),
                      'long': (0.3, 0.995)}

    edges = find_edges_in_pixels(scre, myborders)
    sizes = create_actual_sizes(scre, abstract_sizes)
    os.mkfifo('snap_file')
    # In case of some error somewhere
    atexit.register(os.remove, 'snap_file')
    for line in follow('snap_file'):
        if line in position_dict:
            snap_to(position_dict[line], dsp)
        elif line in sizes:
            resize(sizes[line], dsp, edges)
        elif line == 'end':
            break
        # just leave all other words alone


if __name__ == "__main__":
    main()
