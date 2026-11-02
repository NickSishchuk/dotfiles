---------------
--- SOURCES ---
---------------

--- Do not change
--- install/setup-by-hardware swaps the env and keybindings lines below for your
--- hardware (env/nvidia-env, desktop/laptop-keybindings).
require("~/.local/share/dotfiles/default/hypr/conf/autostart")
require("~/.local/share/dotfiles/default/hypr/conf/nvidia-env")
require("~/.local/share/dotfiles/default/hypr/conf/desktop-keybindings")
require("~/.local/share/dotfiles/default/hypr/conf/looknfeel")
require("~/.local/share/dotfiles/default/hypr/conf/windowrules")
require("~/.local/share/dotfiles/default/hypr/conf/layerrules")

--- The theme is optional: a theme without a hyprland.lua just keeps the default
--- border colour instead of breaking the whole config.
pcall(require, "~/.local/share/dotfiles/current/theme/hyprland")

--- Can change these, create more files and import here if needed
require("~/.config/hypr/conf/monitors")
require("~/.config/hypr/conf/input")
-- require("~/.config/hypr/my_custom_file")


--- Custom rules I'm too lazy to put in a separate file
-- Barotrauma
hl.window_rule({
    name  = "barotrauma-render-unfocused",
    match = { class = "^(Barotrauma)$" },
    render_unfocused = true,
})
