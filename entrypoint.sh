#!/bin/bash
set -eux 

#Copy configuration file if there is a one
if [ -f /etherpad/settings.json ]; then
  #Copy user configuration
  cp /etherpad/settings.json /var/lib/etherpad/
fi

#Launch server use server.js to skip updating dependence.
#/var/lib/etherpad/bin/run.sh $@
node /var/lib/etherpad/src/node/server.js
