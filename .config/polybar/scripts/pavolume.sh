#!/usr/bin/env bash

# Configuration
inc=5  # volume step increment
sink=$(pactl get-default-sink)

get_volume() {
    pactl get-sink-volume "$sink" | awk '{print $5}' | head -n1
}

is_muted() {
    pactl get-sink-mute "$sink" | awk '{print $2}'
}

print_status() {
    volume=$(get_volume)
    muted=$(is_muted)

    if [[ "$muted" == "yes" ]]; then
        icon=""
        echo "$icon muted"
    else
        vol_percent=${volume%\%}
        if (( vol_percent < 30 )); then
            icon=""
        elif (( vol_percent < 70 )); then
            icon=""
        else
            icon=""
        fi
        echo "$icon $volume"
    fi
}

volume_up() {
    pactl set-sink-volume "$sink" "+${inc}%"
}

volume_down() {
    pactl set-sink-volume "$sink" "-${inc}%"
}

toggle_mute() {
    pactl set-sink-mute "$sink" toggle
}

# Main entry
case "$1" in
    --up) volume_up ;;
    --down) volume_down ;;
    --mute) toggle_mute ;;
    --status | *) print_status ;;
esac

