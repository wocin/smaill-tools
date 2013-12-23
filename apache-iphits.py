#!/usr/bin/python
#By wocin
#Email ---
#-------------------I am boring line------------------------------------
def calApacheIpHits(logfile):
    iphits={}
    contents=open(logfile,'r')
    for line in contents:
        ip=line.split(" ",1)[0]
        if 6<ip<=15:
            iphits[ip]=iphits.get(ip,0)+1
    return iphits
#-------------------I am boring line------------------------------------
