#!/usr/bin/env python
"""
A script to download git-remote-hg.py to my PATH without the LICENSE and README

Look at felipec/git for the git-remote-hg file
"""

import urllib.request as urlreq
import os
import stat
import re

binpath = os.environ['HOME'] + '/bin/git-remote-hg'

githgurl = 'https://raw.githubusercontent.com/felipec/git/master/git-remote-hg.py'
urlreq.urlretrieve(githgurl, binpath)

with open(binpath, 'r') as oldfile:
    lines = oldfile.readlines()
    # Arch using 'python3' as 'python'
    lines[0] = re.sub('#!/(.*)python', r'#!/\1python2', lines[0])

with open(binpath, 'w') as newfile:
    newfile.write(''.join(lines))

os.chmod(binpath, stat.S_IXUSR|stat.S_IRUSR|stat.S_IWUSR)
