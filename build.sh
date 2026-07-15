#!/usr/bin/env bash
set -euo pipefail

DOTS_DIR="$HOME/dots"
CONFIG_SRC="$DOTS_DIR/config"
HOME_SRC="$DOTS_DIR/home"

link_dir() {
    local src_dir="$1"
    local dest_dir="$2"

    for item in "$src_dir"/*; do
        [ -e "$item" ] || continue
        name=$(basename "$item")
        target="$dest_dir/$name"

        if [ -L "$target" ]; then
            rm "$target"
        elif [ -e "$target" ]; then
            echo "Backing up existing $target -> ${target}.bak"
            mv "$target" "${target}.bak"
        fi

        ln -s "$item" "$target"
        echo "Linked: $target -> $item"
    done
}

mkdir -p "$HOME/.config"

if [ -d "$CONFIG_SRC" ]; then
    link_dir "$CONFIG_SRC" "$HOME/.config"
fi

if [ -d "$HOME_SRC" ]; then
    link_dir "$HOME_SRC" "$HOME"
fi

echo "Done."
