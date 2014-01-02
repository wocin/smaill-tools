#!/bin/bash
#By wocin
#Email ---
#-------------------I am boring line------------------------------------
#init pcre for nginx
mkdir /usr/local/lnmp/
cd /usr/local/lnmp/
wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.34.tar.gz
tar xvf pcre-8.34.tar.gz
cd pcre-8.34
./configure     --prefix=/usr/local/lnmp/pcre-8.34
make
make install
#-------------------I am boring line------------------------------------
#init nginx
groupadd nginx
useradd -g nginx nginx
usermod -s /sbin/nologin nginx
mkdir /usr/local/nginx
cd /usr/local/lnmp/
wget http://nginx.org/download/nginx-1.5.8.tar.gz
tar xvf nginx-1.5.8.tar.gz
cd /usr/local/lnmp/nginx-1.5.8
sed -i 's/#define NGINX_VERSION      "1.5.8"/#define NGINX_VERSION      "1.1.11"/' src/core/nginx.h
./configure        --prefix=/usr/local/nginx --with-pcre=/usr/local/lnmp/pcre-8.34 --with-http_stub_status_module \
--with-http_ssl_module --with-http_flv_module --with-http_dav_module \
--with-http_gzip_static_module --with-debug --user=nginx --group=nginx 
make
make install
mkdir /usr/local/nginx/conf.d
#-------------------I am boring line------------------------------------
echo '''
#!/bin/bash
# Startup script for the nginx Web Server
# chkconfig: - 85 15
# description: nginx is a World Wide Web server. It is used to serve
# processname: nginx
nginxd=/usr/local/nginx/sbin/nginx
nginx_config=/usr/local/nginx/conf/nginx.conf
nginx_pid=/usr/local/nginx/logs/nginx.pid
 
REIVAL=0
prog="nginx"
 
. /etc/rc.d/init.d/functions
 
. /etc/sysconfig/network
 
[ ${NETWORKING} = "no" ] && exit 0
[ -x $nginxd ] || exit 0
 
start() {
if [ -e $nginx_pid ];then
    echo "nginx already running..."
    exit 1
fi
    echo -n $"starting $prog: "
    daemon $nginxd -c ${nginx_config}
    RETVAL=$?
    echo
    [ $RETVAL = 0 ] && touch /usr/local/nginx/logs/nginx
    return $RETVAL
}
 
stop() {
    echo -n $"stoping $prog: "
    killproc $nginxd
    RETVAL=$?
    echo
    [ $RETVAL = 0 ] && rm -f /usr/local/nginx/logs/nginx /usr/local/nginx/logs/nginx.pid
}
reload() {
    echo -n $"reloading $prog: "
    $nginxd -s reload
    RETVAL=$?
    echo
}
case "$1" in
start)
    start
    ;;
stop)
    stop
    ;;
reload)
    reload
    ;;
restart)
    stop
    start
    ;;
status)
    status $prog
    RETVAL=$?
    ;;
*)
    echo $"Usage: $prog {start|stop|restart|reload|status}"
    exit 1
esac
exit $RETVAL
''' >> /etc/init.d/nginx
chmod +x /etc/init.d/nginx
chkconfig --add nginx
chkconfig nginx on
chown nginx /usr/local/nginx -R
#-------------------I am boring line------------------------------------
mkdir /usr/local/php/
mkdir /usr/local/php/tmp
mkdir /var/log/php/
chmod 777 /usr/local/php/tmp
cd /usr/local/lnmp/
wget http://cn2.php.net/distributions/php-5.5.1.tar.gz
tar xvf php-5.5.1.tar.gz
cd /usr/local/lnmp/php-5.5.1
./configure --prefix=/usr/local/php --with-mysql --with-mysqli \
--enable-xml --enable-bcmath --enable-fastcgi --enable-fpm --enable-zip  \
--with-gd --with-freetype-dir --with-jpeg-dir --with-png-dir --enable-mbstring \
--enable-sockets --with-gettext 
make 
make install
#-------------------I am boring line------------------------------------
cd /usr/local/lnmp/php-5.5.1
cp php.ini-production /usr/local/php/lib/php.ini
cp /usr/local/php/etc/php-fpm.conf.default /usr/local/php/etc/php-fpm.conf
#-------------------I am boring line------------------------------------
cd /usr/local/lnmp/php-5.5.1/ext/curl
/usr/local/php/bin/phpize 
./configure --with-php-config=/usr/local/php/bin/php-config
make
make install 
#-------------------I am boring line------------------------------------
cd /usr/local/lnmp/php-5.5.1/ext/pdo_mysql
/usr/local/php/bin/phpize 
./configure --with-php-config=/usr/local/php/bin/php-config
make
make install
#-------------------I am boring line------------------------------------
echo '''
#!/bin/bash
# Startup script for the php-fpm Server
# chkconfig: - 85 15
# description: PHP-FPM is an PHPFastCGI manager, is only used for PHP 
# processname: php-fpm
phpfpm=/usr/local/php/sbin/php-fpm
 
REIVAL=0
prog="php-fpm"
 
. /etc/rc.d/init.d/functions
 
. /etc/sysconfig/network
 
[ ${NETWORKING} = "no" ] && exit 0

 
start() {
    echo -n $"starting $prog: "
    daemon $phpfpm
    RETVAL=$?
    echo
    [ $RETVAL = 0 ] 
}
 
stop() {
    echo -n $"stoping $prog: "
    killproc php-fpm
    RETVAL=$?
    echo
    [ $RETVAL = 0 ] 
}

case "$1" in
start)
    start
    ;;
stop)
    stop
    ;;
restart)
    stop
    start
    ;;
*)
    echo $"Usage: $prog {start|stop|restart}"
    exit 1
esac
exit $RETVAL
''' > /etc/init.d/php-fpm
chmod +x /etc/init.d/php-fpm
chkconfig --add php-fpm
chkconfig php-fpm on
#-------------------I am boring line------------------------------------
echo '''
PATH=$PATH:/usr/local/php/bin/
''' >> /etc/profile
source /etc/profile
sed -i '730 a\extension_dir="/usr/local/php/lib/php/extensions/no-debug-non-zts-20121212/"' /usr/local/php/lib/php.ini
sed -i '/date.timezone =/a\date.timezone = Asia/Shanghai' /usr/local/php/lib/php.ini
sed -i '/log_errors = On/a\error_log = /var/log/php/' php.ini
sed -i 's/expose_php = On/expose_php = Off/' /usr/local/php/lib/php.ini
sed -i 's/allow_url_fopen = On/allow_url_fopen = Off/'  /usr/local/php/lib/php.ini
sed -i 's/disable_functions =/disable_function = "symlink,shell_exec,exec,proc_close,proc_open,popen,system,dl,passthru,escapeshellarg,escapeshellcmd"/' /usr/local/php/lib/php.ini
sed -i 's/;session.save_path = "\/tmp"/session.save_path = "\/tmp"/' /usr/local/php/lib/php.ini
sed -i '731 a\extension="pdo_mysql.so"'  /usr/local/php/lib/php.ini
sed -i '732 a\extension="curl.so"'  /usr/local/php/lib/php.ini
#-------------------I am boring line------------------------------------
mkdir /usr/local/varnish/
yum -y install pcre pcre-devel
cd /usr/local/lnmp/
wget -v http://repo.varnish-cache.org/source/varnish-3.0.0.tar.gz
tar xvf varnish-3.0.0.tar.gz
cd varnish-3.0.0
./configure --prefix=/usr/local/varnish/ PKG_CONFIG_PATH=/usr/lib/pkgconfig
make
make install
#-------------------I am boring line------------------------------------
groupadd varnish
useradd -g varnish varnish
mkdir /usr/local/varnish/var/varnish/vcache
mkdir /usr/local/varnish/var/varnish/vlogs
chown -R varnish:varnish /usr/local/varnish/
chmod +w /usr/local/varnish/var/varnish/vcache
#-------------------I am boring line------------------------------------
echo '''
#! /bin/sh
#
# varnish Control the varnish HTTP accelerator
#
# chkconfig: - 90 10
# description: Varnish is a high-perfomance HTTP accelerator
# processname: varnishd
# config: /etc/sysconfig/varnish
# pidfile: /var/run/varnishd.pid

### BEGIN INIT INFO
# Provides: varnish
# Required-Start: $network $local_fs $remote_fs
# Required-Stop: $network $local_fs $remote_fs
# Default-Start:
# Default-Stop:
# Should-Start: $syslog
# Short-Description: start and stop varnishd
# Description: Varnish is a high-perfomance HTTP accelerator
### END INIT INFO

# Source function library.
. /etc/init.d/functions

retval=0
pidfile=/var/run/varnish.pid

exec="/usr/local/varnish/sbin/varnishd"
reload_exec="/usr/local/varnish/sbin/varnish_reload_vcl"
prog="varnishd"
config="/etc/sysconfig/varnish"
lockfile="/var/lock/subsys/varnish"

# Include varnish defaults
[ -e /etc/sysconfig/varnish ] && . /etc/sysconfig/varnish


start() {

        if [ ! -x $exec ]
        then
                echo $exec not found
                exit 5
        fi

        if [ ! -f $config ]
        then
                echo $config not found
                exit 6
        fi
        echo -n "Starting varnish HTTP accelerator: "

        # Open files (usually 1024, which is way too small for varnish)
        ulimit -n ${NFILES:-131072}

        # Varnish wants to lock shared memory log in memory. 
        ulimit -l ${MEMLOCK:-82000}

        # $DAEMON_OPTS is set in /etc/sysconfig/varnish. At least, one
        # has to set up a backend, or /tmp will be used, which is a bad idea.
        if [ "$DAEMON_OPTS" = "" ]; then
                echo "\$DAEMON_OPTS empty."
                echo -n "Please put configuration options in $config"
                return 6
        else
                # Varnish always gives output on STDOUT
                daemon --pidfile $pidfile  $exec -P $pidfile "$DAEMON_OPTS" > /dev/null 2>&1
                retval=$?
                if [ $retval -eq 0 ]
                then
                        touch $lockfile
                        echo_success
                        echo
                else
                        echo_failure
                        echo
                fi
                return $retval
        fi
}

stop() {
        echo -n "Stopping varnish HTTP accelerator: "
        killproc -p $pidfile $prog
        retval=$?
        echo
        [ $retval -eq 0 ] && rm -f $lockfile
        return $retval
}

restart() {
        stop
        start
}

rh_status() {
        status -p $pidfile $prog
}

rh_status_q() {
        rh_status >/dev/null 2>&1
}

# See how we were called.
case "$1" in
        start)
                rh_status_q && exit 0
                $1
                ;;
        stop)
                rh_status_q || exit 0
                $1
                ;;
        restart)
                $1
                ;;
        status)
                rh_status
                ;;
        *)
        echo "Usage: $0 {start|stop|status|restart}"

        exit 2
esac

exit $?
''' >/etc/init.d/varnish
chmod +x /etc/init.d/varnish
chkconfig --add varnish
#-------------------I am boring line------------------------------------
echo '''
# Configuration file for varnish
#
# /etc/init.d/varnish expects the variable $DAEMON_OPTS to be set from this
# shell script fragment.
#

# Maximum number of open files (for ulimit -n)
NFILES=131072

# Locked shared memory (for ulimit -l)
# Default log size is 82MB + header
MEMLOCK=82000

# Maximum size of corefile (for ulimit -c). Default in Fedora is 0
# DAEMON_COREFILE_LIMIT="unlimited"

# Set this to 1 to make init script reload try to switch vcl without restart.
# To make this work, you need to set the following variables
# explicit: VARNISH_VCL_CONF, VARNISH_ADMIN_LISTEN_ADDRESS,
# VARNISH_ADMIN_LISTEN_PORT, VARNISH_SECRET_FILE, or in short,
# use Alternative 3, Advanced configuration, below
RELOAD_VCL=1

# This file contains 4 alternatives, please use only one.

## Alternative 1, Minimal configuration, no VCL
#
# Listen on port 6081, administration on localhost:6082, and forward to
# content server on localhost:8080.  Use a fixed-size cache file.
#
#DAEMON_OPTS="-a :6081 \
#             -T localhost:6082 \
#             -b localhost:8080 \
#             -u varnish -g varnish \
#             -s file,/var/lib/varnish/varnish_storage.bin,1G"


## Alternative 2, Configuration with VCL
#
# Listen on port 6081, administration on localhost:6082, and forward to
# one content server selected by the vcl file, based on the request.  Use a
# fixed-size cache file.
#
#DAEMON_OPTS="-a :6081 \
#             -T localhost:6082 \
#             -f /etc/varnish/default.vcl \
#             -u varnish -g varnish \
#             -S /etc/varnish/secret \
#             -s file,/var/lib/varnish/varnish_storage.bin,1G"


## Alternative 3, Advanced configuration
#
# See varnishd(1) for more information.
#
# # Main configuration file. You probably want to change it :)
VARNISH_VCL_CONF=/usr/local/varnish/etc/varnish/default.vcl
#
# # Default address and port to bind to
# # Blank address means all IPv4 and IPv6 interfaces, otherwise specify
# # a host name, an IPv4 dotted quad, or an IPv6 address in brackets.
# VARNISH_LISTEN_ADDRESS=
VARNISH_LISTEN_PORT=6081
#
# # Telnet admin interface listen address and port
VARNISH_ADMIN_LISTEN_ADDRESS=127.0.0.1
VARNISH_ADMIN_LISTEN_PORT=6082
#
# # Shared secret file for admin interface
VARNISH_SECRET_FILE=/etc/varnish/secret
#
# # The minimum number of worker threads to start
VARNISH_MIN_THREADS=1
#
# # The Maximum number of worker threads to start
VARNISH_MAX_THREADS=1000
#
# # Idle timeout for worker threads
VARNISH_THREAD_TIMEOUT=120
#
# # Cache file location
VARNISH_STORAGE_FILE=/usr/local/varnish/var/varnish/vcache/varnish_storage.bin
#
# # Cache file size: in bytes, optionally using k / M / G / T suffix,
# # or in percentage of available disk space using the % suffix.
VARNISH_STORAGE_SIZE=1G
#
# # Backend storage specification
VARNISH_STORAGE="file,${VARNISH_STORAGE_FILE},${VARNISH_STORAGE_SIZE}"
#
# # Default TTL used when the backend does not specify one
VARNISH_TTL=120
#
# # DAEMON_OPTS is used by the init script.  If you add or remove options, make
# # sure you update this section, too.
DAEMON_OPTS="-a ${VARNISH_LISTEN_ADDRESS}:${VARNISH_LISTEN_PORT} \
             -f ${VARNISH_VCL_CONF} \
             -T ${VARNISH_ADMIN_LISTEN_ADDRESS}:${VARNISH_ADMIN_LISTEN_PORT} \
             -t ${VARNISH_TTL} \
             -w ${VARNISH_MIN_THREADS},${VARNISH_MAX_THREADS},${VARNISH_THREAD_TIMEOUT} \
             -u varnish -g varnish \
#             -S ${VARNISH_SECRET_FILE} \
             -s ${VARNISH_STORAGE}"
#

## Alternative 4, Do It Yourself. See varnishd(1) for more information.
#
# DAEMON_OPTS="" 
''' >/etc/sysconfig/varnish
#-------------------I am boring line------------------------------------
