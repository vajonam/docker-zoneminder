#!/bin/bash

DEBIAN_FRONTEND=noninteractive apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -y -q php-gd zoneminder

#to fix error relate to ip address of container apache2
echo "ServerName localhost" | tee /etc/apache2/conf-available/fqdn.conf
ln -s /etc/apache2/conf-available/fqdn.conf /etc/apache2/conf-enabled/fqdn.conf

mv /zoneminder.conf /etc/apache2/conf-available/zoneminder.conf

a2enmod cgi
a2enmod headers
a2enconf zoneminder
chown -R www-data:www-data /usr/share/zoneminder/
a2enmod rewrite
adduser www-data video

#to clear some data before saving this layer ...a docker image
rm -R /var/www/html
rm /etc/apache2/sites-enabled/000-default.conf
apt-get clean
rm -rf /tmp/* /var/tmp/*
rm -rf /var/lib/apt/lists/*
