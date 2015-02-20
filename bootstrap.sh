#!/bin/bash

# Install Nginx and setup basic files

# Ref: http://nginx.org/en/linux_packages.html#stable

echo 'Installing nginx...'
yum install -y -q http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm
yum install -y -q nginx git

# TIMESTAMP=$(date +%F_%H-%M-%S)
TIMESTAMP=$(date +%F)
if [ ! -d ~/nginx-$TIMESTAMP ]; then
	cp -a /etc/nginx ~/backups/nginx-$TIMESTAMP
fi

git clone git://github.com/pothi/WordPress-Nginx-CentOS.git ~/ngx
cp -a ~/ngx/{conf.d,globals,sites-available,sites-enabled} /etc/nginx/

if [ ! -f /etc/nginx/fastcgi_params ]; then
	cp ~/ngx/fastcgi_params /etc/nginx
fi

nginx -t

# Other steps that varies depending on your particular requirement:
# YOUR_DOMAIN_NAME=tinywp.com
# mv /etc/nginx/sites-available/domainname.conf /etc/nginx/sites-available/$YOUR_DOMAIN_NAME.conf
# cd /etc/nginx/sites-enabled/
# ln -s ../sites-available/$YOUR_DOMAIN_NAME.conf
