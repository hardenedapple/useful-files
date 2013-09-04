#!/usr/bin/env python
# coding: utf-8
'''
A simple script to check how many commits my repo is behind the one it forked
from.

It uses urllib instead of hg incoming as I haven't figured out how to trick
mercurial into thinking the process calling it is a tty. This is a problem as
the 'hg incoming' command requires authentication for this repo, and if the
terminal calling is not a tty, mercurial quits without asking for it.

Either way, I think this is probabaly a little better for this case, as it
doesn't download the changesets, just looks at the page source. And I don't
need the geneerality of not relying on bitbucket's specific web-page layout.
'''
import re
import urllib.request


def main(username, password, url):
    '''Downloads web page using authentication in parameters, searches for the
    box on bitbucket repo pages that says 'This fork is ... commits behind ..'
    returns the number of commits behind'''
    passmgr = urllib.request.HTTPPasswordMgrWithDefaultRealm()
    passmgr.add_password(None, url, username, password)
    handler = urllib.request.HTTPBasicAuthHandler(passmgr)
    opener = urllib.request.build_opener(handler)
    urllib.request.install_opener(opener)
    mypage = urllib.request.urlopen(url).read()
    pagestr = mypage.decode('utf-8')

    # Find the number of commits the fork is behind
    reg = re.compile(r'This fork is (\d+) commits behind \b[a-zA-z/_]+\b')
    return reg.findall(pagestr)


if __name__ == '__main__':
    passfile = '/home/apple/.config/passwords/bitbucket'
    with open(passfile) as passtup:
        myuser, mypass, myurl = passtup.read().split()
    print(main(myuser, mypass, myurl))
