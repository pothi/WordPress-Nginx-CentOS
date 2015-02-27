#!/bin/bash

# What it is: a script to compile and install nginx manually in Ubuntu 12.04 server. It may (not) work with Debian.
# Author: Pothi Kalimuthu
# Author URL: http://pothi.info
# License: GPL v2

### VARIABLES ###
# Please know that this script requires __sudo__ privileges.

# You can get the version number/s at http://nginx.org
NGX_VER="1.6.2"

# username underwhich nginx would run. make sure it has read permission on all sites
NGX_USER="nginx"
NGX_GROUP="nginx"

# The following modules are automatically compiled in unless explicitly disabled
# if you don't want any of these, please disable them by changing "no" to "yes"
# you do not want to disable any of these, unless you know what you are doing
DISABLE_HTTP_CORE_MODULE="no"
DISABLE_HTTP_ACCESS_MODULE="no"
DISABLE_HTTP_AUTH_BASIC_MODULE="no"
DISABLE_HTTP_AUTOINDEX_MODULE="no"
DISABLE_HTTP_BROWSER_MODULE="no"
DISABLE_HTTP_CHARSET_MODULE="no"
DISABLE_HTTP_EMPTY_GIF_MODULE="no"
DISABLE_HTTP_FASTCGI_MODULE="no"
DISABLE_HTTP_GEO_MODULE="no"
DISABLE_HTTP_GZIP_MODULE="no"
DISABLE_HTTP_LIMIT_REQ_MODULE="no"
DISABLE_HTTP_LIMIT_CONN_MODULE="no"
DISABLE_HTTP_MAP_MODULE="no"
DISABLE_HTTP_MEMCACHED_MODULE="no"
DISABLE_HTTP_PROXY_MODULE="no"
DISABLE_HTTP_REFERER_MODULE="no"
DISABLE_HTTP_REWRITE_MODULE="no"
DISABLE_HTTP_SCGI_MODULE="yes"
DISABLE_HTTP_SPLIT_CLIENTS_MODULE="no"
DISABLE_HTTP_SSI_MODULE="no"
DISABLE_HTTP_UPSTREAM_MODULE="no"
DISABLE_HTTP_USERID_MODULE="no"
DISABLE_HTTP_UWSGI_MODULE="no"

# In the following lines, if you require a particular module, please choose yes
# If a module is already selected and if you don't want it, please choose no
# also update the version numbers, whenever available
# if no version number is available for a particular module, it is a built-in module or a feature
INCLUDE_DEBUG_MODULE="no"

INCLUDE_HTTP_GZIP_STATIC_MODULE="yes"
INCLUDE_HTTP_SPDY_MODULE="yes"
INCLUDE_HTTP_SSL_MODULE="yes"
INCLUDE_HTTP_SUB_MODULE="yes"

INCLUDE_PAGESPEED_MODULE="no"
VERSION_PAGESPEED_MODULE="1.7.30.1"

# You may change the name of the nginx binary here so avoid conflicts with the existing binary
NGX_BIN="nginx_c"
PID_PATH="/var/run/$NGX_BIN.pid"

HIGH_TRAFFIC_SITE="yes"

#-------- END OF VARIABLES ----------#

# This may change, depending on your requirement.
# The following _may_ fit most use-cases
# Ref: http://nginx.org/en/docs/configure.html
BASE_CONFIG_OPTIONS="
                        --prefix=/usr/local/$NGX_BIN-$NGX_VER
                        --sbin-path=/usr/sbin/$NGX_BIN
                        --conf-path=/etc/$NGX_BIN/nginx.conf
                        --pid-path=$PID_PATH
                        --error-log-path=/var/log/$NGX_BIN/error.log
                        --http-log-path=/var/log/$NGX_BIN/access.log
			--user=$NGX_USER
			--group=$NGX_GROUP
                        "

# --lock-path=/var/run/subsys/nginx_c

CONFIG_OPTIONS=$BASE_CONFIG_OPTIONS

# Modules enabled by default
if [ $DISABLE_HTTP_CORE_MODULE == 'yes' ]; then
	CONFIG_OPTIONS="$CONFIG_OPTIONS --without-http_core_module"
fi

if [ $DISABLE_HTTP_ACCESS_MODULE == 'yes' ]; then
	CONFIG_OPTIONS="$CONFIG_OPTIONS --without-http_access_module"
fi

