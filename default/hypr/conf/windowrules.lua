-- Floating windows
hl.window_rule({
    name  = "floating-window",
    match = { tag = "floating-window" },
    float = true, center = true, size = "800 600",
})
hl.window_rule({
    name  = "tag-floating-dialogs",
    match = {
        class = [[^(local\.xdg-desktop-portal-gtk|local\.sublime_text|local\.DesktopEditors|local\.org\.gnome\.Nautilus)$]],
        title = [[^(Open.*Files?|Open [Ff]older.*|Save.*Files?|Save.*As|Save|All Files)]],
    },
    tag = "+floating-window",
})

-- CLI tools
hl.window_rule({
    name  = "cli-tools",
    match = { class = [[^(local\.bluetui|local\.impala|local\.wiremix|local\.org\.gnome\.NautilusPreviewer|local\.com\.gabm\.satty)$]] },
    float = true, center = true, size = "800 600",
})

-- Floating generic class
hl.window_rule({
    name  = "local-floating",
    match = { class = [[^(local\.floating)$]] },
    float = true, center = true, size = "800 600",
})

-- Browser types
hl.window_rule({
    name  = "tag-chromium-based-browser",
    match = { class = [[([cC]hrom(e|ium)|[bB]rave-browser|Microsoft-edge|Vivaldi-stable|helium-browser)]] },
    tag   = "+chromium-based-browser",
})
hl.window_rule({
    name  = "tag-firefox-based-browser",
    match = { class = [[([fF]irefox|zen|zen-browser|zen-bin|librewolf)]] },
    tag   = "+firefox-based-browser",
})

-- Force chromium-based browsers into a tile to deal with --app bug
hl.window_rule({
    name  = "chromium-tile",
    match = { tag = "chromium-based-browser" },
    tile  = true,
})

-- Only a subtle opacity change, but not for video sites
hl.window_rule({ name = "chromium-opacity", match = { tag = "chromium-based-browser" }, opacity = "1 0.97" })
hl.window_rule({ name = "firefox-opacity",  match = { tag = "firefox-based-browser" },  opacity = "1 0.97" })

-- Some video sites should never have opacity applied to them
hl.window_rule({
    name    = "video-sites-opaque",
    match   = { initial_title = [[((?i)(?:[a-z0-9-]+\.)*youtube\.com_/|app\.zoom\.us_/wc/home)]] },
    opacity = "1.0 1.0",
})

-- No transparency on media windows
hl.window_rule({
    name    = "media-opaque",
    match   = { class = [[^(zoom|vlc|mpv|org.kde.kdenlive|com.obsproject.Studio|com.github.PintaProject.Pinta|imv|org.gnome.NautilusPreviewer)$]] },
    opacity = "1 1",
})


--- App specific tweaks

-- Localsend
hl.window_rule({
    name  = "localsend",
    match = { class = [[(Share|localsend)]] },
    float = true, center = true, size = "500 700",
})

-- waypaper
hl.window_rule({
    name  = "waypaper",
    match = { class = [[(waypaper)]] },
    float = true, center = true, size = "800 600",
})
