
#
# Logs all event data in all_events.json to the currently deployed contract
# Posts urls of rinkeby testnet transactions, as shown by a blockchain browser, to the rails app
#

import os
import json
import subprocess
from pprint import pprint
import binascii
import datetime
import hashlib


def post_transaction(event):
        id = str(event['id'])
        #print "last event: " + id  

        # md5 because that's what the rails app is using for this experiment
        hash = str(hashlib.md5(str(event)).hexdigest())
        #print "hash of event: " + hash

        # Run the log_event command under truffle to log the hash
        #
        log_cmd = "truffle exec ../commands/log_event.js " + id + " " + hash
        log_result = subprocess.check_output(log_cmd, shell=True).strip()

        lines = log_result.splitlines()

        # The transaction id is in the last line with the occurrence of "address: "
        # truffle doesn't give it to you clean, you have to parse it out
        for line in reversed(lines):
                if "address" in line:
                        print line
                        for s in line.split("'"):
                                if "0x" in s:
                                        txid = s
                                        break;

        print "TXID " + txid

        # Post the URL of the transaction on etherscan to the rails app
        #
        post_curl = "curl -X PUT --header 'Content-Type: application/x-www-form-urlencoded' --header 'Accept: text/html' "
        post_id =  "-d 'id=" + id
        post_url="&etherscan_url=https%3A%2F%2Frinkeby.etherscan.io%2Ftx%2F" + txid + "%23eventlog'"
        post_api_url=" 'https://bugmark.net/api/v1/events'"
        post_cmd = post_curl + post_id + post_url + post_api_url

        post_result = subprocess.check_output(post_cmd, shell=True).strip()

        print "CMD: "
        print post_cmd

        print "RESULT: "
        print post_result


def main():

        ALL_EVENTS='./all_events.json'

        events = json.loads(open(ALL_EVENTS).read())

        for event in events:
                if 'id' in event:
                        post_transaction(event)
                        # print "found id: " + str(event['id'])
                

if __name__ == '__main__':
  main()
