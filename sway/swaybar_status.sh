#!/bin/bash

while true; do
    DATE=$(date +'%Y-%m-%d %H:%M:%S')
    
    # CPU info
    CPU_INFO=$(top -bn1 | grep '%Cpu(s):' | awk '{print "CPU: " $2 + $4 "%"}')

    # RAM info
    RAM_INFO=$(free -m | awk '/^Mem:/ {print "RAM: " $3 "/" $2 "MB"}')

    # Battery info
    UPOWER_OUTPUT=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0)
    BATTERY_STATE=$(echo "$UPOWER_OUTPUT" | grep 'state' | awk '{print $2}')
    BATTERY_PERCENTAGE=$(echo "$UPOWER_OUTPUT" | grep 'percentage' | awk '{print $2}')

    if [ -n "$BATTERY_PERCENTAGE" ]; then
        TIME_REMAINING=""
        case "$BATTERY_STATE" in
            "charging")
                BATTERY_ICON="🔌"
                TIME_REMAINING=$(echo "$UPOWER_OUTPUT" | grep 'time to full' | awk '{print $4, $5}')
                ;;
            "fully-charged")
                BATTERY_ICON="🔋"
                ;;
            "discharging")
                BATTERY_ICON="🔋"
                TIME_REMAINING=$(echo "$UPOWER_OUTPUT" | grep 'time to empty' | awk '{print $4, $5}')
                ;;
            *)
                BATTERY_ICON="🔋"
                ;;
        esac
        
        if [ -n "$TIME_REMAINING" ]; then
            BATTERY_INFO="${BATTERY_ICON} ${TIME_REMAINING} (${BATTERY_PERCENTAGE})"
        else
            BATTERY_INFO="${BATTERY_ICON} ${BATTERY_PERCENTAGE}"
        fi
    else
        BATTERY_ICON="🔋"
        BATTERY_PERCENTAGE="N/A"
        BATTERY_INFO="${BATTERY_ICON} ${BATTERY_PERCENTAGE}"
    fi
    # Volume info
    VOLUME_INFO=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{ if ($3 == "[MUTED]") { print "🔊 Muted" } else { printf "🔊 %.0f%%", $2 * 100 } }')

    echo "$VOLUME_INFO | $CPU_INFO | $RAM_INFO | $BATTERY_INFO | $DATE"
    sleep 2
done
