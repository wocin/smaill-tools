#!/bin/bash
#By wocin
#Email ---
#-------------------I am boring line------------------------------------
groupadd zabbix
useradd -g zabbix zabbix
usermod -s /sbin/nologin zabbix
cd /usr/local/lnmp/
wget -v http://jaist.dl.sourceforge.net/project/zabbix/ZABBIX%20Latest%20Stable/2.2.1/zabbix-2.2.1.tar.gz
tar xvf zabbix-2.2.1.tar.gz
cd zabbix-2.2.1
./configure --enable-server --enable-agent --with-mysql --with-net-snmp -with-libcurl
make
make install
mysql -u root -p -e "create database zabbix;"
mysql -u root -p -e "grant  all on zabbix.* to 'zabbix'@'%' identified by '';"
mysql -u root -p -e "flush privileges;"
mysql -u root -p zabbix < database/mysql/schema.sql
mysql -u root -p zabbix < database/mysql/images.sql
mysql -u root -p zabbix < database/mysql/data.sql
cp misc/init.d/tru64/zabbix_server /etc/init.d/
cp misc/init.d/tru64/zabbix_agentd /etc/init.d/
chmod +x /etc/init.d/zabbix_*
chkconfig  --add zabbix_server
chkconfig  --add zabbix_agentd
echo '''
LogFile=/var/log/zabbix_server.log
DBName=zabbix
DBUser=zabbix
DBPassword=
ListenIP=192.168.1.111 #server IP
''' >/etc/zabbix/zabbix_server.conf
echo '''
PidFile=/var/log/zabbix_agentd.pid
LogFile=/var/log/zabbix_agentd.log
EnableRemoteCommands=1
Server=192.168.1.111 #server IP
Hostname=resource.seegame.com #server hostname
''' >/etc/zabbix_agentd.conf