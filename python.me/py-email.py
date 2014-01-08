#!/usr/bin/env python
#By wocin
#Email ---
#-------------------I am boring line------------------------------------
import sys,smtplib
from email.mime.text import MIMEText

mailto_list=['','',]	#send_to user_list
mail_host='smtp.163.com'
mail_user=''			#your smtp_user
mail_pass=sys.argv[1]
mail_postfix='163.com'

def send_mail(send_to_list,subject,content):
    me=mail_user+"<"+mail_user+"@"+mail_postfix+">"
    msg=MIMEText(content,_subtype='plain',_charset='gb2312')
    msg['Subject']=subject
    msg['From']=me
    msg['to']=";".join(send_to_list)
    try:
		server=smtplib.SMTP()
		server.connect(mail_host)
		server.login(mail_user,mail_pass)
		server.sendmail(me,send_to_list,msg.as_string())
		server.close()
		return True
    except Exception,e:
		print str(e)
		return Flase

if __name__ == '__main__':
    content=open(sys.argv[2],'r').read()
    if send_mail(mailto_list,"mail test",content):
	print 'Success send email'
    else:
	print 'Failed to send email'