#!/bin/bash

# The Dotsync Bash Program

#######################################
# dotsync util for updating dotfiles
# 
# See help message for more details
# Globals:
#   None
# Arguments:
#   None
#######################################
dotsync() {
    dots=(".gitconfig" ".vimrc" ".bashrc" ".tmux.conf")
    dirs=(".bash_scripts")

    read -r -d '' USAGE << EOM
dotsync [OPTIONS]

Synchronize local dotfiles between my repo and the local machine. By default, dotfiles are copied
from the repository to the local machines.  The following dotfiles are synched:

${dots[@]}

Additionally, the following dotfile directories are synced:

${dirs[@]}

OPTIONS:
    -d: Show difference between latest in repository and local dotfiles and exit
    -f: Don't prompt before overwriting files
    -g: Pull dotfiles git repository if it doesn't exist. Push or Pull to remote.
    -h: Display this message
    -p: Push dotfiles to repo.
EOM

  DOTFILES_DIR="$REPOS/dotfiles"
  REPO_URL="git@github.com:MatthewWEdwards/dotfiles.git"

  DIFF=0
  SKIP=0
  GIT=0
  PUSH=0
  local OPTIND
  while getopts dfghp opt; do
      case $opt in
      d) DIFF=1 ;;
      f) SKIP=1 ;;
      g) GIT=1 ;;
      h) echo "$USAGE" ; return 1 ;;
      p) PUSH=1 ;;
      *) echo "$USAGE" ; return 1 ;;
      esac
  done
  shift $((OPTIND-1))

  if [ $GIT == 1 ]
  then
      if [ -d $DOTFILES_DIR ]
      then
          echo "$DOTFILES_DIR exists. Remove to pull dotfiles."
      else
          { cd $REPOS ; git clone "$REPO_URL"; }
      fi
  fi

  test -d "$DOTFILES_DIR" || \
      { echo "$DOTFILES_DIR not found. Pass -g to pull it." ; echo "$USAGE" ; return 1 ; }

  if [ $DIFF == 1 ]
  then
      test "$GIT" -eq 1 &&  { cd $DOTFILES_DIR ; git pull ; } 
      echo "Diff applied to git repository"
      for f in ${dots[@]} ;
      do
        diff --color $DOTFILES_DIR/${f:1} $HOME/$f
      done
      for d in ${dirs[@]} ;
      do
        diff --color $DOTFILES_DIR/${d:1} $HOME/$d
      done
      return;
  fi

  # Repo -> Local
  if [ $PUSH == 0 ]
  then
    test "$GIT" -eq 1 &&  { cd $DOTFILES_DIR ; git pull ; } 
    while true ;
    do
        answer="y"
        echo "Diff applied to home directory files"
        for f in ${dots[@]} ;
        do
          diff --color $HOME/$f $DOTFILES_DIR/${f:1} 
        done
        for d in ${dirs[@]} ;
        do
          diff --color $HOME/$d $DOTFILES_DIR/${d:1}
        done
        test "$SKIP" -eq 0 && read -rp "This will overwrite dotfiles in your home directory.  Continue? [y/n]: " answer
        case $answer in
            [Yy] ) break ;;
            [Nn] ) return 1; ;;
            * ) test "$YES" -eq 1 || echo "Please answer y or n."
        esac
    done
    for f in ${dots[@]} ;
    do
      cp $DOTFILES_DIR/${f:1} $HOME/$f
    done
    for d in ${dirs[@]} ;
    do
      rm -r $HOME/$d
      cp -r $DOTFILES_DIR/${d:1} $HOME/$d
    done
  # Local -> Repo
  else
    test "$GIT" -eq 1 &&  { cd $DOTFILES_DIR ; git pull ; } 
    for f in ${dots[@]} ;
    do
      # Omit leading . in repo
      cp $HOME/$f $DOTFILES_DIR/${f:1}
    done
    for d in ${dirs[@]} ;
    do
      # Omit leading . in repo
      rm -r $DOTFILES_DIR/${d:1}
      cp -r $HOME/$d $DOTFILES_DIR/${d:1}
    done
    test "$GIT" -eq 1 &&  { cd $DOTFILES_DIR ; git add * ; git commit ; git push ; } 
  fi
}
