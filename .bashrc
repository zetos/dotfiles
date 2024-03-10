#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# add ghcup binaries to path (cabal, stack, etc)
export PATH="$PATH:$HOME/.ghcup/bin"

# Init nvm
source /usr/share/nvm/init-nvm.sh
