#!/bin/bash

# discordup utility function

#######################################
# Install the most recently version of the discord RPM from the Downloads directory
# Globals:
#   HOME
# Arguments:
#   None
# Aliases:
#   None
#######################################
discordup() {
  sudo dpkg -i $(ls $HOME/Downloads/discord-* | sort | tail -n 1)
}
