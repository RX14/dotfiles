#!/bin/sh

if [ "$#" -eq 0 ]; then
    jq -r 'to_entries[] | "\(.key) \(.value.name)"' < ~/.config/rofi/emoji.json
    exit
fi

wl-copy "$1"