if [ $DISABLE_HTTP_AUTH_BASIC_MODULE == 'yes' ]; then
	CONFIG_OPTIONS="$CONFIG_OPTIONS --without-http_auth_basic_module"
fi

if [ $DISABLE_HTTP_AUTOINDEX_MODULE == 'yes' ]; then
	CONFIG_OPTIONS="$CONFIG_OPTIONS --without-http_autoindex_module"
fi

if [ $DISABLE_HTTP_BROWSER_MODULE == 'yes' ]; then
	CONFIG_OPTIONS="$CONFIG_OPTIONS --without-http_browser_module"
fi

if [ $DISABLE_HTTP_CHARSET_MODULE == 'yes' ]; then
	CONFIG_OPTIONS="$CONFIG_OPTIONS --without-http_charset_module"
fi

if [ $DISABLE_HTTP_EMPTY_GIF_MODULE == 'yes' ]; then
	CONFIG_OPTIONS="$CONFIG_OPTIONS --without-http_empty_gif_module"
fi

if [ $DISABLE_HTTP_FASTCGI_MODULE == 'yes' ]; then
	CONFIG_OPTIONS="$CONFIG_OPTIONS --without-http_fastcgi_module"
fi

if [ $DISABLE_HTTP_GEO_MODULE == 'yes' ]; then
	CONFIG_OPTIONS="$CONFIG_OPTIONS --without-http_geo_module"
fi

if [ $DISABLE_HTTP_GZIP_MODULE == 'yes' ]; then
	CONFIG_OPTIONS="$CONFIG_OPTIONS --without-http_gzip_module"
fi

if [ $DISABLE_HTTP_LIMIT_REQ_MODULE == 'yes' ]; then
	CONFIG_OPTIONS="$CONFIG_OPTIONS --without-http_limit_req_module"
fi

if [ $DISABLE_HTTP_LIMIT_CONN_MODULE == 'yes' ]; then
	CONFIG_OPTIONS="$CONFIG_OPTIONS --without-http_limit_conn_module"
fi

if [ $DISABLE_HTTP_MAP_MODULE == 'yes' ]; then
	CONFIG_OPTIONS="$CONFIG_OPTIONS --without-http_map_module"
fi

if [ $DISABLE_HTTP_MEMCACHED_MODULE == 'yes' ]; then
	CONFIG_OPTIONS="$CONFIG_OPTIONS --without-http_memcached_module"
fi

if [ $DISABLE_HTTP_PROXY_MODULE == 'yes' ]; then
	CONFIG_OPTIONS="$CONFIG_OPTIONS --without-http_proxy_module"
fi

if [ $DISABLE_HTTP_REFERER_MODULE == 'yes' ]; then
	CONFIG_OPTIONS="$CONFIG_OPTIONS --without-http_referer_module"
fi

if [ $DISABLE_HTTP_REWRITE_MODULE == 'yes' ]; then
	CONFIG_OPTIONS="$CONFIG_OPTIONS --without-http_rewrite_module"
fi

if [ $DISABLE_HTTP_SCGI_MODULE == 'yes' ]; then
	CONFIG_OPTIONS="$CONFIG_OPTIONS --without-http_scgi_module"
fi

if [ $DISABLE_HTTP_SPLIT_CLIENTS_MODULE == 'yes' ]; then
	CONFIG_OPTIONS="$CONFIG_OPTIONS --without-http_split_clients_module"
fi

if [ $DISABLE_HTTP_SSI_MODULE == 'yes' ]; then
	CONFIG_OPTIONS="$CONFIG_OPTIONS --without-http_ssi_module"
fi

if [ $DISABLE_HTTP_UPSTREAM_MODULE == 'yes' ]; then
	CONFIG_OPTIONS="$CONFIG_OPTIONS --without-http_upstream_ip_hash_module --without-http_upstream_least_conn_module --without-http_upstream_keepalive_module"
fi

if [ $DISABLE_HTTP_USERID_MODULE == 'yes' ]; then
	CONFIG_OPTIONS="$CONFIG_OPTIONS --without-http_userid_module"
fi

if [ $DISABLE_HTTP_UWSGI_MODULE == 'yes' ]; then
	CONFIG_OPTIONS="$CONFIG_OPTIONS --without-http_uwsgi_module"
fi

# Modules disabled by default
if [ $INCLUDE_DEBUG_MODULE == 'yes' ]; then
	CONFIG_OPTIONS="$CONFIG_OPTIONS --with-debug"
