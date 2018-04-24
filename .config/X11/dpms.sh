#!/bin/sh
if (xrandr | grep -q 'HDMI1 connected') || [[ $(cat /sys/class/power_supply/BAT1/status) != "Discharging" ]]; then
    xset s off -dpms
else
    xset s 600 600 +dpms
    xset dpms 600 600 600
fi
