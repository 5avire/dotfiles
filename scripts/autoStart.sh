#!/bin/sh

#Clipboard Stuff
export XDG_RUNTIME_DIR="/run/user/$(id -u)"

# Network Manager
pkill nm-applet
(nm-applet) &

# Waybar
pkill waybar
(waybar) &

# Wallpaper
pkill awww-daemon
(awww-daemon) &

# Notifications
pkill mako
(mako) &

# kdeconnectd
pkill kdeconnectd
(kdeconnectd) &

# ---- cliphist (safe) ----
pgrep -x wl-paste >/dev/null || {
  wl-paste --type text --watch cliphist store --max-items 25 &
  wl-paste --type image --watch cliphist store --max-items 25 &
}
