# Basic Aliases

alias g='git'
alias ga='git add'
alias gf='git fetch'
alias gs='git status'
alias gd='git diff'
alias gm='git merge'
alias gc='git commit -v'
alias gcm='git commit -m'
alias gp='git pull'
alias gro='git remote add origin'
alias grb='git pull --rebase'
alias gpo='git push origin HEAD'

source=~/.config/bash/helper.sh

function get_base_gitignore {
  local HEADER=$1
  local GITIGNORE_BASE_URL=$2

  curl -H "${HEADER}" "${GITIGNORE_BASE_URL}Global/Linux.gitignore" -o .gitignore 
  echo "" >> .gitignore
  curl -H "${HEADER}" "${GITIGNORE_BASE_URL}Global/macOS.gitignore" >> .gitignore
  echo "" >> .gitignore
  curl -H "${HEADER}" "${GITIGNORE_BASE_URL}Global/Windows.gitignore" >> .gitignore
  echo "" >> .gitignore
  
}

#################################################
# Create a base repository
# 
# This function creates a simple project structure
# without any language specifications.
#
# Args:
#   HEADER: A string representing the content type 
#     of raw file date within GitHub.
#   GITIGNORE_BASE_URL: A string representing the
#     base URL for the GitHub API.
#################################################
function create_base_repo {
  local HEADER=$1
  local GITIGNORE_BASE_URL=$2

  touch README.md
  get_base_gitignore "${HEADER}" "${GITIGNORE_BASE_URL}"
  mkdir -p docs/ imgs/ scripts/ src/
}

