FROM ubuntu:14.04
MAINTAINER Pedro Marques <roque@juniper.net>
RUN apt-get install -y software-properties-common
RUN apt-add-repository -y ppa:opencontrail
RUN apt-add-repository -y ppa:opencontrail/r2.20
RUN apt-get update
RUN apt-get download contrail-config
RUN apt-get download contrail-utils
RUN apt-get install -y $(apt-cache depends contrail-config | egrep -v "supervisor|<.*>" | grep Depends | sed "s/.*ends:\ //" | tr '\n' ' ')
RUN dpkg --unpack contrail-config*.deb
RUN rm -f /var/lib/dpkg/info/contrail-config.postinst
RUN dpkg --unpack contrail-utils*.deb
RUN /var/lib/dpkg/info/contrail-utils.postinst


