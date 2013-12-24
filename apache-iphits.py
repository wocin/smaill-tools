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
#version 1
#import sys
#def hits(logfile):
#    hits={}
#    contents=open(logfile,'r')
#    for line in contents:
#        ip=line.split(" ",1)[0]
#        hits[ip]=hits.get(ip,0)+1
#    return hits
##analysis status_code
#def codecount(logfile):
#    count={}
#    content=open(logfile,'r')
#    for line in content:
#        code=line.split(" ")[8]
#        count[code]=count.get(code,0)+1
#    return count

#logfile=sys.argv[1]
#print codecount(logfile)
#print hist(logfile)
#-------------------I am boring line------------------------------------
#version 2
import sys
from optparse import OptionParser as parse

def iphits(logfile):
    count={}
    hits={}
    contents=open(logfile,'r')
    for line in contents:
        ip=line.split(" ",1)[0]
        code=line.split(" ")[8]
        hits[ip]=hits.get(ip,0)+1
        count[code]=count.get(code,0)+1
    return count,hits
def main():
    usage="usage: python %prog [option] log_filename"
    parser=parse(usage)
    parser.add_option("-f",dest="log_filename",default="logfile")
    (option,args)=parser.parse_args()
    if len(args) != 1:
    	parser.error("incorrect number of args")
    hits=iphits(option.log_filename)[0]
    ips=iphits(option.log_filename)[1]
    for (k,v) in hits.items():
	print '{0:16} {1:10}'.format(k,v)

    print '#'*28

    for (k,v) in ips.items():
	print '{0:16} {1:10}'.format(k,v)
if __name__ == '__main__':
    main()
