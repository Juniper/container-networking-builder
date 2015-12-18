FROM ubuntu:14.04
MAINTAINER Pedro Marques <roque@juniper.net>
RUN apt-get install -y software-properties-common
RUN apt-add-repository -y ppa:opencontrail
RUN apt-add-repository -y ppa:opencontrail/r2.20
RUN apt-get update
RUN apt-get -y install nodejs=0.8.15-1contrail1
RUN apt-get download contrail-web-core contrail-web-controller
RUN apt-get download contrail-web-controller

RUN apt-get install -y $(apt-cache depends contrail-web-core | egrep -v "supervisor|<.*>" | grep Depends | sed "s/.*ends:\ //" | tr '\n' ' ')
RUN dpkg --unpack contrail-web-core*.deb
RUN rm -f /var/lib/dpkg/info/contrail-web-core.postinst

RUN dpkg --unpack contrail-web-controller*.deb
RUN rm -f /var/lib/dpkg/info/contrail-web-controller.postinst

RUN ln -sf /usr/bin/nodejs /usr/bin/node
RUN ln -sf /var/lib/contrail-webui /usr/src/contrail
RUN mv /etc/contrail/config.global.js.dpkg-new /etc/contrail/config.global.js
RUN sed -i "s/config.orchestration.Manager = 'openstack'/config.orchestration.Manager = 'none'/" /etc/contrail/config.global.js
RUN sed -i 's/8080/8070/' /etc/contrail/config.global.js

RUN echo "#!/usr/bin/env bash" > /usr/bin/contrail-webui-start.sh
RUN echo cd /var/lib/contrail-webui/contrail-web-core >> /usr/bin/contrail-webui-start.sh
RUN echo exec /usr/bin/node webServerStart.js >> /usr/bin/contrail-webui-start.sh
RUN chmod +x /usr/bin/contrail-webui-start.sh
