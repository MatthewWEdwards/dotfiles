#/bin/bash

# Functions for python

#######################################
# Run python with Poetry
# Globals:
#   None
# Arguments:
#   None
#######################################
porun () { 
  poetry run python $@
}

