#!/bin/bash
#
# Helper scripts and functions

##################################################
# A function that prints out log messages
#
# This function standardises log messages to 
# print datetime information, as well as log level,
# and the message itself.
#
# Args:
#   LEVEL: A string representing the level of the
#     log message. Accepted values are `DEBUG`, 
#     `INFO`, `WARN`, and `ERROR`.
#   MESSAGE: A string representing the message.
# Returns:
#   None.
# Raises:
#   None.
##################################################
function log {
  local LEVEL=$1
  local MESSAGE=$2
}

function check_input_variable {
  local INPUT=$1

  if [ -z $INPUT ]; then
    log "WARN" "Empty input. Please define a value!"
  fi
}

##################################################
# A function to remove trailing special characters
#
# This function tests a string input and recursively
# removes any characters that are not alphanumeric.
#
# Args:
#   INPUT: A string representing any input value.
# Returns:
#   None.
# Raises:
#   None.
#################################################
function removeTrailingSpecialChars {
  local INPUT=$1
  local LAST_CHAR="${INPUT: -1}"

  if [[ $LAST_CHAR =~ [a-z0-9] ]]; then
    echo $INPUT
  else
    local SUBSTRING="${INPUT: 0: -1}"
    removeTrailingSpecialChars $SUBSTRING
  fi
}

