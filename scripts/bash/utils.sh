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

#################################################
# Function to check the validity of an URL
#
# This function takes a string and checks if its
# form is compatible with a valid URL.
#
# Args:
#   URL: A string representing a digital address.
# Returns:
#   An integer represting the status code of the
#   function.
# Raises:
#   None.
#################################################
function check_url_format {
  local URL=$1

  local regex='(https?|ftp|file)://[-[:alnum:]\+&@#/%?=~_|!:,.;]*[-[:alnum:]\+&@#/%=~_|]'

  if [[ $URL =~ $regex ]]; then
    echo "The URL ($URL) appears to be valid."
  fi
}

#################################################
# Function to look up an URL address 
#
# This function takes an URL and performs several
# tests and initial static analyses with 
# different toolings
#
# Args:
#   URL: A string representing the URL address of
#     an application
# Returns:
#   A file with many relevant network information
# Raises:
#   None.
#################################################
function look_up_url {
  local URL=$1

  LOOK_UP_ADDRESS=$(nslookup $URL)
  ADDRESS_COUNT=$(echo $LOOK_UP_ADDRESS | grep -ic address)
  if [[ $ADDRESS_COUNT == 2 ]]; then
    IP=$(nslookup $URL | grep -oE '((1?[0-9]?[0-9|2[0-4][0-9]|25[0-5])\.){3}(1?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])')
    
  fi
}

function tbd {
  local URL=$1
  
  check_url_format $URL
  
}


################################################
# Function to generate a random password
#
# This function takes up a number as the length
# of the output and generates a random string to
# be used as a password.
#
# Args:
#   LENGTH: An integer representing the length of
#     the password.
# Returns:
#   A string representing the generated password.
# Raises:
#   None.
#################################################
function generate_random_password {
  local LENGTH=$1

  result=$(tr -dc '0-9a-zA-Z!£\$%^&*_\-=+~@:;#' < /dev/urandom | head -c $LENGTH)
  echo $result
}

alias pass=$(generate_random_password)



