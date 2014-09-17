docker-etherpad
===============

## Build
    docker build -t chaifeng/etherpad .

## Run
Notice: we need a mysql server!

    docker run -dit --link etherpad-mysql:mysql -p 8081:8000 chaifeng/etherpad
