#!/bin/bash
#
# Cronjob for regular system updates

local OS=$(lsb_release -is 2>/dev/null)

if [ "$OS" == "Ubuntu" ]; then
  apt update && apt upgrade -y
  snap refresh
fi

