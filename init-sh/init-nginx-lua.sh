#!/bin/bash
#By wocin
#Email ---
#-------------------I am boring line------------------------------------
init-ngx-lua () 
{
	mkdir -p /usr/local/lnmp;cd /usr/local/lnmp
	if [ ! -d "ngx_devel_kit" ];then
		git clone https://github.com/simpl/ngx_devel_kit.git
	fi
	if [ ! -d "lua-nginx-module" ];then
		git clone https://github.com/chaoslawful/lua-nginx-module.git
	fi
	if [ ! -x "LuaJIT-2.0.0.tar.gz" ];then
		wget http://luajit.org/download/LuaJIT-2.0.0.tar.gz
	fi
	tar xvf LuaJIT-2.0.0.tar.gz
	cd LuaJIT-2.0.0
	make
	make install PREFIX=/usr/local/lj2/
	ln -s /usr/local/lj2/lib/libluajit-5.1.so.2 /lib64/
	if [ ! -x "pcre-8.34.tar.gz" ];then
		wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.34.tar.gz
	fi
	tar xvf pcre-8.34.tar.gz;cd pcre-8.34
	./configure  --prefix=/usr/local/lnmp/pcre-8.34
	make;make install
	if [ ! -x "nginx-1.5.8.tar.gz" ];then
		wget http://nginx.org/download/nginx-1.5.8.tar.gz
	fi
	tar xvf nginx-1.5.8.tar.gz;cd nginx-1.5.8
	sed -i 's/#define NGINX_VERSION      "1.5.8"/#define NGINX_VERSION      "1.1.11"/' src/core/nginx.h
	./configure --prefix=/usr/local/nginx/ --with-pcre=/usr/local/lnmp/pcre-8.34 \
	--with-http_stub_status_module --with-http_sub_module --with-http_gzip_static_module \
	--without-mail_pop3_module --without-mail_imap_module --without-mail_smtp_module  \
	--add-module=../ngx_devel_kit/ --add-module=../lua-nginx-module/
	make -j8;make install
}
init-ngx-lua
cd /usr/local/nginx/conf