#! /usr/bin/env python3

import urllib.request
import urllib             # For BasicHTTPAuthentication
import feedparser         # For parsing the feed
from textwrap import wrap # For pretty printing assistance
import json
from os.path import expanduser
import sys
import time

_URL = "https://mail.google.com/gmail/feed/atom/unread"
WRAP_LIMIT = 50

json_data=open(expanduser('~')+'/.password.json')
data = json.load(json_data)
print(data)
