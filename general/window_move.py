#!/usr/bin/env python2
"""
Script to move a client to different position on the screen.

define possible positions in 'position_dict', execute them in 'snap_to'

Assumes you have a taskbar on the top of the screen.
If not positions will be off a little - I'm looking into it but not too hard
as it works for me at the moment.

This version uses a fifo, it seems the best method for this simple use, but if
I ever find a reason to extend it, I'll want to switch to sockets.

As this version will only ever be used as a script, I'm using global variables
that I can change manually If I ever want to.

If you want to run this as a systemd daemon, simply add an service file like
~/.config/systemd/user/snap_to.service      and run
systemctl --user enable snap_to.service

If I ever intend to import some of these functions, get those from
window_move_sockets.py - they're more general.
"""

from Xlib import display
import atexit
import math
import os
import stat
import sys

# TODO: Add option to take specific geometries from the fifo and move the
#       window to that. e.g. if line matches a regex, interpret it as a
#       geometry and snap to that.
#
#       Account for multiple monitors - dsp.screen_count(), dsp.screen(num)
#       Maybe that the screen numbering is in order of left to right (or
#       something like that, then might know which value to add to the
#       geometries.
#
#       Could also add option to move a bit at a time (+5/-5)
#       etc. Though it's not much of a benefit - this could allow batch files
#       to be cat'ed into the fifo as a set of motions to make (which seems
#       cool to me).
#
#       Convert Xlib to python3 - will take a long time before I know what's
#                                 happening let alone be able to modify it.

borders = {'top': 0.008,
           'side': 0.006}

taskbarheight = 15
fifoname = '/tmp/snap_file'

position_dict = {'tl': lambda g: (edges['top'], edges['left']),
                 'tr': lambda g: (edges['top'], edges['right'] - g.width),
                 'bl': lambda g: (edges['bottom'] - g.height, edges['left']),
                 'br': lambda g: (edges['bottom'] - g.height,
                                  edges['right'] - g.width)
                 }

abstract_sizes = {'small': (0.35, 0.5),
                  'normal': (0.43, 0.44),
                  'long': (0.3, 0.987)}


#
# Functions to move/resize
#
def snap_to(position):
    """Given 'position' function, move focussed client accordingly"""
    # dsp, and position_dict are global variables
    window = dsp.get_input_focus().focus
    geometrynow = find_geom(window)
    newy, newx = position_dict[position](geometrynow)
    window.configure(x=newx, y=newy)
    dsp.flush()


def resize(size):
    """Given a 'size', resize client accordingly"""
    # dsp, and position_dict are global variables
    window = dsp.get_input_focus().focus
    newheight, newwidth = sizes[size]
    nowgeom = find_geom(window)
    window.configure(height=newheight, width=newwidth)
    if nowgeom.x + newwidth > edges['right'] \
            or nowgeom.y + newheight > edges['bottom']:
        nowgeom.x -= max(nowgeom.x + newwidth - edges['right'], 0)
        nowgeom.y -= max(nowgeom.y + newheight - edges['bottom'], 0)
        window.configure(x=nowgeom.x, y=nowgeom.y)
    dsp.flush()


#
# Functions to convert percentage values to pixel values
#
def find_edges_in_pixels(scr):
    """Convert the hard-coded borders to edges scaled to screen size"""
    # Assume want symmetry - if don't code it different later
    # Only partially accounted for status bar here (not accounted in SIZE of
    # border) - assume small enough that it doesn't matter.
    top = math.floor(scr.height_in_pixels * borders['top'])
    bottom = scr.height_in_pixels - top
    left = math.floor(scr.width_in_pixels * borders['side'])
    right = scr.width_in_pixels - left
    return {'top': top + taskbarheight, 'bottom': bottom,
            'left': left, 'right': right}


def create_actual_sizes(scr):
    """Convert the hard-coded sizes into sizes scaled to screen size"""
    def conv(tup):
        """Convert percentages to pixels"""
        return (math.floor(tup[0] * scr.height_in_pixels),
                math.floor(tup[1] * scr.width_in_pixels))
    return {key: conv(val) for key, val in abstract_sizes.iteritems()}


def find_geom(win):
    """Find position of window, account for reparenting window managers"""
    # taskbar stops the window reaching the top of the screen.
    # can't use y position - in case of titlebars - use height.
    win2 = win.query_tree().parent
    while win2.get_geometry().height < scre.height_in_pixels:
        win = win2
        win2 = win2.query_tree().parent
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


def main():
    """
    Run the functionality of the script.
    :returns: NULL

    """
    os.mkfifo(fifoname)
    # In case of some error somewhere
    atexit.register(os.remove, fifoname)
    for line in follow(fifoname):
        if line in position_dict:
            snap_to(line)
        elif line in sizes:
            resize(line)
        elif line == 'stop':
            break
        # just leave all other words alone


if __name__ == "__main__":
    # Only catch index errors - let the exceptions raise if there's any other
    # problem.
    try:
        # An other command line arguments are ignored
        if sys.argv[1] == 'stop' and \
           stat.S_ISFIFO(os.stat(fifoname).st_mode):
            with open(fifoname, 'w') as fif:
                fif.write('stop')
    except IndexError:
        # More global variables
        dsp = display.Display()
        scre = dsp.screen()
        edges = find_edges_in_pixels(scre)
        sizes = create_actual_sizes(scre)
        main()
