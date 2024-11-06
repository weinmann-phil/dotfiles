#!/bin/bash
#
# Module with helper functions for system aliases

###########################################################
# Encode string to Base64 string
#
# This function
###########################################################
function encode_string_to_base64 {
  INPUT=$1
  echo -n $INPUT | base64
}

###########################################################
# Decode Base64 string to human readable
#
# This function takes a base64 encoded string and converts
# it to human readable form.
#
# ARGS:
#   B64STRING: A base64 encoded string
# RETURN:
#   None.
# RAISE:
#   None.
###########################################################
function decode_base64_to_string {
  INPUT=$1
  echo $INPUT | base64 --decode; echo ""
}

###########################################################
# Update and Upgrade System
#
# Uses the standard package manager to update and upgrade
# the system.
#
# ARGS:
#   None.
# RETURNS:
#   None.
# RAISES:
#   None.
###########################################################
function update_and_upgrade_system {
  sudo apt update && sudo apt upgrade -y
}

###########################################################
# 
###########################################################


