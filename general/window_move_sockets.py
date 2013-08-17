"""
Script to move a client to different position on the screen.

define possible positions in 'position_dict', execute them in 'snap_to'

This uses sockets to accept commands/messages, it allows future expansion
(though for what I don't know), at the expense of a slightly more complicated
command sending method.

This version uses 'select' to multiplex the server and accept connections this
gives a nice solution to the 'end' message.
"""

import math
from Xlib import display
import socket
from select import select

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
# Functions to move/resize given position
#
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
# Functions to get/use input
#
def change_func(inp):
    """Handle the input and call relevant snap_to position"""
    pos = inp.decode('utf-8').strip()
    if pos in position_dict:
        snap_to(pos)
    elif pos in sizes:
        resize(pos)


def clearup(readers):
    """Close all sockets (when multiplexing)"""
    for sock in readers:
        sock.shutdown(socket.SHUT_RDWR)
        sock.close()


def handle_socks():
    """Function to handle selection of sockets when multiplexing"""
    # global readsocks
    for sock in readables:
        if s is sock:
            newconn, _ = sock.accept()
            readsocks.append(newconn)
            continue
        data = sock.recv(10).strip()
        if not data:
            readsocks.remove(sock)
            sock.shutdown(socket.SHUT_RDWR)
            sock.close()
            continue
        elif data == 'end':
            return False
        change_func(data)
    return True


#
# Main
#
if __name__ == "__main__":
    dsp = display.Display()
    scre = dsp.screen()
    root = scre.root
    edges = find_edges_in_pixels(scre)
    sizes = create_actual_sizes(scre)
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.bind(('', 8732))
    s.listen(4)
    readsocks = [s]
    # Will profile later to see how the speed goes compared to fifo
    while True:
        # Don't want to write anything at the moment
        readables, writeables, exceptions = select(readsocks, [], [])
        if not handle_socks():
            clearup(readables)
            break
