#!/bin/bash

PROPERTIES=/etc/ifmap-server/ifmap.properties

if [ -n "$IFMAP_BASIC_PORT" ]; then
    sed -r -i "s/irond.comm.basicauth.port=([0-9]+)/irond.comm.basicauth.port=$IFMAP_BASIC_PORT/" $PROPERTIES
fi

if [ -n "$IFMAP_CERT_PORT" ]; then
    sed -r -i "s/irond.comm.certauth.port=([0-9]+)/irond.comm.certauth.port=$IFMAP_CERT_PORT/" $PROPERTIES
fi

exec /usr/bin/ifmap-server

