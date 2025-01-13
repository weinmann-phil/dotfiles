# Basic Aliases

alias g='git'
alias ga='git add'
alias gf='git fetch'
alias gs='git status'
alias gd='git diff'
alias gm='git merge'
alias gc='git commit -v'
alias gcm='git commit -m'

source=~/.config/helper.sh

# Alias functions (for more complex aliases)
function git_init {
  local PROJECT_NAME="${1:=.}"
  local BRANCH="${2:=main}"

  git init $PROJECT_NAME --initial-branch=$BRANCH
}

alias gi=$(git_init)

function format_branch_names {
  local BRANCH=$1
  
  removeTrailingSpecialChars $BRANCH   
  local COUNT=$(echo $BRANCH | grep -o "/" | wc -l)
  if [[ $COUNT == 0 ]]; then
    BRANCH="feature/$BRANCH"
  else
    if [[ ! "$BRANCH" =~ '(feature|bugfix|hotfix|release|docs)/^[[:alnum:]][-[:alnum:]]' ]]; then
      echo "Invalid branch name!"
      exit 1
    fi
  fi
  echo $BRANCH 
}

function git_checkout_create {
  local BRANCH_NAME=$1

  if [[ -z $BRANCH_NAME ]]; then
    echo "What should be the branche's name?"
    read $BRANCH_NAME    
  fi
  removeTrailingSpecialChars $BRANCH_NAME

  git checkout -B $BRANCH_NAME
}

alias gco=$(git_checkout_create)
