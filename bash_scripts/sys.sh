#!/bin/bash

# Utility scripts for my home system

## File transfers
DESKTOP_IP="192.168.0.100"
SERVER_IP="192.168.0.101"

from_desktop() {
  # Files
  file=$1
  dest=$2
  scp -r $DESKTOP_IP:$file $dest
}
alias scpfd="from_desktop"

to_desktop() {
  # Files
  file=$1
  dest=$2
  scp -r $file $DESKTOP_IP:$dest
}
alias scptd="to_desktop"

login_desktop() {
  ssh $DESKTOP_IP
}
alias logd="login_desktop"

from_server() {
  # Files
  file=$1
  dest=$2
  scp -r $SERVER_IP:$file $dest
}
alias scpfs="from_server"

to_server() {
  # Files
  file=$1
  dest=$2
  scp -r $file $SERVER_IP:$dest
}
alias scpts="to_server"

login_server() {
  ssh $SERVER_IP
}
alias logs="login_server"
