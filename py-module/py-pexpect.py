#!/usr/bin/env python
#coding=utf8
#By wocin
#Email ---
#pip install pexpect
#类似于shell中的expect
#-------------------I am boring line------------------------------------
import pexpect,getpass,sys

def ssh_cmd(user,host,cmd):
    child=pexpect.spawn('ssh -l %s %s %s' %(user,host,cmd))
    try:
	status=child.expect(['password: ','continue connecting (yes/no)?'],timeout=5)
	if status == 0:
	    child.sendline(pwd)
	elif status == 1:
	    child.sendline('yes')
	    child.expect('password: ')
	    child.sendline(pwd)
    except pexpect.EOF:
	print 'EOF'
    except pexpect.TIMEOUT:
	print 'Timeout'
    else:
	result=child.read()
	print result
    child.close()

if __name__ == '__main__':
    user=sys.argv[1]
    host=sys.argv[2]
    cmd=sys.argv[3]
	pwd=sys.argv[4]
    print '### %s execute command: %s' %(host,cmd)
    ssh_cmd(user,host,cmd)
'''
import pexpect,os,getpass,sys
from optparse import OptionParser as oper

def ssh_cmd(user,host,cmd):
    child=pexpect.spawn('ssh -l %s %s %s' %(user,host,cmd))
    try:
	stu=child.expect(['password: ','continue connecting (yes/no)?'],timeout=5)
	if stu == 0:
	    child.sendline(pwd)
	elif stu == 1:
	    child.sendline('yes')
	    child.expect('password: ')
	    child.sendline(pwd)
    except pexpect.EOF:
	print 'EOF'
    except pexpect.TIMEOUT:
	print 'Timeout'
    else:
	sout=child.read()
	print sout
    child.close()

def local_cmd(cmd):
    child=pexpect.run(cmd).split("\n")
    for line in child:
	print line

def main():
    global pwd
    usage="usage: %prog user host command passwd"
    parser=oper(usage)
    (options,args)=parser.parse_args()
    if len(args) != 4:
	parser.error('incorrect num of args')
    user=sys.argv[1]
    host=sys.argv[2]
    cmd=sys.argv[3]
    pwd=sys.argv[4]
    print '### %s execute command: %s' %(host,cmd)
    ssh_cmd(user,host,cmd)
if __name__ == '__main__':
#    local_cmd(sys.argv[1])
    main()
'''
