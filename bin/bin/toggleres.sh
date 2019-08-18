#!/bin/sh

if [ "$(xdpyinfo | grep dimensions | awk '{print $2}')"  == "3440x1440" ]; then
  sh ~/.screenlayout/stream.sh
else
  sh ~/.screenlayout/normal.sh
fi
