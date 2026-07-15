#!/usr/bin/env bash
set -euo pipefail

WALLPAPER_DIR="$HOME/dots/wallpapers"
CURRENT_FILE="$WALLPAPER_DIR/current.wallpaper"
ROFI_BG_LINK="$WALLPAPER_DIR/rofi-bg"

SELECTED=$(find "$WALLPAPER_DIR" -maxdepth 1 -type f \( \
    -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \
    -o -iname "*.webp" -o -iname "*.bmp" \) \
    | fzf --prompt="Wallpaper> " \
          --preview='chafa --clear --size=${FZF_PREVIEW_COLUMNS}x${FZF_PREVIEW_LINES} --align=center {}' \
          --preview-window="right:50%")

if [ -z "$SELECTED" ]; then
    echo "No wallpaper selected."
    exit 0
fi

REAL_PATH="$(realpath "$SELECTED")"
echo "$REAL_PATH" > "$CURRENT_FILE"

if [ -L "$ROFI_BG_LINK" ]; then
    rm "$ROFI_BG_LINK"
elif [ -e "$ROFI_BG_LINK" ]; then
    rm "$ROFI_BG_LINK"
fi
ln -s "$REAL_PATH" "$ROFI_BG_LINK"

awww img "$REAL_PATH" &

echo "Wallpaper set: $SELECTED"
