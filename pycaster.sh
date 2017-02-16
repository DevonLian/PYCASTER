#!/bin/sh
export PATH=$PATH:/usr/local/bin
export NODE_PATH=$NODE_PATH:/usr/local/lib/node_modules

case "$1" in
  start)
  echo "Starting PYCASTER !"
  forever start server.js
  ;;
stop)
  echo "Stoping PYCASTER..."
  exec forever stop server.js
  ;;
*)
  echo "Usage: pycaster.sh {start|stop}"
  exit 1
  ;;
esac

