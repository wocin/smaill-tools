#!/usr/bin/env python
#coding=utf8
#By wocin
#Email ---
#-------------------I am boring line------------------------------------
import sys
def count():
	for line in logs:
        ip=line.split()[0]
        flow=line.split()[9]
        if ip in set(k.lower() for k in ipflow):
            ipnum[ip]+=1
            ipflow[ip] =int(ipflow[ip]) +int(flow)
        else:
            ipnum[ip]=1
            ipflow[ip]=int(flow)
def prints():
	for k in ipnum:
        print "访问的IP是: %s 访问次数: %d 流量: %.3fM" %(k,int(ipnum[k]),float(ipflow[k])/float(1000))
if __name__ == '__main__':
	ipflow={}
    ipnum={}
    f=open(sys.argv[1],'r')
    logs=f.readlines()
    f.close()
    count()
	prints()