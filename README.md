docker-etherpad
===============

## Build
    docker build -t chaifeng/etherpad etherpad-lite/

## Run
    # start a mysql instance
    docker run --name etherpad-mysql -e MYSQL_ROOT_PASSWORD=$(cat /dev/urandom | tr -cd 'a-z0-9' | head -c 16) -d mysql
    # create database
    cat etherpad-mysql/etherpad.sql | docker run -i --link etherpad-mysql:mysql mysql /bin/bash -c 'mysql -h"$MYSQL_PORT_3306_TCP_ADDR" -P"$MYSQL_PORT_3306_TCP_PORT" -uroot -p"$MYSQL_ENV_MYSQL_ROOT_PASSWORD"'
    # run etherpad
    docker run -dit --link etherpad-mysql:mysql -p 8081:8000 chaifeng/etherpad

## Backup data
    docker run -i --link etherpad-mysql:mysql mysql /bin/bash -c 'mysqldump -h"$MYSQL_PORT_3306_TCP_ADDR" -P"$MYSQL_PORT_3306_TCP_PORT" -uroot -p"$MYSQL_ENV_MYSQL_ROOT_PASSWORD" --databases etherpad | gzip' > etherpad.sql.tgz
