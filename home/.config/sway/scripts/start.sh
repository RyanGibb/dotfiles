export QT_QPA_PLATFORM=wayland
export SDL_VIDEODRIVER=wayland
export MOZ_ENABLE_WAYLAND=1
export MOZ_DBUS_REMOTE=1
export QT_STYLE_OVERRIDE=Fusion
export GRIM_DEFAULT_DIR=~/pictures/screenshots/
export TERMINAL=alacritty
export WLR_NO_HARDWARE_CURSORS=1

# for intellij
export _JAVA_AWT_WM_NONREPARENTING=1

# for fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

exec sway &> $HOME/.sway_log

