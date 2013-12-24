#!/usr/bin/python
#By wocin
#Email ---
#-------------------I am boring line------------------------------------
'''
log_format main '$remote_addr - $remote_user [$time_local]'
                '"$request" $status $body_bytes_sent '
                '"$http_referer" "$http_user_agent"';
'''
#-------------------I am boring line------------------------------------
#analysis nginx ip hits or apache ip hits
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
#-------------------I am boring line------------------------------------
#analysis status_code
def codecount(logfile):
    count={}
    content=open(logfile,'r')
    for line in content:
        code=line.split(" ")[8]
        count[code]=count.get(code,0)+1
    return count

logfile=sys.argv[1]
print codecount(logfile)
#-------------------I am boring line------------------------------------
