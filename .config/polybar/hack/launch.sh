#!/usr/bin/env bash

# Add this script to your wm startup file.

DIR="$HOME/.config/polybar/hack"

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 0.1; done

# Chose a diplay on which the system tray will be shown
TRAY_DISPLAY="DisplayPort-0"

for m in $(polybar --list-monitors | cut -d":" -f1); do
    if [ "$TRAY_DISPLAY" == "$m" ]; then
        TRAY_POSITION="right"
    else
        TRAY_POSITION="none"
    fi

    MONITOR="$m" polybar -q top -c "$DIR"/config.ini &
    TRAY_POSITION="$TRAY_POSITION" MONITOR="$m" polybar -q bottom -c "$DIR"/config.ini &
done

# Launch the bar
# polybar -q top -c "$DIR"/config.ini &
# polybar -q bottom -c "$DIR"/config.ini &
