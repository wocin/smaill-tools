#!/usr/bin/env python
#coding=utf8
#By wocin
#Email ---
#-------------------I am boring line------------------------------------
'''
usage="usage %prog [options] arg1 arg2 ..."
parser=oper(usage)
parser.add_option("��ѡ��","��ѡ��",action="",dest="����",help="����",default="Ĭ��ֵ")
(options,args)=parser.parse_args()
'''
from optparse import OptionParser as oper

def main():
	usage="usage %prog [options] args"
	parser=oper(usage)
	parser.add_option("-v","--verbose",dest="verbose")
	(options,args)=parser.parse_args()
	