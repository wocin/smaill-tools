#!/bin/bash
#By wocin
#Email ---
#-------------------I am boring line------------------------------------
#server
rpm -Uvh http://yum.puppetlabs.com/el/5/products/i386/puppetlabs-release-5-6.noarch.rpm
yum -y install puppet-server ntp
echo '''
192.168.6.100 client.example.com
192.168.6.110 server.example.com
''' >>/etc/hosts
/etc/init.d/puppetmaster start
chkconfig puppetmaster on
#-------------------I am boring line------------------------------------
#client
rpm -Uvh http://yum.puppetlabs.com/el/5/products/i386/puppetlabs-release-5-6.noarch.rpm
yum -y install puppet ntp
echo '''
192.168.6.100 client.example.com
192.168.6.110 server.example.com
''' >>/etc/hosts
/etc/init.d/puppet start
chkconfig puppet on
#-------------------I am boring line------------------------------------
#client command
puppet agent --server server.example.com --test
#server command
puppet cert --list
puppet cert -s client.example.com
#-------------------I am boring line------------------------------------
echo '''
node default {
file {
	"/tmp/file-test.txt":content => "puppet test";
	}
}
'''> /etc/puppet/mainiftests/site.pp
