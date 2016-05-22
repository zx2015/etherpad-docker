#!/bin/bash
set -eux 

#/var/lib/etherpad/bin/run.sh $@
node /var/lib/etherpad/src/node/server.js
