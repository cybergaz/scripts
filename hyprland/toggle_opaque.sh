if [ -e $XDG_RUNTIME_DIR/opaque_toggled ]; then
    hyprctl keyword decoration:dim_inactive 0
    hyprctl keyword decoration:inactive_opacity 1.05
    rm -rf $XDG_RUNTIME_DIR/opaque_toggled
    exit
fi
hyprctl keyword decoration:dim_inactive 1
hyprctl keyword decoration:inactive_opacity 0.75
touch $XDG_RUNTIME_DIR/opaque_toggled
