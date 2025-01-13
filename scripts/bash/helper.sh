#!/bin/bash
#
# Helper scripts and functions

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

