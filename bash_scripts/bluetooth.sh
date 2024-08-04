#/bin/bash

# Functions for managing bluetooth on Ubuntu 22.04

#######################################
# Reset bluetooth on Ubuntu 22.04
# Globals:
#   None
# Arguments:
#   None
#######################################
bluetooth_reset () { 
  ### Hard Refresh
  
  ## End Service (If it is running)
  sudo systemctl stop bluetooth.service
  
  ## Removes Hardware Emulation  
  sudo systemctl unmask bluetooth.service
  
  ## Start Service
  sudo systemctl start bluetooth.service
  sudo systemctl enable bluetooth
  
  ## Re-Enable Hardware Emulation
  sudo systemctl mask bluetooth.service 
  sudo rmmod btusb
  sudo modprobe btusb
  
  ## Unblock from rfkill
  rfkill unblock all
}

#######################################
# Alias for bluetooth_reset
# Globals:
#   None
# Arguments:
#   None
#######################################
breset() {
  bluetooth_reset
}

#######################################
# Restart bluetoothd
# Globals:
#   None
# Arguments:
#   None
#######################################
sbluetooth() {
  sudo bluetoothd -d -C -E -n
}
