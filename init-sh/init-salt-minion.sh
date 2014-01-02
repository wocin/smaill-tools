#!/bin/bash
#By wocin
#Email ---
#-------------------I am boring line------------------------------------
#init-salt-minion
cd /opt
wget -v http://mirrors.sohu.com/fedora-epel/6/x86_64/epel-release-6-8.noarch.rpm
rpm -ivh epel-release-6-8.noarch.rpm
yum -y install salt-minion
mv /etc/salt/minion /etc/salt/minion.bak
echo '''
master: 
master_port: 4506
''' >/etc/salt/minion
#-------------------I am boring line------------------------------------
#init-puppet-client
cd /opt
rpm -Uvh http://yum.puppetlabs.com/el/5/products/i386/puppetlabs-release-5-6.noarch.rpm
yum -y install puppet ntp