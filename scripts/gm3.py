#!/usr/bin/env python

## check-gmail.py -- A command line util to check GMail -*- Python -*-
## modified to display mailbox summary for conky

# ======================================================================
# Copyright (C) 2006 Baishampayan Ghose <b.ghose@ubuntu.com>
# Modified 2008 Hunter Loftis <hbloftis@uncc.edu>
# Time-stamp: Mon Jul 31, 2006 20:45+0530
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2 as
# published by the Free Software Foundation.
# Converted to Python 3 - xircon 20/12/2017
# ======================================================================

from urllib.request import FancyURLopener
import datetime
import feedparser         # For parsing the feed

now = datetime.datetime.now()

uname = "xirconuk"
password = "d14bl0002339932"
maxlen = 10

_URL = 'https://%s:%s@mail.google.com/mail/feed/atom' % (uname, password)

def auth():
    '''The method to do HTTPBasicAuthentication'''
    opener = FancyURLopener()
    f = opener.open(_URL)
    feed = f.read()
    return feed

def readmail(feed, maxlen):
    '''Parse the Atom feed and print a summary'''
    atom = feedparser.parse(feed)
    print('${color red}Mail: %s@gmail.com (%s new)' %(uname, len(atom.entries)))
    print(' Last updated: ', now.strftime("%Y-%m-%d %H:%M\n"))
    for i in range(min(len(atom.entries), maxlen)):
        print(' ${color green}"%s"' % atom.entries[i].title.encode('ascii', 'ignore'))
        print('    ${color gray}%s\n' % atom.entries[i].author.encode('ascii', 'ignore'))
    if len(atom.entries) > maxlen:
        print(' ${color0}more....')
if __name__ == "__main__":
    f = auth()  # Do auth and then get the feed
    readmail(f, int(maxlen)) # Let the feed be chewed by feedparser
