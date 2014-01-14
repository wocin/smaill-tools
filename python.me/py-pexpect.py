#!/usr/bin/env python
#By wocin
#Email ---
#-------------------I am boring line------------------------------------
import sys,pexpect
from optparse import OptionParser as oper

def ssh_cmd(user,host,cmd):
    child=pexpect.spawn('ssh -l %s %s "%s"' %(user,host,cmd))
    try:
	code=child.expect(['password: ','continue connecting (yes/no)?'],timeout=5)
	if code == 0:
	    child.sendline(pwd)
	elif code == 1:
	    child.sendline('yes')
	    child.expect('password: ')
	    child.sendline(pwd)
    except pexpect.EOF:
	print "EOF"
    except pexpect.TIMEOUT:
	print 'Timeout'
    else:
	stu=child.read()
	print stu
    child.close()


def put_file(user,host,cmd_filename):
    child=pexpect.spawn('scp %s %s@%s:/tmp' %(cmd_filename,user,host))
    try:
	code=child.expect(['password: ','continue connecting (yes/no)?'],timeout=5)
	if code == 0:
	    child.sendline(pwd)
	elif code == 1:
	    child.sendline('yes')
	    child.expect('password: ')
	    child.sendline(pwd)
    except pexpect.EOF:
	print "EOF"
    except pexpect.TIMEOUT:
	print 'Timeout...'
    else:
	stu=child.read()
	print stu
    child.close()

def main():
    global pwd,user,host,cmd_filename

    usage="python expect.py ssh_cmd/put_file user hostip command/filename password"

    parser=oper(usage)
    parser.add_option("-s","--select")
    parser.add_option("-u","--user")
    parser.add_option("-i","--hostip")
    parser.add_option("-c","--cmd_or_filename")
    parser.add_option("-p","--passwd")
    (options,args)=parser.parse_args()
    if len(args) != 5:
	parser.error("incorrect num of args")

    user=sys.argv[2]
    host=sys.argv[3]
    cmd_filename=sys.argv[4]
    pwd=sys.argv[5]

    if sys.argv[1] == "ssh_cmd":
	print "###%s execute command %s###" %(host,cmd_filename)
	ssh_cmd(user,host,cmd_filename)
    if sys.argv[1] == "put_file":
	print "###put localfile %s to remote %s:/tmp###" %(cmd_filename,host)
	put_file(user,host,cmd_filename)


if __name__ == '__main__':
    main()