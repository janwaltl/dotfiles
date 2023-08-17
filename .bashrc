# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

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

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

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

if [ -f /usr/share/doc/fzf/examples/key-bindings.bash ]; then
	source /usr/share/doc/fzf/examples/key-bindings.bash
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

PS1='\[\e[0;92m\]\u\[\e[0m\]@\[\e[0;91m\]\h\[\e[0m\]|\[\e[0;96m\]\w\[\e[0m\]|\[\e[0;38;5;208m\]$(git branch 2>/dev/null | grep '"'"'^*'"'"' | colrm 1 2)\[\e[0m\]:\n\[\e[0m\]>\[\e[0m\]'
TERM=xterm-256color


# Add local BIN 
export PATH=$HOME/.local/bin:$PATH
export PATH=$PATH:/usr/local/go/bin
export EDITOR=nvim
export FZF_DEFAULT_COMMAND='rg --files --hidden'
# Make GPG signing work in my terminal
export GPG_TTY=$(tty)

# Use vim bindings for cmdline
set -o vi
bind '"jk":vi-movement-mode'

# Init Rust
. "$HOME/.cargo/env"
