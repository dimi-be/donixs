# Donixs: Debian dOcker NgInX let'S encrypt

## What is it?
This is a collection of files that will create a docker image based on Debian that runs both Certbot and Nginx.

## How to
### Build image
docker build -t donixs .

### Export image
docker save donixs > donixs.tar

### Run
docker run -d -p 80:80 -p 443:443\
  -v $HOME/docker/donixs/nginx:/etc/nginx\
  -v $HOME/docker/donixs/www:/var/www\
  -v $HOME/docker/donixs/letsencrypt:/etc/letsencrypt\
  --tmpfs /tmp\
  --name Donixs
  donixs
  
### Setup
All config folders will be populated on first run, you can configure everything from there.

