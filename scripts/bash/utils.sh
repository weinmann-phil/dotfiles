#!/bin/bash
#
# Aliases for bash snippets

alias ll='ls -alF'
alias fh='history | grep -i'
alias up='sudo apt update'
alias ug='sudo apt update && sudo apt upgrade -y'

function convert_base64_to_string {
  local BASE64=$1

  echo $BASE64 | base64 --decode
}

alias b2str=$(convert_base64_to_string)

function convert_string_to_base64 {
  local STRING=$1

  echo -n $STRING | base64
}

alias str2b=$(convert_string_to_base64)

function find_item {
  local BASE_NODE=$1
  local TARGET=$2

  find $BASE_NODE -name $TARGET
}

alias find=$(find_item)

function check_url_format {
  local URL=$1

  local regex='(https?|ftp|file)://[-[:alnum:]\+&@#/%?=~_|!:,.;]*[-[:alnum:]\+&@#/%=~_|]'

  if [[ $URL =~ $regex ]]; then
    echo "The URL ($URL) appears to be valid."
  fi
}

function look_up_url {
  local URL=$1

  LOOK_UP_ADDRESS=$(nslookup $URL)
  ADDRESS_COUNT=$(echo $LOOK_UP_ADDRESS | grep -ic address)
  if [[ $ADDRESS_COUNT == 2 ]]; then
    echo "tbd"
  fi
}

function tbd {
  local URL=$1
  
  check_url_format $URL
  
}
