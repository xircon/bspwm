#!/usr/bin/env python2

## check-gmail.py -- A command line util to check GMail -*- Python -*-
## modified to display mailbox summary for conky

# ======================================================================
# Copyright (C) 2006 Baishampayan Ghose <b.ghose@ubuntu.com>
# Modified 2008 Hunter Loftis <hbloftis@uncc.edu>
# Time-stamp: Mon Jul 31, 2006 20:45+0530
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2 as
# published by the Free Software Foundation.
# ======================================================================

import sys
import urllib             # For BasicHTTPAuthentication
import feedparser         # For parsing the feed
from textwrap import wrap

_URL = "https://mail.google.com/gmail/feed/atom"

uname = "xirconuk"
#uname = sys.argv[1]
password = "d14bl0002339932" 
#password = sys.argv[2]
#maxlen = sys.argv[3]
maxlen = 10

urllib.FancyURLopener.prompt_user_passwd = lambda self, host, realm: (uname, password)
    
def auth():
    '''The method to do HTTPBasicAuthentication'''
    opener = urllib.FancyURLopener()
    f = opener.open(_URL)
    feed = f.read()
    return feed

def readmail(feed, maxlen):
    '''Parse the Atom feed and print a summary'''
    atom = feedparser.parse(feed)
    print 'conky.config = {'
    print 'background=false,'
    print 'update_interval=1,'
    print 'double_buffer=true,'
    print 'no_buffers=true,'
    print 'imlib_cache_size=10,'
    print 'draw_shades=false,'
    print 'draw_outline=false,'
    print 'draw_borders=false,'
    print 'gap_x=80,'
    print 'gap_y=20,'
    print 'alignment="top_left",'
    print 'maximum_width=400,'
    print 'own_window=true,'
    print 'own_window_type="desktop",'
    print 'own_window_transparent = true,'
    print 'own_window_hints=\"undecorated,below,sticky,skip_taskbar,skip_pager\",'    
    print 'own_window_argb_visual=true,'
    print 'use_xft=true,'
    print 'xftalpha=1,'
    print 'text_buffer_size=256,'
    print 'override_utf8_locale=true,'
    print 'font=\"Droid Sans:size=10\",'
    print 'color0=\'80FFF9\','
    print '}'    
    print 'conky.text = [['
    print '${color}Mail: %s@gmail.com (%s new)\n' % (uname, len(atom.entries))
    for i in range(min(len(atom.entries), maxlen)):
        print(' ${color0}"%s"') % atom.entries[i].title.encode('ascii', 'ignore')
        print('    ${color lightgrey}%s\n') % atom.entries[i].author.encode('ascii', 'ignore')
    if len(atom.entries) > maxlen:
       print ' ${color0}more'
    print ']]'
if __name__ == "__main__":
    f = auth()  # Do auth and then get the feed
    readmail(f, int(maxlen)) # Let the feed be chewed by feedparser

