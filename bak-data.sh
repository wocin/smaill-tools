#!/bin/bash
#By wocin
#Email ---
#-------------------I am boring line------------------------------------
#bakup mysql
USER=''
PASSWD=''
HOST=''
BACKDIR=''
TIME="$(date +"%Y%d%m")"
MYSQL='/usr/bin/mysql'
MYSQLDUMP='/usr/bin/mysqldump'
GZIP='/bin/gzip'
alldb=`$MYSQL -u $USER -p$PASSWD -h $HOST -Bse "show databases"|grep -v "information_schema"|grep -v "mysql"|grep -v "test"`
for db in $alldb;do
    $MYSQLDUMP -u $USER -p$PASSWD $db|$GZIP -9 >$BACKDIR/$TIME-$i.gz;
done
#-------------------I am boring line------------------------------------
#backup redis
rhost=''
rport=''
rdir=`cat /etc/redis.conf|grep "dir "|awk '{print $2}'`
redis-cli -h $rhost -p $rport save
tar zcvf $BACKDIR/$TIME-redis.tar.gz $rdir/*.rdb
#-------------------I am boring line------------------------------------
