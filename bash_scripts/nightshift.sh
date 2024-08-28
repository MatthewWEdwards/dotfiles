#!/bin/bash

# Functions for colorshifting monitors

#######################################
# Get Monitors
# Globals:
#   None
# Arguments:
#   None
#######################################

monitors()  {
  xrandr -q | grep -E '([^\s]*) connected' | grep -v "None" | cut -f 1 -d ' '
}

#######################################
# Set brightness and hue to night
# Globals:
#   None
# Arguments:
#   None
#######################################
night() {
  RGB="1.0:0.75:0.50"
  BRIGHTNESS=".8"
  for m in $(monitors) ;
  do
    xrandr --output $m --gamma $RGB --brightness $BRIGHTNESS
  done
}

#######################################
# Set brightness and hue to dark night
# Globals:
#   None
# Arguments:
#   None
#######################################
dnight() {
  RGB="1.0:0.6:0.4"
  BRIGHTNESS=".3"
  for m in $(monitors) ;
  do
    xrandr --output $m --gamma $RGB --brightness $BRIGHTNESS
  done
}


#######################################
# Set brightness and hue to day
# Globals:
#   None
# Arguments:
#   None
#######################################
day() {
  RGB=${RGB:=1.0:1.0:1.0}
  BRIGHTNESS=${BRIGHTNESS:=1}
  for m in $(monitors) ;
  do
    xrandr --output $m --gamma $RGB --brightness $BRIGHTNESS
  done
}

#######################################
# Set screen color to an arbitrary. Default to night shift.
# Globals:
#   RBG: The hue to set the color to in R:G:B floats . e.g.: 1.0:-.4:0.4
#   BRIGHTNESS - A 0.0 - 1.0 float that is the brightness the screen is set to
# Arguments:
#   None
#######################################
color() {
  RGB=${RGB:=1.0:0.6:0.4}
  BRIGHTNESS=${BRIGHTNESS:=.50}
  for m in $(monitors) ;
  do
    xrandr --output $m --gamma $RGB --brightness $BRIGHTNESS
  done
}
