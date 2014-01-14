#!/bin/bash
#By wocin
#Email ---
#-------------------I am boring line------------------------------------
yum -y install git
cd /opt/
git clone https://github.com/pypa/pip.git
cd pip
python setup.py install
pip install virtual -i http://pypi.v2ex.com/simple

virtualenv ../ENV
cd ../ENV
source bin/activate

pip install fabric -i http://pypi.v2ex.com/simple

echo '''
alias activate='source /opt/ENV/bin/activate'
''' >>/etc/bashrc
source /etc/bashrc
