FROM java:7
MAINTAINER Pedro Marques <roque@juniper.net>
RUN apt-get update
RUN apt-get install -y libcommons-codec-java libhttpcore-java liblog4j1.2-java
COPY ifmap-server_0.3.2-1contrail1_all.deb /var/cache/apt/archives/
RUN dpkg --unpack /var/cache/apt/archives/ifmap-server_0.3.2-1contrail1_all.deb
RUN rm /var/lib/dpkg/info/ifmap-server.postinst -f
RUN dpkg --configure ifmap-server
ADD entrypoint.sh /
RUN chmod a+x /entrypoint.sh
RUN echo "control-node:control-node" >> /etc/ifmap-server/basicauthusers.properties
ENTRYPOINT ["/entrypoint.sh"]
