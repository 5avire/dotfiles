#!/usr/bin/env bash
# Simple wallpaper picker for Hyprland using rofi thumbnails + swww

set -euo pipefail

# ──────────────────────────────────────────────
# CONFIG
WALLPAPER_DIR="$HOME/dotfiles/wallpaper"
THUMB_DIR="$HOME/.cache/rofi_wallthumbs" # thumbnail cache
THEME="$HOME/dotfiles/rofi/minimal.rasi"
# ──────────────────────────────────────────────

# Dependencies
command -v rofi >/dev/null || {
  echo "rofi not installed"
  exit 1
}
command -v swww >/dev/null || {
  echo "swww not installed"
  exit 1
}
command -v magick >/dev/null || {
  echo "imagemagick not installed"
  exit 1
}

[[ ! -d "$WALLPAPER_DIR" ]] && {
  notify-send -u critical "Wallpaper Error" "Directory not found: $WALLPAPER_DIR"
  exit 1
}

mkdir -p "$THUMB_DIR"

# ──────────────────────────────────────────────
# Collect wallpapers + generate thumbnails
mapfile -t WALLS < <(find "$WALLPAPER_DIR" -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" \) | sort)

entries=()
for wall in "${WALLS[@]}"; do
  base=$(basename "$wall")
  thumb="$THUMB_DIR/${base%.*}.jpg"

  # Generate thumb only if missing (cached)
  [[ ! -f "$thumb" ]] && magick "$wall" -resize 300x300^ -gravity center -extent 300x300 "$thumb"

  # filename for search (hidden in CSS) + icon for preview
  entries+=("$base\0icon\x1f$thumb")
done

# ──────────────────────────────────────────────
# Launch rofi with thumbnail theme
if [[ ${#entries[@]} -eq 0 ]]; then
  notify-send "No wallpapers found"
  exit 1
fi

# Get selected index (-format i)
index=$(printf "%s\n" "${entries[@]}" |
  rofi -dmenu -format i -p "" -i \
    -theme "$THEME")

[[ -z "$index" ]] && exit 0 # cancelled

selected_wall="${WALLS[$index]}"

# ──────────────────────────────────────────────
# Set wallpaper
echo "Setting: $(basename "$selected_wall")"

swww img "$selected_wall" \
  --transition-fps 90 \
  --transition-type wipe \
  --transition-duration 1.4 \
  --resize fit

notify-send -i "$(realpath "$selected_wall")" "Wallpaper changed" "$(basename "$selected_wall")"
