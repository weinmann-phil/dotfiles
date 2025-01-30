# Installation instructions

## oh-my-zsh

> **Requirements:**
>
> * curl | wget | fetch

1. Install the base oh-my-zsh
```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
1. Override/Customize the `.zshrc` file
1. Install plugins
```sh
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/pluginz/zsh-syntax-highlighting
```
