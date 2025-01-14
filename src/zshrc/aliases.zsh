alias ll='ls -alF'
alias me='cd ~/git/weinmann-phil'

# Powerline configuration
#export PATH="$PATH:"

if [ -f /usr/share/powerline/bindings/bash/powerline.sh ]; then
  powerline-daemon -q
  POWERLINE_BASH_CONTINUATION=1
  POWERLINE_BASH_SELECT=1
  source /usr/share/powerline/bindings/bash/powerline.sh
fi
