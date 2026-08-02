#!/usr/bin/env bash

sources=(
    "$HOME/dev:1:1"
    "$HOME/dots:1:2"
)

candidates=()
for src in "${sources[@]}"; do
    IFS=: read -r path mind maxd <<< "$src"
    [[ -d "$path" ]] || continue
    while IFS= read -r dir; do
        candidates+=("$dir")
    done < <(find "$path" -mindepth "$mind" -maxdepth "$maxd" -type d 2>/dev/null)
done

selected=$(printf '%s\n' "${candidates[@]}" | fzf)

[[ -z "$selected" ]] && exit 0

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s "$selected_name" -c "$selected"
    exit 0
fi

if ! tmux has-session -s "$selected_name" 2>/dev/null; then
    tmux new-session -ds "$selected_name" -c "$selected"
fi

tmux switch-client -t "$selected_name"
