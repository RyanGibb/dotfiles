
export VISUAL=nvim
export EDITOR=nvim
export GOPATH=$HOME/.go

# https://github.com/boltgolt/howdy/issues/241
export OPENCV_LOG_LEVEL=ERROR

# Autostart sway at login on TTY 1
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
	exec ~/.config/sway/scripts/start.sh
fi
