#!/usr/bin/env python2
"""
Script to move a client to different position on the screen.

define possible positions in 'position_dict', execute them in 'snap_to'

Assumes you have a taskbar on the top of the screen.
If not positions will be off a little - I'm looking into it but not too hard
as it works for me at the moment.

This uses sockets to accept commands/messages, it allows future expansion
(though for what I don't know), at the expense of a slightly more complicated
command sending method.

This version uses 'select' to multiplex the server and accept connections this
gives a nice solution to the 'stop' message.

This version is ready for extension and for importing specific functions.
"""

from Xlib import display
from select import select
import atexit
import math
import os
import socket
import sys

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


#
# Functions to move/resize given position
#
def snap_to(pos_func, window, geometrynow):
    """Given 'position' function, move focussed client accordingly"""
    newy, newx = pos_func(geometrynow)
    window.configure(x=newx, y=newy)


def resize(size, window, edgepos, nowgeom):
    """Given a 'size', resize client accordingly"""
    newheight, newwidth = size
    window.configure(height=newheight, width=newwidth)
    if nowgeom.x + newwidth > edgepos['right'] \
            or nowgeom.y + newheight > edgepos['bot']:
        nowgeom.x -= max(nowgeom.x + newwidth - edgepos['right'], 0)
        nowgeom.y -= max(nowgeom.y + newheight - edgepos['bot'], 0)
        window.configure(x=nowgeom.x, y=nowgeom.y)


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


def find_geom(win, maxheight):
    """Find position of window, account for reparenting window managers"""
    # taskbar stops the window reaching the top of the screen.
    # can't use y position - in case of titlebars - use height.
    # Uses global scre
    win2 = win.query_tree().parent
    while win2.get_geometry().height < maxheight:
        win = win2
        win2 = win2.query_tree().parent
    return win.get_geometry()


#
# Functions to get/use input
#
def clearup(readers):
    """Close all sockets (when multiplexing)"""
    for sock in readers:
        sock.shutdown(socket.SHUT_RDWR)
        sock.close()


def handle_socks(server, avail_now, tot_list, action):
    """Function to handle selection of sockets when multiplexing"""
    for sock in avail_now:
        if sock is server:
            newconn, _ = sock.accept()
            tot_list.append(newconn)
            continue
        data = sock.recv(10).strip()
        if not data:
            tot_list.remove(sock)
            sock.shutdown(socket.SHUT_RDWR)
            sock.close()
            continue
        elif data == 'stop':
            return False
        action(data)
    return True


#
# If I want to make a daemon
#
def close():
    # Could do this with the pid file, but seems simpler to use the command I
    # implemented for conveniance while debugging
    """Sends a 'stop' signal to an open socket"""
    soc = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    try:
        soc.connect(('', 8732))
    except socket.error as err:
        # If no existing socket, don't need to do anything
        if err.errno == 111:
            return
        raise
    else:
        soc.send('stop\n')
    finally:
        soc.close()


def createdaemon(pidfile='/tmp/snap_pid'):
    """Implement UNIX double-fork procedure, see
    http://code.activestate.com/recipes/278731/"""
    # os._exit() is like sys.exit() but doesn't call registered signal
    # handlers or flush stdio buffers etc
    #
    # Check to see if there is already a running instance
    try:
        with open(pidfile, 'r') as pidf:
            pid = int(pidf.read().strip())
    except IOError:
        pid = None
    else:
        sys.stderr.write('Pid file exists - check if Daemon is running')
        sys.exit(1)

    # If os.fork doesn't work - leave the exceptions to raise themselves
    pid = os.fork()
    if pid > 0:
        # parent:- kill
        os._exit(0)

    # child:- decouple
    os.chdir('/')
    os.setsid()
    os.umask(0)
    pid = os.fork()

    # second fork means process is not a session leader, hence can't acquire
    # controlling tty and is reparented onto init (not required for this
    # program, but I'm only learning at the moment)
    if pid > 0:
        #parent:- kill
        os._exit(0)

    # Redirect standard file descriptors
    sys.stdout.flush()
    sys.stdin.flush()
    stdi = open(os.devnull, 'r')
    stdo = open(os.devnull, 'a+')
    stde = open(os.devnull, 'a+')

    os.dup2(stdi.fileno(), sys.stdin.fileno())
    os.dup2(stdo.fileno(), sys.stdout.fileno())
    os.dup2(stde.fileno(), sys.stderr.fileno())

    # make sure to remove pidfile when exiting
    atexit.register(os.remove, pidfile)

    with open(pidfile, 'a') as pidf:
        pidf.write(str(os.getpid()) + '\n')


#
# Main
#
def main(daemon=False, pidfile='/tmp/snap_pid'):
    """Create display object, define position functions and edges, start main
    loop"""

    if daemon:
        createdaemon(pidfile)

    dsp = display.Display()
    scre = dsp.screen()
    maxheight = scre.height_in_pixels

    myborders = {'top': 0.008,
                 'side': 0.006}

    abstract_sizes = {'small': (0.35, 0.5),
                      'normal': (0.43, 0.44),
                      'long': (0.3, 0.987)}

    edges = find_edges_in_pixels(scre, myborders)
    sizes = create_actual_sizes(scre, abstract_sizes)

    position_dict = {'tl': lambda g: (edges['top'], edges['left']),
                     'tr': lambda g: (edges['top'], edges['right'] - g.width),
                     'bl': lambda g: (edges['bot'] - g.height, edges['left']),
                     'br': lambda g: (edges['bot'] - g.height,
                                      edges['right'] - g.width)
                     }

    def change_func(inp):
        """Handle the input and call relevant snap_to position"""
        # Here I assume that most of the time I'll receive a valid command
        # If that's not the case, move the defining of variables into the if
        # clause
        pos = inp.decode('utf-8').strip()
        window = dsp.get_input_focus().focus
        geometrynow = find_geom(window, maxheight)
        if pos in position_dict:
            snap_to(position_dict[pos], window, geometrynow)
        elif pos in sizes:
            resize(sizes[pos], window, edges, geometrynow)
        dsp.flush()

    serv = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    serv.bind(('', 8732))
    serv.listen(4)
    readsocks = [serv]
    # Will profile later to see how the speed goes compared to fifo
    while True:
        # Don't want to write anything at the moment
        readables, _, _ = select(readsocks, [], [])
        if not handle_socks(serv, readables, readsocks, change_func):
            clearup(readables)
            break


if __name__ == "__main__":
    # Check to see if we've been asked to halt
    taskbarheight = 15
    try:
        # try to close if have argument
        if sys.argv[1] == 'stop':
            close()
        elif sys.argv[1] == 'daemon':
            main(daemon=True)
        else:
            sys.stderr.write('Unknown command line argument\n')
            sys.exit(1)
    except IndexError:
        main()


# pymode:lint_ignore=W0212,C901
