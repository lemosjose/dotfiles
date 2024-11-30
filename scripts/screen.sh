#!/bin/sh
#
if [[ -z "$(xrandr | grep ' connected' | grep 'HDMI-1-1')" ]]; then
	xrandr --output eDP-1 --primary --mode 1366x768 --pos 1194x1080 --rotate normal --output HDMI-1 --mode 2560x1080 --pos 0x0 --rotate normal --output DP-1 --off
else
	xrandr --output eDP-1 --primary --mode 1366x768 --pos 1194x1080 --rotate normal --output HDMI-1-1 --mode 2560x1080 --pos 0x0 --rotate normal --output DP-1 --off

fi
