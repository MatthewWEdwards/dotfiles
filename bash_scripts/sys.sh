#!/bin/bash

# Utility scripts for my home system

## File transfers
DESKTOP_IP="192.168.0.100"
SERVER_IP="192.168.0.101"
VMS_IP="192.168.0.121"

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
  ssh -X $DESKTOP_IP
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
  ssh -X $SERVER_IP
}
alias logs="login_server"

to_vms() {
  # Files
  file=$1
  dest=$2
  scp -r $file $VMS_IP:$dest
}
alias scptv="to_vms"

login_vms() {
  ssh -X $VMS_IP
}
alias logv="login_vms"