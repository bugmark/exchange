import os
import sys
import subprocess
import re
import sys
import json


def trufx(command,debug=False):
    my_environment = os.environ.copy()
    p1 = subprocess.Popen([command], shell=True, env=my_environment, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    out,err = p1.communicate()
    returncode = p1.returncode
    if debug:
        print '-'*50
        print "command:", command
        print "stdout: ", out
        print "stderr: ", err
        print "returncode: ", returncode
    return out, err, returncode

class MvscEth:
    def __init__(self, debug=False):
        self.debug = debug

    def run(self,commandName,*args):
        cmd = "truffle exec commands/%s.js %s" % (commandName, " ".join([str(a) for a in args]))
        out, err, returncode = trufx(cmd, self.debug)
        if returncode == 0:
            try:
                j = json.loads(out.strip())
                return j
            except:
                return 'bad json', out
                return 0
        else:
            return 1
    
    def registerBeneficiary(self, ben_hash):
        return self.run('registerBeneficiary', ben_hash)

def repo_flow(mvsce):
    mvsce.setRepoUrl('myrepo');
    print mvsce.getRepoUrl();

def main():    
    mvsce = MvscEth(True)
    repo_flow(mvsce)

if __name__ == '__main__':
    main()

