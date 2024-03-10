# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=200000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

cpd() {
    dir="$1"
    shift
    for f in "$@" ;
    do
        cp "$f" "$dir"
    done
}

alias htmltidy="tidy -q -i -m -w 160 -ashtml -utf8"

if [ "" != "$(which register-python-argcomplete3)" ]
then
  # Created by `pipx` on 2023-12-24 17:58:41
  export PATH="$PATH:/home/matt/.local/bin"
  eval "$(register-python-argcomplete3 pipx)"
fi

# Aliases
REPOS="$HOME/Documents/repos"
alias repos="cd $REPOS"
alias django="cd $REPOS/personal_site/django"
alias dotfiles="cd $REPOS/dotfiles"
alias mdoc="cd $REPOS/personal_site/mdoc"
alias personal_site="cd $REPOS/personal_site"
alias site="personal_site"
alias writing="cd $REPOS/writing"

alias gol="git log --oneline"
function god() {
    rev="$1"
    test -z $rev && { git diff HEAD ; return 0; }
    git diff $rev~1 $rev
}

alias refresh="source ~/.bashrc"
alias r="refresh"
alias sbluetooth="sudo bluetoothd -d -C -E -n"

# Open local file in google chrome
alias bopen="google-chrome $@"

# Docker compose
alias dc="sudo docker compose"

# Enable VI Mode
set -o vi

# Sync to dotfiles
dotsync() {
    dots=(".gitconfig" ".vimrc" ".bashrc" ".tmux.conf")

    read -r -d '' USAGE << EOM
dotsync [OPTIONS]

Synchronize local dotfiles between my repo and the local machine. By default, dotfiles are copied
from the repository to the local machines.  The following dotfiles are synched:

${dots[@]}

OPTIONS:
    -f: Don't prompt before overwriting files
    -g: Pull dotfiles git repository if it doesn't exist.
    -h: Display this message
    -p: Push dotfiles to repo.
EOM

  DOTFILES_DIR="$REPOS/dotfiles"
  REPO_URL="git@github.com:MatthewWEdwards/dotfiles.git"

  SKIP=0
  GIT=0
  PUSH=0
  local OPTIND
  while getopts fghp opt; do
      case $opt in
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

  # Repo -> Local
  if [ $PUSH == 0 ]
  then
    while true ;
    do
        answer="y"
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
  # Local -> Repo
  else
    for f in ${dots[@]} ;
    do
      # Omit leading . in repo
      cp $HOME/$f $DOTFILES_DIR/${f:1}
    done
  fi
}

# File transfers
DESKTOP_IP="192.168.0.100"
SERVER_IP="192.168.0.101"

from_desktop() {
  # Files
  file=$1
  dest=$2
  scp -r $DESKTOP_IP:$file $dest
}
alias scpfd="from_desktop"

to_desktop() {
  # Files
  file=$1
  dest=$2
  scp -r $file $DESKTOP_IP:$dest
}
alias scptd="to_desktop"

from_server() {
  # Files
  file=$1
  dest=$2
  scp -r $SERVER_IP:$file $dest
}
alias scpfs="from_server"

to_server() {
  # Files
  file=$1
  dest=$2
  scp -r $file $SERVER_IP:$dest
}
alias scpts="to_server"
