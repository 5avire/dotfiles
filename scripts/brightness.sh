#!/usr/bin/env bash
set -euo pipefail

DIRECTION="${1:-}"
STEP=5
MIN_BRIGHT=1

case "$DIRECTION" in
    raise)
        brightnessctl set "+${STEP}%"
        ;;
    lower)
        CURRENT=$(brightnessctl -m | cut -d, -f4 | tr -d '%')
        NEW=$(( CURRENT - STEP ))
        if [ "$NEW" -lt "$MIN_BRIGHT" ]; then
            brightnessctl set "${MIN_BRIGHT}%"
        else
            brightnessctl set "${STEP}%-"
        fi
        ;;
    *)
        echo "Usage: $0 [raise|lower]"
        exit 1
        ;;
esac

BRIGHT=$(brightnessctl -m | cut -d, -f4 | tr -d '%')

# round to nearest 10 for display only
DISPLAY_BRIGHT=$(( ((BRIGHT + 2) / 5) * 5 ))

BAR_LENGTH=25
FILLED=$(( DISPLAY_BRIGHT * BAR_LENGTH / 100 ))
EMPTY=$(( BAR_LENGTH - FILLED ))

BAR=""
[ "$FILLED" -gt 0 ] && BAR+=$(printf '▮%.0s' $(seq 1 "$FILLED"))
[ "$EMPTY" -gt 0 ] && BAR+=$(printf '▯%.0s' $(seq 1 "$EMPTY"))

TEXT="$BAR $DISPLAY_BRIGHT%"

notify-send -a "brightness-osd" -r 9992 -t 1500 -h string:x-canonical-private-synchronous:brightness "" "$TEXT"
