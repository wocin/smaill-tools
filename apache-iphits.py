#!/usr/bin/python
#By wocin
#Email ---
#analysis nginx ip hits or apache ip hits
#-------------------I am boring line------------------------------------
'''
log_format main '$remote_addr - $remote_user [$time_local]'
                '"$request" $status $body_bytes_sent '
                '"$http_referer" "$http_user_agent"';
'''
#-------------------I am boring line------------------------------------
import sys
def hits(logfile):
    hits={}
    contents=open(logfile,'r')
    for line in contents:
        ip=line.split(" ",1)[0]
        hits[ip]=hits.get(ip,0)+1
    return hits
logfile=sys.argv[1]
print hits(logfile)
