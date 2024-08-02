#!/bin/bash

# Git utility functions

#######################################
# "git one line" - Show a git log with each commit on one line of text
# Globals:
#   None
# Arguments:
#   None
# Aliases:
#   None
#######################################
gol() {
  git log --oneline $@
}

#######################################
# "git one diff" - Show a diff of a rev and it's ancestor
# Globals:
#   None
# Arguments:
#   rev - The rev to "god"
# Aliases:
#   None
#######################################
god() {
  rev="$1"
  test -z $rev && { git diff HEAD ; return 0; }
  git diff $rev~1 $rev
}
