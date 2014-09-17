#!/bin/bash
set -e

sed -e "s/MYSQL_HOST_ADDR/$MYSQL_PORT_3306_TCP_ADDR/" \
    -e "s/MYSQL_HOST_PORT/$MYSQL_PORT_3306_TCP_PORT/" \
    -e "s/MYSQL_ROOT_PWD/$MYSQL_ENV_MYSQL_ROOT_PASSWORD/" settings.json.docker > settings.json

bin/run.sh /dev/stdout --root
