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

githgurl = 'https://raw.githubusercontent.com/felipec/git-remote-hg/master/git-remote-hg'
urlreq.urlretrieve(githgurl, binpath)

os.chmod(binpath, stat.S_IXUSR|stat.S_IRUSR|stat.S_IWUSR)
