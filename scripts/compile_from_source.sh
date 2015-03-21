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
KEEP_HTTP_CORE_MODULE="yes"
KEEP_HTTP_ACCESS_MODULE="yes"
KEEP_HTTP_AUTH_BASIC_MODULE="yes"
KEEP_HTTP_AUTOINDEX_MODULE="yes"
KEEP_HTTP_BROWSER_MODULE="yes"
KEEP_HTTP_CHARSET_MODULE="yes"
KEEP_HTTP_EMPTY_GIF_MODULE="no"
KEEP_HTTP_FASTCGI_MODULE="yes"
KEEP_HTTP_GEO_MODULE="yes"
KEEP_HTTP_GZIP_MODULE="yes"
KEEP_HTTP_LIMIT_REQ_MODULE="no"
KEEP_HTTP_LIMIT_CONN_MODULE="no"
KEEP_HTTP_MAP_MODULE="yes"
KEEP_HTTP_MEMCACHED_MODULE="yes"
KEEP_HTTP_PROXY_MODULE="yes"
KEEP_HTTP_REFERER_MODULE="yes"
KEEP_HTTP_REWRITE_MODULE="yes"
KEEP_HTTP_SCGI_MODULE="no"
KEEP_HTTP_SPLIT_CLIENTS_MODULE="no"
KEEP_HTTP_SSI_MODULE="no"
KEEP_HTTP_UPSTREAM_MODULE="yes"
KEEP_HTTP_USERID_MODULE="no"
KEEP_HTTP_UWSGI_MODULE="no"

# The following modules are not enabled by default.
ADD_DEBUG_MODULE="yes"

ADD_HTTP_GZIP_STATIC_MODULE="yes"
ADD_HTTP_SPDY_MODULE="yes"
ADD_HTTP_SSL_MODULE="yes"
ADD_HTTP_SUB_MODULE="yes"

### Third-party modules - require version number info
ADD_PAGESPEED_MODULE="no"
# Version info at https://github.com/pagespeed/ngx_pagespeed/releases
NGINX_PAGESPEED_MODULE_VERSION="1.9.32.3"

ADD_ECHO_MODULE="no"
# Version info at http://wiki.nginx.org/HttpEchoModule
NGINX_ECHO_MODULE_VERSION="0.57"

# You may change the name of the nginx binary here so avoid conflicts with the existing binary, if any
NGX_BIN="nginx_c"

# Are you compiling this on a high traffic *live* site. Save your ass by keeping this option.
HIGH_TRAFFIC_SITE="yes"

#-------- END OF VARIABLES ----------#

PID_PATH="/var/run/$NGX_BIN.pid"

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
if [ $KEEP_HTTP_CORE_MODULE == 'no' ]; then
	CONFIG_OPTIONS="$CONFIG_OPTIONS --without-http_core_module"
fi

if [ $KEEP_HTTP_ACCESS_MODULE == 'no' ]; then
	CONFIG_OPTIONS="$CONFIG_OPTIONS --without-http_access_module"
fi

if [ $KEEP_HTTP_AUTH_BASIC_MODULE == 'no' ]; then
	CONFIG_OPTIONS="$CONFIG_OPTIONS --without-http_auth_basic_module"
fi

if [ $KEEP_HTTP_AUTOINDEX_MODULE == 'no' ]; then
	CONFIG_OPTIONS="$CONFIG_OPTIONS --without-http_autoindex_module"
fi

if [ $KEEP_HTTP_BROWSER_MODULE == 'no' ]; then
	CONFIG_OPTIONS="$CONFIG_OPTIONS --without-http_browser_module"
fi

if [ $KEEP_HTTP_CHARSET_MODULE == 'no' ]; then
	CONFIG_OPTIONS="$CONFIG_OPTIONS --without-http_charset_module"
fi

if [ $KEEP_HTTP_EMPTY_GIF_MODULE == 'no' ]; then
	CONFIG_OPTIONS="$CONFIG_OPTIONS --without-http_empty_gif_module"
fi

if [ $KEEP_HTTP_FASTCGI_MODULE == 'no' ]; then
	CONFIG_OPTIONS="$CONFIG_OPTIONS --without-http_fastcgi_module"
fi

if [ $KEEP_HTTP_GEO_MODULE == 'no' ]; then
	CONFIG_OPTIONS="$CONFIG_OPTIONS --without-http_geo_module"
fi

if [ $KEEP_HTTP_GZIP_MODULE == 'no' ]; then
	CONFIG_OPTIONS="$CONFIG_OPTIONS --without-http_gzip_module"
