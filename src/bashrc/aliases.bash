# ALIAS CONFIGURATIONS
source ~/.config/bash/utils.sh
source ~/.config/bash/helper.sh
source ~/.config/git/git-aliases.sh

# Powerline configuration
if [ -f /usr/share/powerline/bindings/bash/powerline.sh ]; then
  powerline-daemon -q
  POWERLINE_BASH_CONTINUATION=1
  POWERLINE_BASH_SELECT=1
  source /usr/share/powerline/bindings/bash/powerline.sh
fi
