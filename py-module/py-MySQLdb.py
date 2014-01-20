#!/usr/bin/env python
#By wocin
#Email ---
#-------------------I am boring line------------------------------------
#install
'''
yum install mysql-server mysql-devel gcc
git clone https://github.com/arnaudsj/mysql-python.git
sed -i 's;#mysql_config = /usr/local/bin/mysql_config;mysql_config = /usr/local/bin/mysql_config;' site.cfg
'''
import MySQLdb 
import sys

def connect(user,passwd,host,dbname):
    try:
	conn=MySQLdb.connect(host,user,passwd,charset='gb2312')
	conn.select_db(dbname)
	cur=conn.cursor()
	cur.execute(sql)
	result=cur.fetchall()
	for data in result:
	   print data
	conn.commit()
	cur.close()
	conn.close()
    except Exception,e:
	print e

def main():	
    global sql
    user=sys.argv[1]
    passwd=sys.argv[2]
    host=sys.argv[3]
    dbname=sys.argv[4]
    sqls=open(sys.argv[5],'r').readlines()
    for sql in sqls:
	connect(user,passwd,host,dbname)

if __name__ == "__main__":
    main()