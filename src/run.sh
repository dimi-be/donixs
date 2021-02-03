#!/bin/bash

cd /

if [ ! -f /etc/nginx/nginx.conf ]; then
  echo No nginx config found, creating config...
  tar xvzf /default-conf-nginx.tar.gz
  echo Config created
else
  echo nginx config exists, doing nothing
fi

if [ `ls /var/www | wc -l` == "0" ]; then
  echo www folder empty, creating default files...
  tar xvzf /default-www.tar.gz
  echo www folder populated
else
  echo www folder not empty, doing nothing
fi

if [ `ls /etc/letsencrypt/ | wc -l` == "0" ]; then
  echo letsencrypt folder empty, creating default files...
  tar xvzf /default-letsencrypt.tar.gz
  echo letsencrypt folder populated
else
  echo letsencrypt folder not empty, doing nothing
fi

#echo Starting nginx...
#/usr/sbin/nginx -g "daemon off;"

echo Starting supervisord...
supervisord -n -c /supervisord.conf

