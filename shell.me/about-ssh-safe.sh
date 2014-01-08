#!/bin/bash
#By wocin
#Email ---
#-------------------I am boring line------------------------------------
echo '''
*This is a private SSH service. You are not supposed to be here.*
*Please leave immediately! Thanks:)*
'''>>/usr/local/etc/ssh_banner
sed -i 's/#PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
sed -i 's/#PermitEmptyPasswords no/PermitEmptyPasswords no/' /etc/ssh/sshd_config
sed -i 's/#MaxAuthTries 6/MaxAuthTries 2/'	/etc/ssh/sshd_config
echo '''
sshd:ALL
'''>>/etc/hosts.deny
echo '''
sshd:your sshd $ip
'''>>/etc/hosts.allow
echo '''
AllowUsers	your sshd $user
Banner	/usr/local/etc/ssh_banner
'''>>/etc/ssh/sshd_config
