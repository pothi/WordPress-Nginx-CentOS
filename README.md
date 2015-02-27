# WordPress-Nginx

WordPress specific Nginx configurations, tweaks, etc on Fedora, Redhat & CentOS based distributions with PHP-FPM.

## Compatibility

It is a work in progress. I plan to test it on the following...

+ Amazon Linux AMI (2013.x+)
+ Fedora 19+
+ CentOS 7+

Since, I haven't tested on these yet, I'm glad to install and set it up on your server for free! In return, you'd be thanked here for providing the test machine!

## How to Install

Please backup the existing configuration files...

```bash
mkdir ~/scripts &> /dev/null

curl -Sso ~/scripts/bootstrap-ngx.sh https://raw.githubusercontent.com/pothi/WordPress-Nginx-CentOS/master/scripts/bootstrap.sh
chmod +x ~/scripts/bootstrap-ngx.sh

# vi ~/scripts/bootstrap-ngx.sh

~/scripts/bootstrap-ngx.sh
```

## Questions, Issues or Bugs?

+ Please submit issues or bugs via Github
+ Patches, improvements, and suggestions are welcomed.
+ Please use contact form at https://www.tinywp.in/contact/ , if you'd like to contact Pothi Kalimuthu for other reasons.
+ I'm available for hire to setup, tweak or troubleshoot your server to provide *the fastest WordPress hosting*.
+ Thanks for having a look here. Have a good time!
