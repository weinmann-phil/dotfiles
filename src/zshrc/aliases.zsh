#!/bin/zsh 
alias ll='ls -alF'
alias me='cd ~/git/weinmann-phil'

## DOTFILES
# BASH
set source ~/.config/bash/utils.sh
set source ~/.config/git/git-aliases.sh

# Powerline configuration
#export PATH="$PATH:"

if [ -f "/usr/share/powerline/bindings/bash/powerline.sh" ] 
then
  powerline-daemon -q
  set POWERLINE_BASH_CONTINUATION 1
  set POWERLINE_BASH_SELECT 1
  source /usr/share/powerline/bindings/bash/powerline.sh
end
