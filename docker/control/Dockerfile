FROM ubuntu:14.04
MAINTAINER Pedro Marques <roque@juniper.net>
RUN apt-get install -y software-properties-common
RUN apt-add-repository -y ppa:opencontrail/r2.20
RUN apt-get update
RUN apt-get download contrail-control
RUN apt-get install -y $(apt-cache depends contrail-control | egrep -v "supervisor|<.*>" | grep Depends | sed "s/.*ends:\ //" | tr '\n' ' ')
RUN dpkg --unpack contrail-control*.deb
RUN rm -f /var/lib/dpkg/info/contrail-control.postinst
ENTRYPOINT ["/usr/bin/contrail-control"]
