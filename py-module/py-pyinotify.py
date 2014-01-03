#!/usr/bin/env python
#By wocin
#Email ---
#-------------------I am boring line------------------------------------
import os
import logging
from pyinotify import WatchManager,Notifier,ProcessEvent,IN_DELETE,IN_CREATE,IN_MODIFY

class Handler(ProcessEvent):
#    logging.basicConfig(level=logging.INFO,filename='/opt/log.txt')
#    logging.info('start monitor...')

    def process_IN_CREATE(self,event):
	print 'Create file:%s' %os.path.join(event.path,event.name)
#	logging.info("Create Events : %s" %os.path.join(event.path,event.name))
    def process_IN_DELETE(self,event):
	print 'Delete file:%s' %os.path.join(event.path,event.name)
#	logging.info("Delete Events : %s" %os.path.join(event.path,event.name))
    def process_IN_MODIFY(self,event):
	print 'Modify file:%s' %os.path.join(event.path,event.name)
#	logging.info("Modify Events : %s" %os.path.join(event.path,event.name),datetime)

def Monitor(path='.'):
    wm=WatchManager()
    mask=IN_CREATE|IN_DELETE
    handler=Handler()
    notifier=Notifier(wm,handler)
    wm.add_watch(path,mask,rec=True)
    print 'now start monitor ... %s ' %path
    while True:
	try:
	    notifier.process_events()
	    if notifier.process_events():
		notifier.read_events()
	except KeyboardInterrupt:
	    notifier.stop()
	    break
if __name__ == '__main__':
    Monitor()