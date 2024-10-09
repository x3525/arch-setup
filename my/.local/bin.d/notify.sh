#!/bin/bash

case $1 in
    audio)
        pamixer -"$2" 10 --allow-boost --set-limit 150

        if pamixer --get-mute | grep -q -- 'true'
        then
            ICON=volume-level-none
        else
            ICON=volume-level-high
        fi

        dunstify -u L -h string:x-dunst-stack-tag:all -i "$ICON" "Volume" -h int:value:"$(pamixer --get-volume)"
        ;;
    touchpad)
        xinput "$2" "$(xinput list | grep -- 'Touchpad' | grep -P -o -- '(?<=id=)[0-9]+')"
        dunstify -u L -h string:x-dunst-stack-tag:all -i touchpad-indicator-light-"$2"d "Touchpad" "Device is ${2}d"
        ;;
    battery)
        case $2 in
            C)
                dunstify -u L -h string:x-dunst-stack-tag:battery -i battery-"$3"-charging "Battery" "Battery is charging..."
                ;;
            D)
                dunstify -u N -h string:x-dunst-stack-tag:battery -i battery-"$3" "Battery" "Battery is discharging..."
                ;;
            F)
                ;;
            N)
                dunstify -u L -h string:x-dunst-stack-tag:battery -i battery-ac-adapter "Battery" "Plugged in, not charging"
                ;;
            U)
                dunstify -u N -h string:x-dunst-stack-tag:battery -i battery-missing "Battery" "Battery status unknown"
                ;;
        esac
        ;;
esac
