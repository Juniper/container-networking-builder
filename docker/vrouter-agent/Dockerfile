FROM ubuntu:14.04
MAINTAINER Pedro Marques <roque@juniper.net>
MAINTAINER Sanju Abraham <sanjua@juniper.net>
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:opencontrail/ppa
RUN add-apt-repository -y ppa:opencontrail/r2.20
RUN apt-get update
RUN apt-get -y install contrail-lib contrail-utils contrail-vrouter-utils python-contrail-vrouter-api python-opencontrail-vrouter-netns
RUN apt-get -y install contrail-vrouter-agent
