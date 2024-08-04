#!/bin/bash

fsget() {
  (
    SERVER_IP=192.168.0.100
    curl http://$SERVER_IP:$FILESERVER_PORT/$1
  )
}

