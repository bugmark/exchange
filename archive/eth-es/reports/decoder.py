import os
import json
import subprocess
from pprint import pprint
import binascii
import datetime

ABI_FN='./Eventstore.abi.json'
TXNS_FN="./eventstore.txns.json"
TXNS_FNS=["./eventstore.txns.json"]

abi = json.loads(open(ABI_FN).read())

lookups = {}; # prefix to function name

for f in abi:
	if 'name' in f:
		cmd = "ethabi encode function " + ABI_FN + " " + f[u'name']
		res = subprocess.check_output(cmd, shell=True).strip()
		print f[u'name'], [i[u'type'] for i in f[u'inputs']]
		print cmd
		print res, 'wha'
		lookups[ '0x' + res ] = f

def decodeVal(typename,val):
	if typename == 'bytes32':
		return binascii.unhexlify(val)
	if typename == 'uint256':
		return int(val,16)


def decode_input(input):
        s = []
	for pfx,f in lookups.items():
		if input.startswith(pfx):
			args = input.replace(pfx,'')
			cmd = "ethabi decode params " + " ".join(["-t " + i[u'type'] for i in f[u'inputs']]) + " " + args
			res = subprocess.check_output(cmd, shell=True).strip();
			s.append(f['name']) 
			for i,l in enumerate(res.splitlines()):
				t,v = l.split()
				_arg = f[u'inputs'][i]
				s.append("  %s = %s" % (_arg[u'name'], decodeVal(t,v)))
	return "\n".join(s)		

def decode_txn(t):
        date_fmt = '%Y-%m-%d %H:%M:%S %Z%z'
        s = []
        ts = int(t[u'timeStamp'])
	dt = datetime.datetime.utcfromtimestamp(ts)
	s.append('---------------------------------')
	s.append(dt.strftime(date_fmt))
	s.append("TXN " + t[u'hash'])
        s.append( decode_input( t[u'input'] ) )
        return "\n".join(s)
        

for hpfx in ["eventstore"]:
        FN = "./%s.txns.json" % (hpfx,)
        FN_OUT = "./%s.decoded.txt" % (hpfx,)
        txns = json.loads(open(FN).read())['result']
        s = []
        for t in txns:
	        s.append( decode_txn(t) )
        with open(FN_OUT,'w') as f_out:
                f_out.write("\n".join(s))