#################################################
# Create a language specific repository
#
# This function creates a repository following
# the language settings for a set of given 
# languages.
#
# Args:
#   HEADER: A string representing the content type
#     of raw file date within GitHub
#   GITIGNORE_BASE_URL: A string representing the
#     base URL for the GitHub API
#   LANGUAGE: A string representing the language
#   PROJECT_NAME: A string representing the name
#     of the project
#################################################
function create_language_specific_repo {
  local HEADER=$1
  local GITIGNORE_BASE_URL=$2
  local LANGUAGE=$3
  local PROJECT_NAME=$4

  #touch README.md
  #get_base_gitignore $HEADER $GITIGNORE_BASE_URL

  case "$LANGUAGE" in
    ada)
      git init $PROJECT_NAME --initial-branch=main
      cd $PROJECT_NAME
      get_base_gitignore "${HEADER}" "${GITIGNORE_BASE_URL}"
      touch README.md
      mkdir -p docs/ src/Libraries src/Objects utils/ examples/
      curl -H "${HEADER}" "${GITIGNORE_BASE_URL}Ada.gitignore" >> .gitignore
      echo "" >> .gitignore
      ;;
    c++ | cpp)
      git init $PROJECT_NAME --initial-branch=main
      cd $PROJECT_NAME
      get_base_gitignore "${HEADER}" "${GITIGNORE_BASE_URL}"
      touch README.md
      mkdir -p docs/ include/ src/ tests/
      touch src/main.cpp
      curl -H "${HEADER}" "${GITIGNORE_BASE_URL}C++.gitignore" >> .gitignore
      echo "" >> .gitignore
      ;;
    c)
      git init $PROJECT_NAME --initial-branch=main
      cd $PROJECT_NAME
      get_base_gitignore "${HEADER}" "${GITIGNORE_BASE_URL}"
      touch README.md
      mkdir -p docs/ include/ src/ tests/
      touch src/main.c
      curl -H "${HEADER}" "${GITIGNORE_BASE_URL}C.gitignore" >> .gitignore
      echo "" >> .gitignore
      ;;
    go | golang)
      git init $PROJECT_NAME --initial-branch=main
      cd $PROJECT_NAME
      get_base_gitignore "${HEADER}" "${GITIGNORE_BASE_URL}"
      touch README.md
      mkdir -p docs/ cmd/ config/ _common/interfaces/ img/ internals/ provider/
      touch main.go
      curl -H "${HEADER}" "${GITIGNORE_BASE_URL}Go.gitignore" >> .gitignore
      echo "" >> .gitignore
      ;;
    haskell)
      git init $PROJECT_NAME --initial-branch=main
      cd $PROJECT_NAME
      get_base_gitignore "${HEADER}" "${GITIGNORE_BASE_URL}"
      touch README.md
      mkdir -p src/App src/cbits docs/examples/ docs/dev/ utils/ dist/build/ dist/docs/ dist/resources/ _DARCS/
      touch src/Main.lhs INSTALL.md app.cabal Setup.hs
      curl -H "${HEADER}" "${GITIGNORE_BASE_URL}Haskell.gitignore" >> .gitignore
      echo "" >> .gitignore
      ;;
    java)
      local JAVA_VERSION=23      # Possible versions are: 23, 21, and 17
      local TYPE='maven-project' # Possible values are: Gradle and Maven
      local BOOT_VERSION='3.4.2' # Versions vary significantly! Please check the actual or preferred versions
      local BOOT_OPTIONS='?type=${TYPE}&language=java&bootVersion=${BOOT_VERSION}&baseDir=${PROJECT_NAME}&groupId=com.weinmann-phil&artifactId=${PROJECT_NAME}&description=${PROJECT_NAME}&packageName=com.weinmann-phil.${PROJECT_NAME}&packaging=jar&javaVersion=$JAVA_VERSION'
      curl "https://start.spring.io/starter.zip${BOOT_OPTIONS}" -o "${PROJECT_NAME}.zip"
      unzip -Z "${PROJECT_NAME}.zip" "${PROJECT_NAME}"
      cd $PROJECT_NAME
      touch README.md
      mkdir docs
      curl -H "${HEADER}" "${GITIGNORE_BASE_URL}Java.gitignore" >> .gitignore
      echo "" >> .gitignore
      ;;
    lua)
      git init $PROJECT_NAME --initial-branch=main
      cd $PROJECT_NAME
      get_base_gitignore "${HEADER}" "${GITIGNORE_BASE_URL}"
      touch README.md
      mkdir -p docs/ src/ examples/
      touch src/init.lua
      curl -H "${HEADER}" "${GITIGNORE_BASE_URL}Lua.gitignore" >> .gitignore
      echo "" >> .gitignore
      ;;
    py | python)i
      python3 -m venv $PROJECT_NAME
      cd $PROJECT_NAME
      git init . --initial-branch=main
      mkdir docs/ src/ test/
      touch pyproject.toml requirements.txt
      curl -H "${HEADER}" "${GITIGNORE_BASE_URL}Python.gitignore" >> .gitignore
      echo "" >> .gitignore
      ;;
    rust)
      cargo new --vcs git $PROJECT_NAME
      cd $PROJECT_NAME
      touch README.md
      mkdir docs/
      curl -H "${HEADER}" "${GITIGNORE_BASE_URL}" >> .gitignore
      echo "" >> .gitignore
      ;;
    tf | terraform | tofu)
      git init $PROJECT_NAME --initial-branch=main
      cd $PROJECT_NAME
      get_base_gitignore "${HEADER}" "${GITIGNORE_BASE_URL}"
      touch README.md
      mkdir -p app/stack/ app/modules/ config/ environments/
      curl -H "${HEADER}" "${GITIGNORE_BASE_URL}Terraform.gitignore" >> .gitignore
      echo "" >> .gitignore
      ;;
  esac
}

# Alias functions (for more complex aliases)
function create_git_repo {
  local PROJECT_NAME="${1:=.}"
  local LANGUAGE=$2
  local BRANCH="${3:=main}"
  local HEADER='Accept: application/vnd.github.v3.raw'
  local GITIGNORE_BASE_URL='https://api.github.com/repos/github/gitignore/contents/'

  if [ "${PROJECT_NAME}" == "." ]; then
    git init . --initial-branch=main
  elif [ -z "${LANGUAGE}" ]; then
    git init "${PROJECT_NAME}" --initial-branch=main
    create_base_repo "${HEADER}" "${GITIGNORE_BASE_URL}"
  else
    create_language_specific_repo "${HEADER}" "${GITIGNORE_BASE_URL}" "${LANGUAGE}" "${PROJECT_NAME}"
  fi
  git init $PROJECT_NAME --initial-branch=$BRANCH
}

alias gi=create_git_repo

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

alias gco=git_checkout_create
