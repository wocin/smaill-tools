#!/bin/bash
#By wocin
#Email ---
#-------------------I am boring line------------------------------------
#bakup mysql
database=`mysql -u root -p"" -e "show databases"|grep -v "information_schema"|grep -v "mysql"|grep -v "test"|grep -v "Database"`
for i in $database;do
    mysqldump -u root -p"" $i>/backup/$i.sql;
done
#-------------------I am boring line------------------------------------
