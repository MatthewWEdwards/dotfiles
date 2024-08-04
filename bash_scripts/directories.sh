#!/bin/bash

# Functions for setting the pwd to canonical directories on in msys

#######################################
# Globals relating to canonical directories in msys
# Globals:
#   REPOS - The root directory where all repos are downloaded
# Arguments:
#   None
# Aliases:
#   None
#######################################
directories_globals() {
  export REPOS="$HOME/Documents/repos"
}
directories_globals

#######################################
# cd to the repository directory
# Globals:
#   None
# Arguments:
#   None
# Aliases:
#   None
#######################################
repos() {
  cd $REPOS
}

#######################################
# cd to the django directory for my personal site
# Globals:
#   REPOS
# Arguments:
#   None
# Aliases:
#   None
#######################################
django() {
  cd $REPOS/personal_site/django
}

#######################################
# cd to the dotfiles repo
# Globals:
#   REPOS
# Arguments:
#   None
# Aliases:
#   None
#######################################
dotfiles() {
  cd $REPOS/dotfiles
}

#######################################
# cd to the mdoc repo
# Globals:
#   REPOS
# Arguments:
#   None
# Aliases:
#   None
#######################################
mdoc() {
  cd $REPOS/personal_site/mdoc
}

#######################################
# cd to the personal site repo
# Globals:
#   REPOS
# Arguments:
#   None
# Aliases:
#   site
#######################################
personal_site() {
  cd $REPOS/personal_site
}
alias site=personal_site

#######################################
# cd to the writing repo
# Globals:
#   REPOS
# Arguments:
#   None
# Aliases:
#   None
#######################################
writing() {
  cd $REPOS/writing
}

#######################################
# cd to the msys repo
# Globals:
#   REPOS
# Arguments:
#   None
# Aliases:
#   None
#######################################
msys() {
  cd $REPOS/msys
}

#######################################
# cd to the pages directory in the msys docs
# Globals:
#   REPOS
# Arguments:
#   None
# Aliases:
#   None
#######################################
pages() {
  cd $REPOS/msys/site/docusaurus/src/pages
}
