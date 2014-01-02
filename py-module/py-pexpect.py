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