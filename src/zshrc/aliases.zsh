# PERSONAL ALIASES
alias me='cd ~/git/weinmann-phil/'

# ALIAS CONFIGURATIONS
source ~/.config/bash/utils.sh
source ~/.config/bash/helper.sh
source ~/.config/git/git-aliases.sh
source ~/.config/kubernetes/kubectl-aliases.sh

# POWERLINE CONFIGURATION
if [ -f /usr/share/powerline/bindings/zsh/powerline.zsh ]; then
  powerline-daemon -q
  POWERLINE_BASH_CONTINUATION=1
  POWERLINE_BASH_SELECT=1
  source /usr/share/powerline/bindings/zsh/powerline.zsh
fi
