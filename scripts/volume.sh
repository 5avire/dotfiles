#!/usr/bin/env bash
set -euo pipefail

DIRECTION="${1:-}"
STEP=5

case "$DIRECTION" in
    raise)
        wpctl set-volume @DEFAULT_AUDIO_SINK@ "${STEP}%+"
        ;;
    lower)
        wpctl set-volume @DEFAULT_AUDIO_SINK@ "${STEP}%-"
        ;;
    mute)
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        ;;
    *)
        echo "Usage: $0 [raise|lower|mute]"
        exit 1
        ;;
esac

VOL=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -oP '\d+\.\d+' | awk '{print int($1*100)}')
MUTED=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q "MUTED" && echo 1 || echo 0)

BAR_LENGTH=25
FILLED=$(( VOL * BAR_LENGTH / 100 ))
EMPTY=$(( BAR_LENGTH - FILLED ))

BAR=""
[ "$FILLED" -gt 0 ] && BAR+=$(printf '▮%.0s' $(seq 1 "$FILLED"))
[ "$EMPTY" -gt 0 ] && BAR+=$(printf '▯%.0s' $(seq 1 "$EMPTY"))

if [ "$MUTED" = "1" ]; then
    TEXT="Muted"
else
    TEXT="$BAR $VOL%"
fi

notify-send -r 9991 -t 1500 -h string:x-canonical-private-synchronous:volume "" "$TEXT"
