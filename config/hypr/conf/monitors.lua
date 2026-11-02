hl.env("GDK_SCALE", "1")

hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@75", position = "0x0",    scale = "auto" })
hl.monitor({ output = "DP-3",     mode = "1366x768@59",  position = "0x-768", scale = 1 })

hl.workspace_rule({ workspace = "1", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "2", monitor = "DP-3" })
hl.workspace_rule({ workspace = "3", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "4", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "5", monitor = "HDMI-A-1" })
