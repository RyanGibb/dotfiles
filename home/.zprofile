
export VISUAL=nvim
export EDITOR=nvim
export GOPATH=$HOME/.go

# Autostart sway at login on TTY 1
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
	exec ~/.config/sway/scripts/start.sh
fi
