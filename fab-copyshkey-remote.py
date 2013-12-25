#!/usr/bin/python
#By wocin
#Email ---
#-------------------I am boring line------------------------------------
from fabric.api import *
from fabric.colors import *
from fabric.context_managers import *

env.roledefs={'host1':['root@192.168.6.236'],'host2':['root@192.168.6.238'],'host3':['root@192.168.6.235']}
env.passwords={'host1':"123456",'host2':"123456",'host3':"123456"}

@roles('host1')
def putkeys1():
   put("/root/.ssh/id_rsa.pub","/root/.ssh/authorized_keys")
#   run('mv /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys')

@roles('host2')
def putkeys2():
   put("/root/.ssh/id_rsa.pub","/root/.ssh/authorized_keys")
#   run('mv /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys')

@roles('host3')
def putkeys3():
   put("/root/.ssh/id_rsa.pub","/root/.ssh/authorized_keys")
#   run('mv /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys')

def all():
    execute(putkeys1)
    execute(putkeys2)
    execute(putkeys3)
