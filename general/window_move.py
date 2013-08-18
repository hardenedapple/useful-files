"""
Script to move a client to different position on the screen.

define possible positions in 'position_dict', execute them in 'snap_to'

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

# TODO: Add option to take specific geometries from the fifo and move the
#       window to that. e.g. if line matches a regex, interpret it as a
#       geometry and snap to that.
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
                  'normal': (0.45, 0.47),
                  'long': (0.3, 0.995)}


#
# Functions to move/resize
#
def snap_to(position):
    """Given 'position' function, move focussed client accordingly"""
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
    geom = find_geom(window)
    window.configure(height=height, width=width)
    if geom.x + width > edges['right'] or geom.y + height > edges['bottom']:
        geom.x -= max(geom.x + width - edges['right'], 0)
        geom.y -= max(geom.y + height - edges['bottom'], 0)
        window.configure(x=geom.x, y=geom.y)
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


# More global variables
dsp = display.Display()
scre = dsp.screen()
edges = find_edges_in_pixels(scre)
sizes = create_actual_sizes(scre)

if __name__ == "__main__":
    # Don't bother with try/except here - just let the exception raise
    try:
        if sys.argv[1] == 'stop':
            with open('/tmp/snap_file', 'w') as fif:
                fif.write('stop')
    except IndexError:
        pass
    else:
        sys.exit(0)
    os.mkfifo('/tmp/snap_file')
    # In case of some error somewhere
    atexit.register(os.remove, '/tmp/snap_file')
    for line in follow('/tmp/snap_file'):
        if line in position_dict:
            snap_to(line)
        elif line in sizes:
            resize(line)
        elif line == 'stop':
            break
        # just leave all other words alone
