#!/usr/bin/env bash

cd "$(dirname $0)/dotfiles"
PROJECT_DIR="$(pwd)"

LINKS=(
	.config/*
	$(find . -maxdepth 1 -type f -printf '%P\n')
	.local/share/applications/*.desktop
)

for link in "${LINKS[@]}"; do
	echo "$link"
	ln -sf "$PROJECT_DIR"/"$link" $HOME/"$(dirname "$link")"
done

FIREFOX_DIR=$HOME/.mozilla/firefox/*.default-release/
for link in "$PROJECT_DIR"/.mozilla/firefox/*; do
	echo "$link"
	ln -sf "$link" $FIREFOX_DIR
done