fi

if [ $INCLUDE_HTTP_GZIP_STATIC_MODULE == 'yes' ]; then
	CONFIG_OPTIONS="$CONFIG_OPTIONS --with-http_gzip_static_module"
fi

if [ $INCLUDE_HTTP_SPDY_MODULE == 'yes' ]; then
	CONFIG_OPTIONS="$CONFIG_OPTIONS --with-http_spdy_module"
fi

if [ $INCLUDE_HTTP_SSL_MODULE == 'yes' ]; then
	CONFIG_OPTIONS="$CONFIG_OPTIONS --with-http_ssl_module"
fi

if [ $INCLUDE_HTTP_SUB_MODULE == 'yes' ]; then
	CONFIG_OPTIONS="$CONFIG_OPTIONS --with-http_sub_module"
fi

# Third-party modules
if [ $INCLUDE_PAGESPEED_MODULE == 'yes' ]; then
	CONFIG_OPTIONS="$CONFIG_OPTIONS --add-module=ngx_pagespeed-release-${VERSION_PAGESPEED_MODULE}-beta"
fi

# Pre-requisites to compile Nginx from source
# Debian DEPENDENCIES="gcc make libpcre3-dev zlib1g-dev libssl-dev libgeoip-dev"
DEPENDENCIES="gcc gcc-c++ make pcre-devel zlib-devel openssl-devel GeoIP-devel"
sudo yum install -y $DEPENDENCIES
if [ "$?" != '0' ]; then
	echo 'Could not install dependencies'
	echo 'Do you have sudo privilege?'
	exit 1
fi

# create NGX_USER, if not exists
if ! id -u $NGX_USER &> /dev/null ; then
	sudo adduser --no-create-home $NGX_USER &> /dev/null
	if [ "$?" != '0' ]; then
		echo 'Could not add user'
		echo 'Do you have sudo privilege?'
		exit 1
	fi
fi

COMPILE_DIR=$HOME/src/nginx-$(date +%F_%H-%M-%S)
mkdir -p $COMPILE_DIR &> /dev/null
cd $COMPILE_DIR &> /dev/null

echo 'Hold on! Downloading Nginx...'
wget -q http://nginx.org/download/nginx-$NGX_VER.tar.gz
tar xzf nginx-$NGX_VER.tar.gz && rm -f nginx-$NGX_VER.tar.gz; cd nginx-$NGX_VER
if [ "$?" != '0' ] ; then
	echo 'Could not download Nginx from nginx.org'
	exit 1
fi

echo 'Please wait! Configuring Nginx!'
echo $CONFIG_OPTIONS
./configure $CONFIG_OPTIONS &> /dev/null
if [ "$?" != '0' ]; then
	echo 'Something wrent wrong while configuring Nginx'
	exit 1
fi

# Remove the nasty error flag
sed -i '/^CFLAGS/ s/ \-Werror//' $COMPILE_DIR/nginx-$NGX_VER/objs/Makefile

echo 'Making the new version. This process may take several minutes depending on the CPU!'
sudo make
if [ "$?" != '0' ]; then
	echo 'Something wrent wrong while making Nginx'
	exit 1
fi

echo 'Installing Nginx'
sudo make install
if [ "$?" != '0' ]; then
	echo 'Something wrent wrong while installing Nginx'
	exit 1
fi

rm -rf $COMPILE_DIR

if [ $HIGH_TRAFFIC_SITE == 'yes' ]; then
	echo 'The new Nginx binary is ready. Since, you have high traffic site, ref... http://wiki.nginx.org/CommandLine#Upgrading_To_a_New_Binary_On_The_Fly to understand how to upgrade to this new binary on the fly!'
	exit 0
fi

if [ -f "$PID_PATH" ]; then
	echo 'Stopping the existing Nginx server...'
	sudo $NGX_BIN -s stop
	if [ "$?" != '0' ]; then
		echo 'Could not stop the previous Nginx binary'
		exit 1
	fi
fi

echo 'Starting the new Nginx server...'
mkdir /var/log/$NGX_BIN &> /dev/null
sudo $NGX_BIN -t && sudo $NGX_BIN
if [ "$?" != '0' ]; then
	echo 'Could not start the new Nginx binary'
	exit 1
else
	echo 'The new Nginx binary has started now!'
fi

