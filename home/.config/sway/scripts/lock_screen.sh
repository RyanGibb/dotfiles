#!/usr/bin/env bash

# https://github.com/ggreer/dotfiles/blob/master/lock-screen

LOCKFILE=/tmp/sway.lock

if [ -f $LOCKFILE ]
then
  echo 'swaylock already running'
  exit 0
fi

# handle being called from systemd service
if [ -z "$XDG_RUNTIME_DIR" ] && [ -z "$SWAYSOCK" ]
then
  if [ -z "$USER" ]
  then
    # Horrible hack
    USER=ryan
  fi
  uid=$(id -u "$USER")
  export XDG_RUNTIME_DIR="/run/user/$uid/"
  SWAYSOCK=$(find "$XDG_RUNTIME_DIR" -maxdepth 1 -iname "sway*sock")
  export SWAYSOCK
  echo "$SWAYSOCK" > ~/x
  export WAYLAND_DISPLAY="wayland-1"
fi

touch $LOCKFILE
swaylock -f -i "/home/$USER/pictures/wallpapers/default" --font "monospace"
rm $LOCKFILE
