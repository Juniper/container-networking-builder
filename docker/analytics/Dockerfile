FROM ubuntu:14.04
MAINTAINER Pedro Marques <roque@juniper.net>
RUN apt-get install -y software-properties-common curl patch
RUN apt-add-repository -y ppa:opencontrail
RUN apt-add-repository -y ppa:opencontrail/r2.20
RUN apt-get update
RUN apt-get download contrail-analytics
RUN apt-get install -y $(apt-cache depends contrail-analytics | egrep -v "supervisor|<.*>" | grep Depends | sed "s/.*ends:\ //" | tr '\n' ' ')
RUN dpkg --unpack contrail-analytics*.deb
RUN rm -f /var/lib/dpkg/info/contrail-analytics.postinst
