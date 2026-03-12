#!/bin/sh

#Clipboard Stuff

export XDG_RUNTIME_DIR="/run/user/$(id -u)"
export WAYLAND_DISPLAY=wayland-1

# Network Manager
pkill nm-applet
(nm-applet) &

# Waybar
pkill waybar
(waybar) &

# Notification Daemon
pkill swww-daemon
(swww-daemon) &

# Notification
pkill swaync
(swaync) &

# Sway SwayOSD
pkill swayosd-server
(swayosd-server) &

# kdeconnectd
pkill kdeconnectd
(kdeconnectd) &

# ---- cliphist (safe) ----
pgrep -x wl-paste >/dev/null || {
  wl-paste --type text --watch cliphist store --max-items 25 &
  wl-paste --type image --watch cliphist store --max-items 25 &
}
