
#!/bin/bash

# Get a list of windows (title and PID) using jaq
windows=$(hyprctl -j clients | jaq -r '.[] | select(.title != "") | "\(.pid) \(.title)"')

# Ensure there are open windows
if [[ -z "$windows" ]]; then
    notify-send "No windows found"
    exit 1
fi

# Use rofi to select a window (displaying only the title)
selected=$(echo "$windows" | rofi -dmenu -i -p "Select Window" | awk '{print $1}')

# If a selection was made, switch to the window using the PID
if [[ -n "$selected" ]]; then
    hyprctl dispatch focuswindow pid:$selected
fi
