"""
Script to print out the sender and subject of unread messages of an email.
Does not check for much in the way of errors, if there is a problem ignores it

Idea:
*   Take e-mails from somewhere (probably from lancaster university server)
*   Parse them to find the interesting ones.
*   Put them in a pop-up telling the subject and sender.
*   Make the pop-up clickable - open in browser or open in pop-up.
"""
import atexit
import imaplib
import re
import sys

gopts = ['gmail', 'g', '2', 'home', 'h']
gmailvars = '/home/apple/.config/passwords/gmailpass'
lancsvars = '/home/apple/.config/passwords/lancspass'
gmail = None


def print_unread(mailbox):
    """Get emails unread, print message subjects and senders"""
    # While I agree with the best practice of converting bytes into strings
    # early, I want to use this once, so easier to keep as bytes
    numunseen = re.findall(rb'\d+', mailbox.status('Inbox', '(UNSEEN)')[1][0])
    if numunseen == b'0':
        print('No messages')
        return

    mailbox.select('inbox')
    res, data = mailbox.search(None, 'UNSEEN')
    if res != 'OK':
        print('error in search call')
        return
    unseen = data[0].split()
    print(user, 'has {} new messages'.format(len(unseen)))

    for mesid in unseen:
        res, data = mailbox.fetch(mesid, 'BODY[HEADER.FIELDS (SUBJECT FROM)]')
        if res != 'OK':
            print('error in fetch call for {}'.format(mesid))
            continue
        # Apparently default character set for IMAP is UTF7
        myheads = data[0][1].decode('utf-7')
        endfrom = myheads.find('\r')

        try:
            name = re.findall(r'\s(.*)\s+<',
                              myheads[:endfrom])[0].replace('"', '')
        except IndexError:
            name = re.sub(r'From: (.*)', r'\1', myheads[:endfrom])

        subject = re.sub(r'\r\nSubject: (.*)\r\n\r\n', r'\1', myheads[endfrom:])

        print(name + ':', subject)
        mailbox.store(mesid, '-FLAGS', '\\Seen')


if __name__ == '__main__':
    try:
        gmail = sys.argv[1] in gopts
    except IndexError:
        pass
    # Read the user, password and server from file
    if gmail == None:
        option = input('Lacaster UNI e-mail, or gmail? : ')
        confile = gmailvars if option in gopts else lancsvars
    else:
        confile = gmailvars if gmail else lancsvars
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

    print_unread(emailbox)
