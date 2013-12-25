#!/usr/bin/expect
#By wocin
#Email ---
#-------------------I am boring line------------------------------------
foreach IP {
    192.168.6.236
    192.168.6.237
    192.168.6.238
} {
spawn ssh-copy-id -i /root/.ssh/id_rsa.pub root@$IP
expect {
" password:" { send "123456\r" }
}
}
#-------------------I am boring line------------------------------------
