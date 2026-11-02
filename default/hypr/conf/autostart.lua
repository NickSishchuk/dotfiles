hl.on("hyprland.start", function()
    -- ===== UWSM Check =====
    hl.exec_cmd("~/.local/share/dotfiles/bin/check-uwsm")

    -- ===== Theme/cursor settings =====
    hl.exec_cmd("hyprctl setcursor Breeze-Dark 24")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'")
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")

    -- ===== Daemons/Services =====
    hl.exec_cmd("uwsm app -- mako")
    hl.exec_cmd("uwsm app -- hyprsunset")
    hl.exec_cmd("uwsm app -- hypridle")
    hl.exec_cmd("sleep 3 && uwsm app -- waybar")
    hl.exec_cmd("uwsm app -- swayosd-server")
    hl.exec_cmd("uwsm app -- walker --gapplication-service")
    hl.exec_cmd("uwsm app -- elephant")
    hl.exec_cmd("uwsm app -- swaybg -i ~/.local/share/dotfiles/current/background -m fill")
end)