fi

if [ $KEEP_HTTP_LIMIT_REQ_MODULE == 'no' ]; then
	CONFIG_OPTIONS="$CONFIG_OPTIONS --without-http_limit_req_module"
fi

if [ $KEEP_HTTP_LIMIT_CONN_MODULE == 'no' ]; then
	CONFIG_OPTIONS="$CONFIG_OPTIONS --without-http_limit_conn_module"
fi

if [ $KEEP_HTTP_MAP_MODULE == 'no' ]; then
	CONFIG_OPTIONS="$CONFIG_OPTIONS --without-http_map_module"
fi

if [ $KEEP_HTTP_MEMCACHED_MODULE == 'no' ]; then
	CONFIG_OPTIONS="$CONFIG_OPTIONS --without-http_memcached_module"
fi

if [ $KEEP_HTTP_PROXY_MODULE == 'no' ]; then
	CONFIG_OPTIONS="$CONFIG_OPTIONS --without-http_proxy_module"
fi

if [ $KEEP_HTTP_REFERER_MODULE == 'no' ]; then
	CONFIG_OPTIONS="$CONFIG_OPTIONS --without-http_referer_module"
fi

if [ $KEEP_HTTP_REWRITE_MODULE == 'no' ]; then
	CONFIG_OPTIONS="$CONFIG_OPTIONS --without-http_rewrite_module"
fi

if [ $KEEP_HTTP_SCGI_MODULE == 'no' ]; then
	CONFIG_OPTIONS="$CONFIG_OPTIONS --without-http_scgi_module"
fi

if [ $KEEP_HTTP_SPLIT_CLIENTS_MODULE == 'no' ]; then
	CONFIG_OPTIONS="$CONFIG_OPTIONS --without-http_split_clients_module"
fi

if [ $KEEP_HTTP_SSI_MODULE == 'no' ]; then
	CONFIG_OPTIONS="$CONFIG_OPTIONS --without-http_ssi_module"
fi

if [ $KEEP_HTTP_UPSTREAM_MODULE == 'no' ]; then
	CONFIG_OPTIONS="$CONFIG_OPTIONS --without-http_upstream_ip_hash_module --without-http_upstream_least_conn_module --without-http_upstream_keepalive_module"
fi

if [ $KEEP_HTTP_USERID_MODULE == 'no' ]; then
	CONFIG_OPTIONS="$CONFIG_OPTIONS --without-http_userid_module"
fi

if [ $KEEP_HTTP_UWSGI_MODULE == 'no' ]; then
	CONFIG_OPTIONS="$CONFIG_OPTIONS --without-http_uwsgi_module"
fi

# Modules KEEPd by default
if [ $ADD_DEBUG_MODULE == 'yes' ]; then
	CONFIG_OPTIONS="$CONFIG_OPTIONS --with-debug"
fi

if [ $ADD_HTTP_GZIP_STATIC_MODULE == 'yes' ]; then
	CONFIG_OPTIONS="$CONFIG_OPTIONS --with-http_gzip_static_module"
fi

if [ $ADD_HTTP_SPDY_MODULE == 'yes' ]; then
	CONFIG_OPTIONS="$CONFIG_OPTIONS --with-http_spdy_module"
fi

if [ $ADD_HTTP_SSL_MODULE == 'yes' ]; then
	CONFIG_OPTIONS="$CONFIG_OPTIONS --with-http_ssl_module"
fi

if [ $ADD_HTTP_SUB_MODULE == 'yes' ]; then
	CONFIG_OPTIONS="$CONFIG_OPTIONS --with-http_sub_module"
fi

