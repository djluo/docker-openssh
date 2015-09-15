#!/bin/sh

remote="$1"
port="$2"

exec /usr/bin/ssh -i /conf/id_rsa    \
      -p932 -oStrictHostKeyChecking=no \
          -N -L0.0.0.0:$port:172.17.42.1:$port tunnel@$remote
