-- Cursor size
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- Force all apps to use Wayland
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_STYLE_OVERRIDE", "kvantum")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
hl.env("OZONE_PLATFORM", "wayland")
hl.env("XDG_SESSION_TYPE", "wayland")

-- Allow better support for screen sharing
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

hl.config({
    xwayland = {
        force_zero_scaling = true,
    },

    -- Don't show update on first launch
    ecosystem = {
        no_update_news = true,
    },

    -- Hyprland 0.57 turned this on by default. On older Intel iGPUs it hides
    -- the buffer formats OpenGL apps need, so Alacritty never opens a window
    -- and Steam renders garbage. false = the pre-0.57 behaviour.
    quirks = {
        skip_non_kms_dmabuf_formats = false,
    },
})
