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
alias msys="cd $REPOS/msys"

alias refresh="source ~/.bashrc"
alias r="refresh"

# Open local file in google chrome
alias bopen="google-chrome $@"

# Docker compose
alias dc="sudo docker compose"

# Enable VI Mode
set -o vi

# Load scripts

SCRIPTS_DIR="$HOME/.bash_scripts"
alias scripts="cd $SCRIPTS_DIR"

for file in `find $SCRIPTS_DIR -name "*.sh"`
do
  source $file
done

# tmp
OLDHOME="/media/matt/390600a3-5ca7-44c1-98d9-11b38a26d409/home/matt/"
alias oldhome="cd $OLDHOME"

alias discordup="sudo dpkg -i \$(ls "$HOME/Downloads/discord-*" | sort | tail -n 1)"
