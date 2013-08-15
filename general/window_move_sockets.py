"""
Script to move a client to different position on the screen.

define possible positions in 'position_dict', execute them in 'snap_to'
"""

from Xlib import display
import socket

# TODO: To generalise the script: find the desktop size and use fractions of
#       that size.
#
#       Use the daemonise function (double fork) to turn this into a daemon
#       and store a pid file so I can kill it
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


def change_func(inp):
    global current_pos, position_dict, validpos, sizes
    pos = inp.decode('utf-8').strip()
    if pos in validpos:
        current_pos = pos
    elif pos in sizes:
        position_dict = sizes[pos]
    else:
        return
    snap_to(current_pos)


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
    validpos = ['tr', 'tl', 'bl', 'br']
    sizes = {'small': small_dict, 'medium': medium_dict}
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.bind(('', 8732))
    s.listen(4)
    # At the moment this loses the main benefits of using a socket over a fifo
    # Benefits:
    #       Possible two-way communication (not required for me)
    #       Client distinguishability - (probably not important for this)
    #
    # Will profile later to see how the speed goes
    while True:
        conn, addr = s.accept()
        change_func(conn.recv(1024))
        # I shutdown repeatedly so I can use 'nc' to send a message and let it
        # automatically stop straight away>
        # I assume this adds a lot of overhead to just reading from the socket
        # Also stops the possibility of two-way communication (if I ever need
        # it)
        # should be some way to tell nc: "quit after sending message"
        # don't know how at the moment
        conn.shutdown(socket.SHUT_RDWR)
        conn.close()
