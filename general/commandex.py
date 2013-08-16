"""
A simple pop-up app that takes a command and runs it.
Includes shortcuts to programs I run often.

This is really for use with subtle as I can't find the equivalent in that WM
"""

import tkinter as tk
from subprocess import Popen

# To Add:
#       Make the window open in the middle of the screen
#           Don't know why the 'center_window' function isn't working
#           Have to test more comparing scripts to ipython
#       Make alternate program that can combine with sxhkd to open programs
#           See ProgrammingTODO.txt file
#
# Also:
#   Tidy up: - figure out how later


def center_window(win):
    """Given a window, put it into the center of the screen it's on"""
    print(win.geometry())
    wid = win.winfo_screenwidth()
    hgt = win.winfo_screenheight()
    rootsize = tuple(int(_) for _ in win.geometry().split('+')[0].split('x'))
    xpos = wid/2 - rootsize[0]/2
    ypos = hgt/2 - rootsize[1]/2
    print(rootsize, xpos, ypos)
    # win.geometry("%dx%d+%d+%d" % (rootsize + (x, y)))


class OpenApp:
    """
    App that pops-up with a text entry option.
    Reads command from option and executes the command in a subprocess.

    Includes keybinding shortcuts to commonly used programs
    """

    def __init__(self, master, **kwargs):
        """
        Start the app up
        """
        # Define class variables
        self.master = master
        self.master.wm_title(kwargs['title'])
        self.xtmargs = ['xterm', '-geometry', '78x22']
        self.ufont = ['-font',
                      '-*-terminus-medium-r-normal-*-*-*-*-*-*-*-iso10646-*']
        self.shortcuts = {'m': ['-name', 'ncmpcpp', '-e',
                                'ncmpcpp -c ~/.config/ncmpcpp/config'],
                          'a': ['nothing', 'much'],
                          # For some reason can't get tmux to work with Popen
                          # have also tried 'tmux', 'new-session'
                          # 't': ['-name', 'testterm', '-e', 'tmux new-session'],
                          't': ['-name', 'testterm'],
                          'v': ['-name', 'alsamixer', '-e', 'alsamixer'],
                          'i': ['-name', 'irssi', '-e', 'irssi'],
                          'f': ['-name', 'ranger', '-e', 'ranger'],
                          'd': ['-name', 'rtorrent', '-e', 'rtorrent']}
        # Add Label and entry
        # tk.Label(master, text='Enter a command').pack(side=tk.TOP)
        self.entry = tk.Entry(self.master, width=30)
        # Add bindings
        self.entry.bind('<Return>', self.runcom)
        self.entry.bind('<Escape>', self.closeall)
        # pack and focus entry box
        self.entry.pack(side=tk.TOP)
        self.entry.focus()

    def closeall(self, event):
        """ Workaround to close window on 'ESC'"""
        self.master.destroy()

    def parse(self, command):
        """Check for nastiness, check for shortcuts, return full command"""
        # NOTE: most nastiness not yet caught
        if command.find('rm') != -1:
            # Will have to make an alert pop-up here
            self.master.destroy()
        if command[0] == '/':
            args = self.xtmargs
            try:
                if command[1] == 'u':
                    args = args + self.ufont
            except IndexError:
                # Just have a '/' - open terminal only
                return args
            try:
                end = self.shortcuts[command[-1]]
            except KeyError:
                end = []
            # Join parts of the command into one list
            return args + end
        # split by space
        return command.split()

    def runcom(self, event):
        """
        Take the string, parse it for any evil commands, execute the command.
        """
        mystr = self.entry.get()
        commands = [s.strip() for s in mystr.split(';')]
        for command in commands:
            if not len(command) < 1:
                popenargs = self.parse(command)
                # print(popenargs)
                Popen(popenargs)
        self.master.destroy()


if __name__ == '__main__':
    root = tk.Tk()
    # Not working
    center_window(root)
    app = OpenApp(root, title='Enter Command')
    # Don't know why this always comes out with size of 1x1
    root.mainloop()
