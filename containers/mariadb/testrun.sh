#!/usr/bin/env bash

docker run --detach \
 -p 3306:3306 \
 --name wordpressdb \
 --env MARIADB_USER=$MARIADB_USER \
 --env MARIADB_PASSWORD="$MARIADB_PASSWORD" \
 --env MARIADB_ROOT_PASSWORD="$MARIADB_ROOT_PASSWORD" \
 mariadb:latest

