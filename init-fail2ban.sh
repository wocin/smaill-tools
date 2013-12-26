#!/bin/sh
#By wocin
#Email ---
#-------------------I am boring line------------------------------------
echo '''
[atrpms] 
name=Red Hat Enterprise Linux $releasever - $basearch - ATrpms 
baseurl=http://dl.atrpms.net/el$releasever-$basearch/atrpms/stable 
gpgkey=http://ATrpms.net/RPM-GPG-KEY.atrpms 
gpgcheck=1 
enabled=1
''' >>/etc/yum.repos.d/CentOS-Base.repo
yum -y install fail2ban
sed -i 's;logtarget = SYSLOG;logtarget = /var/log/fail2ban.log;' /etc/fail2ban/fail2ban.conf

service fail2ban start
service iptables restart