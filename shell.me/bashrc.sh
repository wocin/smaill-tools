#!/bin/bash
#By wocin
#Email ---
#-------------------I am boring line------------------------------------
ctime() {
	date -d "UTC 1970-01-01 $1 secs"
}

ne() {
	if [ $1 ]
	then
		netstat -ntlp|grep -v "grep"|grep $1
	else
		netstat -ntlp
	fi
}

psa() {
	ps -ef |grep -v "grep"|grep $1
}