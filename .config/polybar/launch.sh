#!/bin/sh

pgrep polybar && killall polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
polybar --config=$XDG_CONFIG_HOME/polybar/config.ini default &

until [ ! -S "/tmp/bspwm_$DISPLAY_0" ]; do
    sleep 1
done
    
