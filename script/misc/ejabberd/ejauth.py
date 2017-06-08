#!/usr/bin/python

import sys
import logging
import urllib2
from struct import *

sys.stderr = open('/tmp/extauth_error.log', 'a')
logging.basicConfig(level=logging.INFO,
                    format='%(asctime)s %(levelname)s %(message)s',
                    filename='/tmp/extauth.log',
                    filemode='a')

def from_ejabberd():
    input_length = sys.stdin.read(2)
    (size,) = unpack('>h', input_length)
    return sys.stdin.read(size).split(':')

def to_ejabberd(bool):
    answer = 0
    if bool:
        answer = 1
    token = pack('>hh', 2, answer)
    sys.stdout.write(token)
    sys.stdout.flush()

def auth(username, server, password):
    url = "http://{0}.smso.dev:3000/api/util/auth.json?token=Utpw4SUs&usr={1}&pwd={2}"
    data = urllib2.urlopen(url.format(server, username, password)).read()
    val = True if data == '"OK"' else False
    logging.info("AUTH: {0}/{1}/{2}/{3}".format(username,server,data,val))
    return val

def isuser(username, server):
    return True

def setpass(username, server, password):
    return True

logging.info("STARTING")

while True:
    data = from_ejabberd()
    success = False
    if data[0] == "auth":
        success = auth(data[1], data[2], data[3])
    elif data[0] == "isuser":
        success = isuser(data[1], data[2])
    elif data[0] == "setpass":
        success = setpass(data[1], data[2], data[3])
    to_ejabberd(success)
