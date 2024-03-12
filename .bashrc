#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# add ghcup binaries to path (cabal, stack, etc)
export PATH="$PATH:$HOME/.ghcup/bin"

# add cabal binaries to path (xmonad)
# export PATH="$PATH:$HOME/.cabal/bin"
export PATH="$PATH:$HOME/.local/bin"

# Init nvm
source /usr/share/nvm/init-nvm.sh

# Init Starship
eval "$(starship init bash)"
