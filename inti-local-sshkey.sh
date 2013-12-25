#!/bin/bash
#By wocin
#Email ---
#-------------------I am boring line------------------------------------
yum -y install expect
passwd='123456'
expect -c "
    set timeout 3;
    spawn /usr/bin/ssh-keygen -t rsa
    expect \"id_rsa):\" {send \"\n\";};
    sleep 1;
    expect \" passphrase):\" {send \"\n\";};
    sleep 1;
    expect \" again:\" {send \"\n\";};
    spawn /usr/bin/ssh-copy-id -i /root/.ssh/id_rsa.pub root@192.168.6.236;
    expect \" (yes/no)?\" { send \"yes\r\";};
    sleep 1;
    expect \" password:\" {send \"$passwd\r\";};
    expect eof;"
#-------------------I am boring line------------------------------------
