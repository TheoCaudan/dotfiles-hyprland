-- MPV
hl.window_rule({ match = { class = "mpv" }, opacity = "1.0", float = true, size = { 1299, 701 }, center = true })

-- Waybar
hl.window_rule({ match = { class = "waybar" }, float = true, tile = true, border_size = 0, rounding = 0, no_shadow = true, stay_focused = true, opacity = "1", no_focus = true })

-- Wofi
hl.window_rule({ match = { class = "wofi" }, rounding = 0, no_shadow = true, center = true, no_max_size = true, float = true })

-- Departure
hl.window_rule({ match = { class = "departure" }, no_shadow = true })

-- Dota 2
hl.window_rule({ match = { title = "Dota 2" }, float = true, fullscreen = true, border_size = 0, workspace = "4 silent" })

-- Ratchet & Clank
hl.window_rule({ match = { title = "Ratchet & Clank: Rift Apart" }, float = true, fullscreen = true, border_size = 0, workspace = "4 silent" })

-- Thunar
hl.window_rule({ match = { class = "Thunar" }, float = true, size = { 1000, 650 }, center = true })
