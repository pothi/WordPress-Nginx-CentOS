#!/bin/bash

# Install Nginx and setup basic files

# Ref: http://nginx.org/en/linux_packages.html#stable

echo 'Installing nginx...'
sudo yum update -y -q
sudo yum install -y -q http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm
sudo yum install -y -q nginx git
sudo yum clean all

mkdir ~/backups &> /dev/null
TIMESTAMP=$(date +%F)
if [ ! -d ~/nginx-$TIMESTAMP ]; then
	sudo cp -a /etc/nginx ~/backups/nginx-$TIMESTAMP
fi

git clone https://github.com/pothi/WordPress-Nginx-CentOS.git ~/ngx
sudo cp -a ~/ngx/{conf.d,globals,sites-available,sites-enabled} /etc/nginx/

if [ ! -f /etc/nginx/fastcgi_params ]; then
	sudo cp ~/ngx/fastcgi_params /etc/nginx
fi

rm -rf ~/ngx &> /dev/null

sudo nginx -t

# Other steps that varies depending on your particular requirement:
# YOUR_DOMAIN_NAME=tinywp.com
# mv /etc/nginx/sites-available/domainname.conf /etc/nginx/sites-available/$YOUR_DOMAIN_NAME.conf
# cd /etc/nginx/sites-enabled/
# ln -s ../sites-available/$YOUR_DOMAIN_NAME.conf
