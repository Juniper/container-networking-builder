FROM ubuntu:14.04

RUN apt-get update
RUN apt-get install -y vim libtimedate-perl xz-utils openssh-server
RUN apt-get install -y default-jre-headless supervisor libsnmp-python

COPY contrail-install-packages_3.1.0.0-20~liberty_all.deb /
RUN dpkg -i /contrail-install-packages_3.1.0.0-20~liberty_all.deb
RUN rm /contrail-install-packages_3.1.0.0-20~liberty_all.deb
RUN /opt/contrail/contrail_packages/setup.sh
RUN rm /opt/contrail/contrail_packages/*.tgz

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --allow-unauthenticated curl strace tcpdump
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --allow-unauthenticated cassandra zookeeper rabbitmq-server
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --allow-unauthenticated contrail-config contrail-config-openstack
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --allow-unauthenticated contrail-control contrail-dns
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --allow-unauthenticated contrail-analytics
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --allow-unauthenticated contrail-web-controller contrail-web-core

RUN rm /opt/contrail/contrail_install_repo/*

# create supervisor-controller config
RUN mkdir /etc/contrail/supervisord_controller_files
RUN cp /etc/contrail/supervisord_config_files/*.ini /etc/contrail/supervisord_controller_files/
RUN cp /etc/contrail/supervisord_analytics_files/*.ini /etc/contrail/supervisord_controller_files/
RUN cp /etc/contrail/supervisord_control_files/*.ini /etc/contrail/supervisord_controller_files/
RUN cp /etc/contrail/supervisord_config_files/*.ini /etc/contrail/supervisord_controller_files/
RUN sed -e 's/supervisord_config/supervisord_controller/g' \
        -e 's/supervisord-config/supervisord-controller/g' \
        /etc/contrail/supervisord_config.conf > /etc/contrail/supervisord_controller.conf

# fix cassandra java version check and enable rpc
RUN sed -i 's/if \[ \"\$JVM_VERSION\" \\< \"1.8\" \] && \[ \"\$JVM_PATCH_VERSION\" \\< \"25\" \] ; then/if [ "\$JVM_VERSION" \\< "1.8" ] \&\& [ "\$JVM_PATCH_VERSION" -lt "25" ] ; then/g' /etc/cassandra/cassandra-env.sh
RUN sed -i 's/start_rpc:.*/start_rpc: true/g' /etc/cassandra/cassandra.yaml

# copy supervisor launch files
COPY supervisord_controller_files/* /etc/contrail/supervisord_controller_files/
COPY rabbitmq-launch.sh /
RUN chmod a+x /rabbitmq-launch.sh

# cleanup
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# entrypoint
ENTRYPOINT /usr/bin/supervisord --nodaemon -c /etc/contrail/supervisord_controller.conf
