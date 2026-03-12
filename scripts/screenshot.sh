#!usr/bin/env bash

# Directory to save screenshots
SAVE_DIR="$HOME/Screenshots"
mkdir -p "$SAVE_DIR"

# Generate filename with timestamp
FILENAME="$(date +'%Y-%m-%d_%H-%M-%S').png"
TEMP_FILE="/tmp/$FILENAME"
FINAL_FILE="$SAVE_DIR/$FILENAME"

# 1. Capture the screenshot to a temp file
grim -g "$(slurp)" "$TEMP_FILE"

# If user cancelled selection (file doesn't exist), exit
if [ ! -f "$TEMP_FILE" ]; then
  exit 1
fi

# 2. Copy to clipboard
wl-copy <"$TEMP_FILE"

# 3. Send notification with actions
# -i: shows the image preview
# --action: creates buttons
# --wait: pauses script until you click a button or it times out
ACTION=$(notify-send \
  -i "$TEMP_FILE" \
  "Screenshot Captured" \
  "Saved to buffer. Choose action:" \
  --action="trash=Delete" \
  --action="view=Open" \
  --wait)

# 4. Handle the user's choice
case "$ACTION" in
"trash")
  rm "$TEMP_FILE"
  notify-send "Screenshot Deleted" -t 2000
  ;;
"view")
  mv "$TEMP_FILE" "$FINAL_FILE"
  xdg-open "$FINAL_FILE"
  ;;
*)
  # If timeout or dismissed, just save it
  mv "$TEMP_FILE" "$FINAL_FILE"
  ;;
esac
