#!/usr/bin/env bash

docker run --detach \
 -p 8080:80 \
 --name wordpress \
 --env WORDPRESS_DB_NAME=wordpressdb \
 --env WORDPRESS_DB_HOST=172.17.0.2 \
 --env WORDPRESS_DB_USER=wpadmin \
 --env WORDPRESS_DB_PASSWORD="$MARIADB_PASSWORD" \
 wordpress:latest

