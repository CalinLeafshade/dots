#!/bin/sh

if [ "$(xdpyinfo | grep dimensions | awk '{print $2}')"  == "8560x1440" ]; then
  sh ~/.screenlayout/stream.sh
else
  sh ~/.screenlayout/default.sh
fi

sh ~/.config/polybar/launch.sh
