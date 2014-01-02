#!/bin/bash
#By wocin
#Email ---
#-------------------I am boring line------------------------------------
yum -y install git
cd /opt/
git clone https://github.com/pypa/virtualenv.git
cd virtualenv
python setup.py install
virtualenv ../ENV
cd ../ENV
source bin/activate
git clone https://github.com/fabric/fabric.git
cd fabric
python setup.py install

echo '''
alias activate='source /opt/ENV/bin/acticate'
''' >>/etc/bashrc
source /etc/bashrc
