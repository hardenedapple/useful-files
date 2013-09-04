#!/usr/bin/env python
"""
Script to print out the sender and subject of unread messages of an email.
Does not check for much in the way of errors, if there is a problem ignores it

Idea:
*   Take e-mails from somewhere (probably from lancaster university server)
*   Parse them to find the interesting ones.
*   Put them in a pop-up telling the subject and sender.
*   Make the pop-up clickable - open in browser or open in pop-up.
"""
from re import findall
from tkinter import font as tkfont
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
    res, data = mailbox.fetch(mesid, 'BODY[HEADER.FIELDS (SUBJECT FROM)]')
    if res != 'OK':
        raise RuntimeError('error in fetch call for {}'.format(mesid))
    # Apparently default character set for IMAP is UTF7
    myheads = data[0][1].decode('utf-7')

    try:
        name = findall(r'From:\s+"?([\s\w]+)"?\s+<', myheads)[0]
    except IndexError:
        # Not sure if this will work all the time - if there are any errors,
        # look here
        name = findall(r'From:.*(<.*>)\r\n', myheads)[0]  # Assume match

    subject = findall(r'Subject:\s+(.*)\r\n', myheads)[0]  # Assume match

    mailbox.store(mesid, '-FLAGS', '\\Seen')
    return ' '.join((name, ':', subject))


def find_unread(mailbox):
    """Get emails unread, print message subjects and senders"""
    # While I agree with the best practice of converting bytes into strings
    # early, I want to use this once, so easier to keep as bytes

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
def setbindings(widget, escapefunc, arrowfunc, retfunc):
    """Set bindings for a widget"""
    # Now want the option to open up that e-mail in the browser
    widget.wm_title('E-mail messages')
    widget.bind('<Escape>', escapefunc)
    widget.bind('<Left>', arrowfunc)
    widget.bind('<Right>', arrowfunc)
    widget.bind('<Return>', retfunc)


def updatesize(frame):
    """Set the size for the frame widget"""
    winwid, winhgt = frame.winfo_width(), frame.winfo_height()
    scrwid, scrhgt = frame.winfo_screenwidth(), frame.winfo_screenheight()
    newx, newy = math.floor(scrwid * 0.99) - winwid, math.floor(scrhgt * 0.01)
    frame.master.geometry("{}x{}+{}+{}".format(winwid, winhgt, newx, newy))


def close(event):
    """Remove the window"""
    event.widget.destroy()


def openemail(event):
    """Open e-mail in browser and close pop-up"""
    import webbrowser
    webbrowser.open(emailurl)
    close(event)


def create_popup(linelist):
    """Creates a pop-up that scrolls over the lines in a list."""
    root = tk.Tk()
    frame = tk.Frame(master=root)
    frame.pack()

    # Define the font and set the text variables
    headertext = linelist[0].capitalize()
    fontname = '-*-tamsyn-medium-r-normal-*-12-*-*-*-*-*-iso8859-1'
    # Define the different fonts
    myfont = tkfont.Font(root, fontname)
    titlefont = tkfont.Font(root, fontname.replace('12', '14'))
    # Define header label
    infotitle = tk.Label(frame, text=headertext, font=titlefont)
    infotitle.pack(side=tk.TOP)
    # If there are messages, add the message label
    if len(linelist) > 1:
        viewlist = linelist[1:]
        viewing = 0
        intext = tk.StringVar()
        intext.set(viewlist[viewing])
        infolabel = tk.Label(frame, textvariable=intext, font=myfont,
                            width=max(map(len, viewlist)))

        # Define event handling functions
        def update(event=None):
            """Updates the text in the pop-up every 5 seconds"""
            # Use the viewing variable from enclosed scope
            nonlocal viewing, afterid
            # So the event loops don't build up
            root.after_cancel(afterid)
            # incval = 1 if viewing < len(viewlist)-1 else -(len(viewlist)-1)
            # decval = -1 if viewing > 0 else len(viewlist) - 1
            if not event:
                viewing += 1
                # viewing += incval
            else:
                viewing += (event.keysym == 'Right')*2 - 1
                # viewing += decval if event.keysym == 'Left' else incval
            intext.set(viewlist[viewing % len(viewlist)])
            afterid = root.after(5000, update)

        # Set up the root widget
        setbindings(root, close, update, openemail)
        infolabel.pack()
        afterid = root.after(5000, update)

    else:
        setbindings(root, close, openemail, close)

    root.after(10, updatesize, frame)
    root.mainloop()


#
# Main
if __name__ == '__main__':
    gmail = None
    popup = False
    try:
        gmail = sys.argv[1] in gopts
    except IndexError:
        pass
    # If gmail is None - nothing has been set
    # read from tty if interactive. Else assume want lancs email
    if gmail == None and sys.stdin.isatty():
        # Can read from input, as it's interactive
        option = input('Lancaster UNI e-mail, or gmail? : ')
        confile = gmailvars if option in gopts else lancsvars
    # Read the user, password and server from file
    else:
        confile = gmailvars if gmail else lancsvars
        # If not interactive, can't see the output - hance pop-up in gui
        popup = True
        emailurl = gmailurl if gmail else lancsurl
    with open(confile) as conf:
        password, user, server = (val.strip() for val in conf.read().split())

    try:
        emailbox = imaplib.IMAP4_SSL(server)
        emailbox.login(user, password)
    except imaplib.IMAP4.error:
        print("Could not connect to server")
        sys.exit(0)
    else:
        atexit.register(emailbox.logout)

    if popup:
        create_popup(find_unread(emailbox))
    else:
        print(find_unread(emailbox))
