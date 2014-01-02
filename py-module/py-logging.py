#!/usr/bin/env python
#By wocin
#Email ---
#-------------------I am boring line------------------------------------
LEVELS={'debug':logging.DEBUG,
	'info':logging.INFO,
	'warning':logging.WARNING,
	'error':logging.ERROR,
	'critical':logging.CRITICAL,
}

if len(sys.argv)>1:
    level_name=sys.argv[1]
    level=LEVELS.get(level_name,logging.NOTSET)
    logging.basicConfig(level=level)

'''
logging.basicConfig(
	level=loging.DEBUG,
	format='%(asctime)s %(filename) %(message)s',
	datefmt='%y-%d-%m %H:%M:S',
	filemode='a'
)
'''
logging.debug('this is debug message')
logging.info('this is info message')
logging.warning('this is warning message')
logging.error('this is error message')
logging.critical('this is critical message')
