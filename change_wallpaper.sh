#!/bin/bash

while true; do

    h=`date +%H`
    date=`date`

    if [ $h -lt 19 ] && [ $h -gt 07 ] ; then
        feh --bg-center /home/rodrigo/dotfiles/wallpaper.jpg
    else
        feh --bg-center /home/rodrigo/dotfiles/wallpaper-night.jpg
    fi

    sleep 15m
done
