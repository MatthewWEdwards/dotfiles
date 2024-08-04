#!/bin/bash

# html formatter utility function

#######################################
# HTML formatter
# Globals:
#   None
# Arguments:
#   None
# Aliases:
#   None
#######################################
htmltidy() {
  tidy -q -i -m -w 160 -ashtml -utf8
}
