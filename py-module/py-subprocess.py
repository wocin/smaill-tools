#!/usr/bin/env python
#By wocin
#Email ---
#-------------------I am boring line------------------------------------
'''
subporcess.call("",shell=True)
subprocess.call(["",""])
subprocess.Popen()
'''
#config.ini
'''
[hosts]
1:192.168.6.10
2:192.168.6.20
[comds]
1:date
2:ifconfig
'''
import ConfigParser,subprocess
def readconfig(file='config.ini'):
	hostip=[]
	comdname=[]
	config=ConfigParser.ConfigParser()
	config.read(file)
	hosts=config.items('hosts')
	comds=config.items('comds')
	for host in hosts:
		hostip.append(host[1])
	for comd in comds:
		comdname.append(comd[1])
	return hostip,comdname

hostip,comdname=readconfig()
for ip in hostip:
	for comd in comdname:
		subprocess.call("ssh root@%s %s" %(ip,comd),shell=True)