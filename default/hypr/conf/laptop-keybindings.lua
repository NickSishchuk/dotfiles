-- SUPER KEY
local mainMod  = "SUPER"
local terminal = "alacritty"

-- Every bind carries a description, which is what bin/menu-keybindings shows.
local function bind(keys, action, desc, opts)
    opts = opts or {}
    opts.description = desc
    hl.bind(keys, action, opts)
end

local exec = hl.dsp.exec_cmd
local M    = mainMod .. " + "

-- Applications
bind(M .. "Q", exec("uwsm app -- " .. terminal),          "Launch terminal")
bind(M .. "B", exec("uwsm app -- firefox"),               "Launch browser")
bind(M .. "E", exec("uwsm app -- nautilus --new-window"), "Launch file manager")

-- Windows
bind(M .. "W",         hl.dsp.window.close(), "Kill active window")
bind(M .. "SHIFT + W", exec("hyprctl activewindow | grep pid | tr -d 'pid:' | xargs kill"), "Quit active window and all open instances")
bind(M .. "F",         hl.dsp.window.fullscreen({ mode = "fullscreen" }), "Set active window to fullscreen")
bind(M .. "M",         hl.dsp.window.fullscreen({ mode = "maximized" }),  "Maximize Window")
bind(M .. "T",         hl.dsp.window.float({ action = "toggle" }),        "Toggle active windows into floating mode")

-- The old "workspaceopt allfloat" dispatcher no longer exists, so this toggles
-- floating on every window that is currently on the workspace.
bind(M .. "SHIFT + T", function()
    local ws = hl.get_active_workspace()
    if not ws then return end
    for _, w in ipairs(ws:get_windows()) do
        hl.dispatch(hl.dsp.window.float({ action = "toggle", window = w }))
    end
end, "Toggle all windows into floating mode")

bind(M .. "J",     hl.dsp.layout("togglesplit"),               "Toggle split")
bind(M .. "left",  hl.dsp.focus({ direction = "left" }),       "Move focus left")
bind(M .. "right", hl.dsp.focus({ direction = "right" }),      "Move focus right")
bind(M .. "up",    hl.dsp.focus({ direction = "up" }),         "Move focus up")
bind(M .. "down",  hl.dsp.focus({ direction = "down" }),       "Move focus down")
bind(M .. "mouse:272", hl.dsp.window.drag(),   "Move window with the mouse",   { mouse = true })
bind(M .. "mouse:273", hl.dsp.window.resize(), "Resize window with the mouse", { mouse = true })
bind(M .. "SHIFT + right", hl.dsp.window.resize({ x = 100,  y = 0,    relative = true }), "Increase window width with keyboard")
bind(M .. "SHIFT + left",  hl.dsp.window.resize({ x = -100, y = 0,    relative = true }), "Reduce window width with keyboard")
bind(M .. "SHIFT + down",  hl.dsp.window.resize({ x = 0,    y = 100,  relative = true }), "Increase window height with keyboard")
bind(M .. "SHIFT + up",    hl.dsp.window.resize({ x = 0,    y = -100, relative = true }), "Reduce window height with keyboard")
bind(M .. "G", hl.dsp.group.toggle(),       "Toggle window group")
bind(M .. "K", hl.dsp.layout("swapsplit"),  "Swapsplit")
bind(M .. "ALT + left",  hl.dsp.window.swap({ direction = "left" }),  "Swap tiled window left")
bind(M .. "ALT + right", hl.dsp.window.swap({ direction = "right" }), "Swap tiled window right")
bind(M .. "ALT + up",    hl.dsp.window.swap({ direction = "up" }),    "Swap tiled window up")
bind(M .. "ALT + down",  hl.dsp.window.swap({ direction = "down" }),  "Swap tiled window down")
bind("ALT + Tab", function()
    hl.dispatch(hl.dsp.window.cycle_next())
    hl.dispatch(hl.dsp.window.bring_to_top())
end, "Cycle between windows", { repeating = true })

-- Actions
bind(M .. "CTRL + W", exec("uwsm app -- waypaper"), "Wallpaper")
bind(M .. "CTRL + N", exec("hyprsunset-toggle"),    "Toggle night light")

-- Walker and Elephant
bind(M .. "R",         exec("walker"), "Launch application launcher")
bind(M .. "Escape",    exec("walker --theme menus -m menus:system --width 150 --minheight 1 --maxheight 600"), "System menu")
bind("Print",          exec("sh -c 'hyprshot -m region --clipboard-only'"), "Screenshot to clipboard")
bind(M .. "Print",     exec("walker --theme menus -m menus:screenshots --width 295 --minheight 1 --maxheight 600"), "Screenshot menu")
bind(M .. "V",         exec("walker -m clipboard"), "Clipboard history")
bind(M .. "ALT + SPACE", exec("walker --theme menus -m menus:menu --width 295 --minheight 1 --maxheight 900"), "Main menu")

-- Workspaces
for i = 1, 10 do
    local key = tostring(i % 10) -- workspace 10 is on the 0 key
    bind(M .. key,              hl.dsp.focus({ workspace = i }),        "Open workspace " .. i)
    bind(M .. "SHIFT + " .. key, hl.dsp.window.move({ workspace = i }), "Move active window to workspace " .. i)
end

bind(M .. "Tab",         hl.dsp.focus({ workspace = "m+1" }),   "Open next workspace")
bind(M .. "SHIFT + Tab", hl.dsp.focus({ workspace = "m-1" }),   "Open previous workspace")

bind(M .. "mouse_down",  hl.dsp.focus({ workspace = "e+1" }),   "Open next workspace")
bind(M .. "mouse_up",    hl.dsp.focus({ workspace = "e-1" }),   "Open previous workspace")
bind(M .. "CTRL + down", hl.dsp.focus({ workspace = "empty" }), "Open the next empty workspace")

-- Brightness
bind("XF86MonBrightnessUp",   exec("swayosd-client --brightness raise"), "Increase brightness", { repeating = true })
bind("XF86MonBrightnessDown", exec("swayosd-client --brightness lower"), "Decrease brightness", { repeating = true })

-- Volume
bind("XF86AudioRaiseVolume", exec("swayosd-client --output-volume +5"), "Volume up",   { repeating = true })
bind("XF86AudioLowerVolume", exec("swayosd-client --output-volume -5"), "Volume down", { repeating = true })
bind("XF86AudioMute",        exec("swayosd-client --output-volume mute-toggle"), "Toggle mute")

-- Media (requires playerctl)
bind("XF86AudioPlay",  exec("swayosd-client --playerctl play-pause"), "Play/pause media")
bind("XF86AudioPause", exec("swayosd-client --playerctl play-pause"), "Play/pause media")
bind("XF86AudioNext",  exec("swayosd-client --playerctl next"),       "Next track")
bind("XF86AudioPrev",  exec("swayosd-client --playerctl previous"),   "Previous track")

-- Lock
-- "XF86Lock" is not a key name xkbcommon knows, and 0.57 rejects unknown keys.
-- Lock from the system menu (SUPER + Escape) or let hypridle do it.
