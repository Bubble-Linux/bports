#!/bin/bash

# Get the list of all workspaces
workspaces=$(i3-msg -t get_workspaces | jq -r '.[].name' | sort -n)

# Get the current workspace
current_workspace=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true).name')

# Use rofi to display the list and let the user select a workspace
# The -theme option specifies our custom theme
selected=$(echo "$workspaces" | rofi -dmenu -p "Select workspace:" -i -select "$current_workspace")

# If a workspace was selected, switch to it
if [ -n "$selected" ]; then
    i3-msg workspace "$selected"
fi
