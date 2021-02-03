FROM debian:buster-slim

RUN cd /

# install packages
RUN apt update\
  && apt install --no-install-recommends -y nginx cron supervisor certbot python-certbot-nginx\
  && rm -rf /var/cache/apt/*

# store default config and empty directories
RUN tar cvzf default-nginx.tar.gz /etc/nginx\
  && tar cvzf default-www.tar.gz /var/www\
  && tar cvzf default-letsencrypt.tar.gz /etc/letsencrypt\
  && rm -rf /etc/nginx/*\
  && rm -rf /var/www/*\
  && rm -rf /etc/letsencrypt

# redirect logging
RUN ln -sf /dev/stdout /var/log/nginx/access.log\
  && ln -sf /dev/stderr /var/log/nginx/error.log\
  && mkdir -p /var/log/letsencrypt\
  && ln -sf /dev/stdout /var/log/letsencrypt/letsencrypt.log

# cleanup
RUN rm -f /etc/cron.d/* /etc/cron.daily/* /etc/cron.hourly/* /etc/cron.monthly/* /etc/cron.weekly/*

# prepare files
COPY ./src/* /
COPY ./cron/* /etc/cron.daily/
RUN chmod +x /run.sh\
  && chmod +x /etc/cron.daily/*

CMD /run.sh
