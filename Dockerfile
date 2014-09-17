# Etherpad
FROM ubuntu:14.04
MAINTAINER ChaiFeng "http://chaifeng.com"

RUN apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y gzip git-core curl python-software-properties python g++ make libssl-dev pkg-config libpq-dev build-essential openssh-server

# install node.js
RUN ( curl -sL https://deb.nodesource.com/setup | sudo bash - )
RUN apt-get install -y nodejs

# install etherpad
RUN (cd /opt && git clone git://github.com/ether/etherpad-lite.git etherpad && cd etherpad && ./bin/installDeps.sh)
# bin/safeRun.sh /dev/stdout --root
RUN (cd /opt/etherpad && npm install ep_webrtc)

ADD settings.json.docker /opt/etherpad/settings.json.docker

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y supervisor

# add supervisor settings
ADD etherpad.conf /etc/supervisor/conf.d/etherpad.conf

EXPOSE 22 8000

ADD start.sh /opt/etherpad/start.sh
# start etherpad using supervisor
CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf", "-n"]
