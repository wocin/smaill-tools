#!/usr/bin/python
#By wocin
#Email ---
#-------------------I am boring line------------------------------------
from fabric.api import *
from fabric.colors import *
from fabric.context_managers import *

env.roledefs={'hosts':['192.168.6.236','192.168.6.238','192.168.6.235']}
env.passwords={'192.168.6.236':"123456",'192.168.6.237':"123456",'192.168.6.238':"123456"}

def createkeys():
   local('ssh-keygen -t rsa')
   print(red('created sshkey ok!'))
@roles('hosts')
def putkeys():
   put("/root/.ssh/id_rsa.pub","/root/.ssh/authorized_keys")

def all():
   execute(createkeys)
   execute(putkeys)
