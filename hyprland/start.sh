#!/usr/bin/env bash

swww init &
swww img ~/dotfiles/gluee.png &
swayidle -w &
nm-applet --indicator &

waybar &

mako
