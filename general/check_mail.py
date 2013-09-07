#!/usr/bin/env python
"""
Script to print out the sender and subject of unread messages of an email.
Does not check for much in the way of errors, if there is a problem ignores it

Idea:
*   Take e-mails from somewhere (probably from lancaster university server)
*   Parse them
*   Put them in a pop-up telling the subject and sender.
"""
from re import findall
from tkinter import font as tkfont
from functools import wraps
import atexit
import imaplib
import math
import sys
import tkinter as tk


# TODO:
#   Account for wibox height on awesome without losing automatic account in
#   subtle

gopts = ['gmail', 'g', 'home', 'h']
gmailvars = '/home/apple/.config/passwords/gmailpass'
gmailurl = 'https://mail.google.com/'
lancsvars = '/home/apple/.config/passwords/lancspass'
lancsurl = 'https://exchange2010.lancs.ac.uk/'


#
# Getting e-mail
def get_from_subject(mesid, mailbox):
    """Given a message id and the mailbox it comes from, return the From and
    Subject headers in a pretty(ish) format"""
    res, data = mailbox.fetch(mesid, 'BODY.PEEK[HEADER.FIELDS (SUBJECT FROM)]')
    if res != 'OK':
        raise RuntimeError('error in fetch call for {}'.format(mesid))
    # Apparently default character set for IMAP is UTF7
    myheads = data[0][1].decode('utf-7')

    try:
        name = findall(r'From:\s+"?([\s\w,]+)"?\s+<', myheads)[0]
    except IndexError:
        # Not sure if this will work all the time - if there are any errors,
        # look here
        name = findall(r'From:.*(<.*>)\r\n', myheads)[0]  # Assume match

    subject = findall(r'Subject:\s+(.*)\r\n', myheads)[0]  # Assume match
    return ' '.join((name, ':', subject))


def find_unread(mailbox):
    """Get emails unread, print message subjects and senders"""
    # Not checking here would make the case where there are messages quicker
    numunseen = findall(rb'\d+', mailbox.status('Inbox', '(UNSEEN)')[1][0])
    if numunseen == [b'0']:
        return ['There are no unread messages']

    mailbox.select('inbox')
    res, data = mailbox.search(None, 'UNSEEN')
    if res != 'OK':
        raise RuntimeError('error in search call')
    unseen = data[0].split()
    unseen.reverse()
    messagecount = user.capitalize() + ' : {} new messages'.format(len(unseen))
    meslist = [get_from_subject(mesid, mailbox).strip() for mesid in unseen]
    return [messagecount] + meslist


#
# Creating pop-up
def updatesize(frame):
    """Set the size for the frame widget"""
    winwid, winhgt = frame.winfo_width(), frame.winfo_height()
    scrwid, scrhgt = frame.winfo_screenwidth(), frame.winfo_screenheight()
    newx, newy = math.floor(scrwid * 0.99) - winwid, math.floor(scrhgt * 0.01)
    frame.master.geometry("{}x{}+{}+{}".format(winwid, winhgt, newx, newy))


def close(event):
    """Remove the window that recieved the event"""
    event.widget.destroy()


def openemail(event):
    """Open e-mail in browser and close pop-up"""
    import webbrowser
    webbrowser.open(emailurl)
    close(event)


