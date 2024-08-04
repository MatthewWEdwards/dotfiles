#!/bin/bash

# Utility scripts and global variables for msys

#######################################
# Globals relating to addresses of hosts
# Globals:
#   DESKTOP_IP
#   SERVER_IP
#   VMS_IP
# Arguments:
#   None
#######################################
sys_globals () {
  export DESKTOP_IP="192.168.0.100"
  export SERVER_IP="192.168.0.101"
  export VMS_IP="192.168.0.121"
}
sys_globals

#######################################
# Copy file from desktop system to local
# Globals:
#   DESKTOP_IP
# Arguments:
#   file - The file to copy from the desktop
#   dest - The des
# Aliases:
#   scpfd
#######################################
from_desktop() {
  # Files
  file=$1
  dest=$2
  scp -r $DESKTOP_IP:$file $dest
}
alias scpfd="from_desktop"

#######################################
# To be deleted
# Globals:
#   DESKTOP_IP
# Arguments:
#   file - The file to copy from the desktop
#   dest - The destination on the local system to save the file
# Aliases:
#   logd
#######################################
to_desktop() {
  # Files
  file=$1
  dest=$2
  scp -r $file $DESKTOP_IP:$dest
}
alias scptd="to_desktop"

#######################################
# Log into the desktop host
# Globals:
#   DESKTOP_IP
# Arguments:
#   None
# Aliases:
#   logd
#######################################
login_desktop() {
  ssh -X $DESKTOP_IP
}
alias logd="login_desktop"

#######################################
# Copy file from server host
# Globals:
#   SERVER_IP
# Arguments:
#   file - The file to copy from the server
#   dest - The destination on the local system to save the file
# Aliases:
#   scpfs
#######################################
from_server() {
  # Files
  file=$1
  dest=$2
  scp -r $SERVER_IP:$file $dest
}
alias scpfs="from_server"

#######################################
# To be deleted
# Globals:
#   None
# Arguments:
#   None
#######################################
to_server() {
  # Files
  file=$1
  dest=$2
  scp -r $file $SERVER_IP:$dest
}
alias scpts="to_server"

#######################################
# Log into server host
# Globals:
#   None
# Arguments:
#   None
# Aliases:
#   logs
#######################################
login_server() {
  ssh -X $SERVER_IP
}
alias logs="login_server"

#######################################
# Log into server host
# Globals:
#   VMS_IP
# Arguments:
#   file - The file to copy from the VM host
#   dest - The destination on the local system to save the file
# Aliases:
#   scptv
#######################################
to_vms() {
  # Files
  file=$1
  dest=$2
  scp -r $file $VMS_IP:$dest
}
alias scptv="to_vms"

#######################################
# Log into VM host
# Globals:
#   VMS_IP
# Arguments:
#   None
# Aliases:
#   logv
#######################################
login_vms() {
  ssh -X $VMS_IP
}
alias logv="login_vms"
