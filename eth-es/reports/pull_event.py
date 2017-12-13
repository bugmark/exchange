
#
# Logs all event data in all_events.json to the currently deployed contract
# Posts urls of rinkeby testnet on a blockchain browser to the rails app
#

import os
import json
import subprocess
from pprint import pprint
import binascii
import datetime
import hashlib

ALL_EVENTS='./eventstore.txns.json'

events = json.loads(open(ALL_EVENTS).read())

for event in events:
	if 'id' in event:
		print "found id: " + str(event['id'])

# Temporarily only logging last event
id = str(event['id'])
print "last event: " + id  

# md5 because that's what the rails app is using for this experiment
hash = str(hashlib.md5(str(event)).hexdigest())
print "hash of last event: " + hash

log_cmd = "truffle exec ../commands/log_event.js " + id + " " + hash
log_result = subprocess.check_output(log_cmd, shell=True).strip()

print log_result

log_json = json.loads(log_result)

txid = str(log_json['transactionHash'])

post_curl = "curl -X PUT --header 'Content-Type: application/x-www-form-urlencoded' --header 'Accept: text/html' "
post_id =  "-d 'id=" + id
post_url="&etherscan_url=https%3A%2F%2Frinkeby.etherscan.io%2Ftx%2F" + txid + "%23eventlog'"
post_api_url=" 'https://bugmark.net/api/v1/events'"
post_cmd = post_curl + post_id + post_url + post_api_url

post_result = subprocess.check_output(post_cmd, shell=True).strip()

print post_result



                