# A Widget inheriting from Frame with methods specific to this problem
class MailWidget(tk.Frame):
    """A widget that separates a list of lines into a header and the rest, then
    cycles throught the rest while displaying the header

    Binds keys 'Left' and 'Right' to cycling through the list of info
    Binds 'Escape' to closing the window
    Binds 'r' to refreshing the widgets data
    And Binds 'Return' to opening e-mail in webbrowser"""

    def __init__(self, master=None, cnf={}, **kwds):
        # Remove MailWidget specific arguments when reading
        self.textfunc = kwds.pop('textfunc')
        self.textargs = kwds.pop('textargs')
        fontdict = kwds.pop('fontdict')
        infofont = tkfont.Font(**fontdict)
        fontdict['size'] += 2
        headerfont = tkfont.Font(**fontdict)
        super().__init__(master=master, cnf=cnf, **kwds)
        self.viewlist = []
        self.viewing = 0
        self.afterid = None
        self.headertext = tk.StringVar()
        self.intext = tk.StringVar()
        self.updatetext(self.textfunc, self.textargs)
        self.header = tk.Label(self, textvariable=self.headertext,
                               font=headerfont)
        self.info = tk.Label(self, textvariable=self.intext,
                             font=infofont, width=max(map(len, self.viewlist)))
        self.header.pack()
        self.info.pack()
        self.bindevents(master)

    # This function is only here as a helper to define other method functions
    # It has no use outside the class and will be of no use in any objects the
    # class makes. Hence it is defined in the class, used and deleted before
    # any objects are created.
    def afteriddec(function):
        """Decorator to cancel and restart the cycle update countdown after
        executing a function"""
        @wraps(function)
        def wrapper(self, *args, **kwargs):
            """Ensures that updates don't get stacked"""
            if self.afterid:
                self.master.after_cancel(self.afterid)
            function(self, *args, **kwargs)
            self.afterid = self.master.after(5000, self.cycle)
        return wrapper

    def updatetext(self, func, args):
        """Given a list of strings, set the first to the header of the widget,
        and the rest to the lines to cycle through"""
        linelist = func(*args)
        self.headertext.set(linelist[0].capitalize())
        if len(linelist) > 1:
            self.viewlist = linelist[1:]
            self.viewing = 0
            self.intext.set(self.viewlist[self.viewing])
            self.afterid = self.master.after(5000, self.cycle)

    def bindevents(self, bindwid):
        """Bind events to the root widget"""
        bindwid.bind('<Escape>', close)
        bindwid.bind('<Return>', openemail)
        bindwid.bind('<Left>', self.cycle)
        bindwid.bind('<Right>', self.cycle)
        bindwid.bind('<r>', self.refresh)

    @afteriddec
    def cycle(self, event=None):
        """Cycles the e-mail showing in the pop-up"""
        if not event:
            self.viewing += 1
        else:
            self.viewing += (event.keysym == 'Right')*2 - 1
        self.intext.set(self.viewlist[self.viewing % len(self.viewlist)])

    @afteriddec
    def refresh(self, event):
        """Function to update the text on a keybinding, just calls
        self.updatetext with function the class was initialised with"""
        self.updatetext(self.textfunc, self.textargs)

    # Remove afteriddec from the class - no object has it as a method
    del afteriddec


#
# Main
if __name__ == '__main__':
    gmail = None
    popup = False
    try:
        gmail = sys.argv[1] in gopts
    except IndexError:
        pass
    # Get Options
    # If gmail is None - nothing has been set
    # read from tty if interactive. Else assume want lancs email
    if gmail is None and sys.stdin.isatty():
        # Can read from input, as it's interactive
        option = input('Lancaster UNI e-mail, or gmail? : ')
        confile = gmailvars if option in gopts else lancsvars
    # Read the user, password and server from file
    else:
        confile = gmailvars if gmail else lancsvars
        # If not interactive, can't see the output - hence pop-up in gui
        popup = True
        emailurl = gmailurl if gmail else lancsurl
    with open(confile) as conf:
        password, user, server = (val.strip() for val in conf.read().split())

    # Login to email
    try:
        emailbox = imaplib.IMAP4_SSL(server)
        emailbox.login(user, password)
    except imaplib.IMAP4.error:
        print("Could not connect to server")
        sys.exit(0)
    else:
        atexit.register(emailbox.logout)

    # Either pop-up or show on terminal
    if popup:
        root = tk.Tk()
        myfontdict = {'family': 'Tamsyn', 'size': 9}
        mymail = MailWidget(master=root, fontdict=myfontdict,
                            textfunc=find_unread, textargs=(emailbox,))
        mymail.pack()
        root.after(10, updatesize, mymail)
        root.mainloop()
    else:
        for mess in find_unread(emailbox):
            print(mess)
