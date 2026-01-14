#/bin/bash

# Functions for managing display configurations

#######################################
# Set display settings for Desktop setup
# Globals:
#   None
# Arguments:
#   None
#######################################
displayd () { 
  xrandr \
    --output DP-0 \
    --mode 2560x1440 \
    --primary \
    --output HDMI-0 \
    --mode 2560x1440 \
    --pos 2560x0 \
    --rotate left
}

#######################################
# Set display settings for TV setup
# Globals:
#   None
# Arguments:
#   None
#######################################
displaytv () { 
  xrandr \
    --output DP-0 \
    --mode 2560x1440 \
    --primary \
    --output HDMI-0 \
    --same-as DP-0
}
