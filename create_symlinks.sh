#!/usr/bin/env bash

cd "$(dirname $0)/home"
PROJECT_DIR="$(pwd)"

LINKS=(
	$(find .config -type f -printf '.config/%P\n')
	$(find . -maxdepth 1 -type f -printf '%P\n')
	.local/share/applications/*.desktop
)

for link in "${LINKS[@]}"; do
	echo "$HOME/$(dirname "$link") -> $PROJECT_DIR/$link"
	mkdir -p "$HOME/$(dirname "$link")"
	ln -sf "$PROJECT_DIR/$link" "$HOME/$(dirname "$link")"
done

FIREFOX_DIR=$HOME/.mozilla/firefox/*.default-release/
for link in "$PROJECT_DIR"/.mozilla/firefox/*; do
	echo "$link"
	ln -sf "$link" $FIREFOX_DIR
done