#-- Third-party modules
if [ $ADD_PAGESPEED_MODULE == 'yes' ]; then
	# Remove any existing files
	# rm -rf ~/src/ngx_pagespeed-release-${NGX_PSS_VER}-beta &> /dev/null
	NGX_PSS_VER=${NGINX_PAGESPEED_MODULE_VERSION}
	CONFIG_OPTIONS="$CONFIG_OPTIONS --add-module=$HOME/src/ngx_pagespeed-release-${NGX_PSS_VER}-beta"
	# Ref: https://developers.google.com/speed/pagespeed/module/build_ngx_pagespeed_from_source
	sudo yum install -y gcc-c++ pcre-dev pcre-devel zlib-devel make unzip
	if [ "$?" != '0' ]; then
		echo 'Could not install dependencies'
		echo 'Do you have sudo privilege?'
		exit 1
	fi

	# download ngx_pss
	if [ ! -d "$HOME/src/ngx_pagespeed-release-${NGX_PSS_VER}-beta" ] ; then
		echo 'Hold on while downloading PageSpeed module...'
		wget -q -O ~/src/release-${NGX_PSS_VER}-beta.zip https://github.com/pagespeed/ngx_pagespeed/archive/release-${NGX_PSS_VER}-beta.zip &> /dev/null
		unzip -q -d ~/src/ ~/src/release-${NGX_PSS_VER}-beta.zip
		rm ~/src/release-${NGX_PSS_VER}-beta.zip &> /dev/null
		wget -q -O ~/src/${NGX_PSS_VER}.tar.gz  https://dl.google.com/dl/page-speed/psol/${NGX_PSS_VER}.tar.gz &> /dev/null
		tar -C ~/src/ngx_pagespeed-release-${NGX_PSS_VER}-beta -xzf ~/src/${NGX_PSS_VER}.tar.gz
		rm ~/src/${NGX_PSS_VER}.tar.gz &> /dev/null
	fi
fi

if [ $ADD_ECHO_MODULE == 'yes' ]; then
	# Remove any existing files
	# rm -rf ~/src/ngx_echo_module &> /dev/null

	if [ ! -d "$HOME/src/ngx_echo_module" ] ; then
		echo 'Downloading echo module'
		wget -q -O ~/src/ngx_echo_module.tar.gz https://github.com/openresty/echo-nginx-module/archive/v${NGINX_ECHO_MODULE_VERSION}.tar.gz
		if [ "$?" != '0' ]; then
			echo 'Could not download echo module'
			exit 1
		fi
		tar -C ~/src/ -xzf ~/src/ngx_echo_module.tar.gz
		rm ~/src/ngx_echo_module.tar.gz
	fi

	CONFIG_OPTIONS="$CONFIG_OPTIONS --add-module=$HOME/src/echo-nginx-module-${NGINX_ECHO_MODULE_VERSION}"
fi

#-- Pre-requisites to compile Nginx from source
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

# COMPILE_DIR=$HOME/src/nginx-$(date +%F_%H-%M-%S)
COMPILE_DIR=$HOME/src/nginx-$(date +%F)
mkdir -p $COMPILE_DIR &> /dev/null
cd $COMPILE_DIR &> /dev/null

if [ ! -d "$HOME/src/nginx-$(date +%F)/nginx-$NGX_VER" ] ; then
	echo 'Hold on! Downloading Nginx...'
	wget -q http://nginx.org/download/nginx-$NGX_VER.tar.gz
	tar -C $COMPILE_DIR -xzf nginx-$NGX_VER.tar.gz
	if [ "$?" != '0' ] ; then
		echo 'Could not download Nginx from nginx.org'
		exit 1
	fi
	rm -f nginx-$NGX_VER.tar.gz; cd nginx-$NGX_VER
fi

cd $COMPILE_DIR/nginx-$NGX_VER
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

#-- Remove source files
rm -rf $COMPILE_DIR &> /dev/null
rm -rf ~/src/ngx_pagespeed-release-${NGX_PSS_VER}-beta &> /dev/null
rm -rf ~/src/echo-nginx-module-${NGINX_ECHO_MODULE_VERSION} &> /dev/null

echo 'The new Nginx binary is ready'
echo 'Start it with "sudo '$NGX_BIN' -t && sudo '$NGX_BIN''
echo 'The above command would verify the conf at /etc/'$NGX_BIN'/nginx.conf and then would start as a daemon'
echo 'If an existing binary is already running and if you are doing this on a high traffic live site, save your ass by referring http://wiki.nginx.org/CommandLine#Upgrading_To_a_New_Binary_On_The_Fly to upgrade a new binary on the fly!'
echo 'If you do not mind some downtime for your visitors, stop the existing Nginx binary and then run the above command to start again'
echo 'Happy hosting!'

exit 0

# The following code will be removed at a latest stage and has no meaning beyond the previous command (exit 0)

if [ $HIGH_TRAFFIC_SITE == 'yes' ]; then
	echo 'The new Nginx binary is ready. Ref... http://wiki.nginx.org/CommandLine#Upgrading_To_a_New_Binary_On_The_Fly to upgrade a new binary on the fly!'
	exit 0
fi

# If you have high traffic site, ref... http://wiki.nginx.org/CommandLine#Upgrading_To_a_New_Binary_On_The_Fly
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

