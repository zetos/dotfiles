#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# GHCup tools, Cabal-installed executables, local tools, and Bun. Cabal may use
# either executable directory depending on its configuration.
export PATH="$HOME/.ghcup/bin:$HOME/.cabal/bin:$HOME/.local/bin:$HOME/.bun/bin:$PATH"

# Init nvm
source /usr/share/nvm/init-nvm.sh

# Init Starship
eval "$(starship init bash)"

# Bash Completion
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
