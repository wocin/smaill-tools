#!/bin/bash
#By wocin
#Email ---
#-------------------I am boring line------------------------------------
#init-salt-master
cd /opt
wget http://mirrors.sohu.com/fedora-epel/6/x86_64/epel-release-6-8.noarch.rpm
rpm -ivh epel-release-6-8.noarch.rpm
yum -y install salt-master
mkdir /srv/salt/ -p 
mkdir /srv/salt/shell -p
echo '''
base:
 '*':
  - shell
''' >/srv/salt/top.sls
mv /etc/salt/master /etc/salt/master.bak
echo '''
interface: 0.0.0.0
file_roots:
  base:
    - /srv/salt
''' > /etc/salt/master
service salt-master start
#-------------------I am boring line------------------------------------
#init-puppet-master
cd /opt
rpm -Uvh http://yum.puppetlabs.com/el/5/products/i386/puppetlabs-release-5-6.noarch.rpm
yum -y install puppet-server ntp
