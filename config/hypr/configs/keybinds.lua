local mainMod = "SUPER"

-- Terminal
hl.bind("CTRL + ALT + T", hl.dsp.exec_cmd("foot -e ~/.config/hypr/scripts/tmux_session.sh"))

-- Close active window
hl.bind("ALT + F4", hl.dsp.window.close())

-- Lock screen
hl.bind("SUPER + L", hl.dsp.exec_cmd("hyprlock"))

-- Task manager
hl.bind("CTRL + SHIFT + Escape", hl.dsp.exec_cmd("footclient pulsar"))

-- File manager
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("Thunar"))

-- Screenshot
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd('grim -g "$(slurp)" $HOME/Data/Pictures/screenshots/$(date +\'%Y-%m-%d_%H-%M-%S_selection.png\')'))

-- Navigation & Window states
hl.bind("ALT + Tab", hl.dsp.focus({ direction = "right" }))
hl.bind("ALT + Escape", hl.dsp.exec_cmd("~/.config/hypr/scripts/next.sh"))
hl.bind("ALT + SHIFT + Escape", hl.dsp.exec_cmd("~/.config/hypr/scripts/prev.sh"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + SPACE", hl.dsp.window.float({ action = "toggle" }))

-- Wofi & Utilities
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("wofi-blu"))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("wofi-wifi"))
hl.bind(mainMod .. " + X", hl.dsp.exec_cmd("departure"))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("sxiv -t -b $HOME/Data/Pictures"))
hl.bind(mainMod .. " + H", hl.dsp.exec_cmd("cliphist list | wofi --dmenu | cliphist decode | wl-copy"))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("wallpaper-select"))

-- Music controls (mocp)
hl.bind(mainMod .. " + Left", hl.dsp.exec_cmd("mocp -M .config/moc -r"))
hl.bind(mainMod .. " + Right", hl.dsp.exec_cmd("mocp -M .config/moc -f"))
hl.bind(mainMod .. " + Up", hl.dsp.exec_cmd("mocp -M .config/moc -G"))

-- Launcher
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("wofi --show drun --allow-empty"))

-- Groups
hl.bind(mainMod .. " + SHIFT + G", hl.dsp.group.toggle())

-- Workspaces mapping (French layout symbols)
local ws_keys = {
    ["ampersand"] = 1,
    ["eacute"] = 2,
    ["quotedbl"] = 3,
    ["apostrophe"] = 4,
    ["parenleft"] = 5,
    ["agrave"] = 6,
    ["p"] = 6,
}

for key, ws in pairs(ws_keys) do
    hl.bind("SUPER + " .. key, hl.dsp.focus({ workspace = ws }))
    hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = ws }))
end

hl.bind("SUPER + SHIFT + Right", hl.dsp.window.move({ workspace = "r+1" }))
hl.bind("SUPER + SHIFT + Left", hl.dsp.window.move({ workspace = "r-1" }))
hl.bind("SUPER + Right", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + Left", hl.dsp.focus({ workspace = "e-1" }))

hl.bind("SUPER + A", hl.dsp.workspace.toggle_special(""))
hl.bind("SUPER + SHIFT + A", hl.dsp.window.move({ workspace = "special" }))

-- Mouse binds
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag())
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize())

-- Volume
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-; VOL=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}'); notify-send -h string:x-dunst-stack-tag:audio -h int:value:\"$VOL\" \"Volume: ${VOL}%\""), { repeating = true })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+; VOL=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}'); notify-send -h string:x-dunst-stack-tag:audio -h int:value:\"$VOL\" \"Volume: ${VOL}%\""), { repeating = true })

-- Brightness
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set +10% && notify-send -h string:x-dunst-stack-tag:light -h int:value:\"$(brightnessctl i | grep -oP '\\K[^%]+')\" \"Luminosité : $(brightnessctl i | grep -oP '\\K[^%]+')%\""), { repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 10%- && notify-send -h string:x-dunst-stack-tag:light -h int:value:\"$(brightnessctl i | grep -oP '\\K[^%]+')\" \"Luminosité : $(brightnessctl i | grep -oP '\\K[^%]+')%\""), { repeating = true })

-- Mute
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle; if wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q 'MUTED'; then notify-send -h string:x-dunst-stack-tag:audio '🔇 Volume : Muted'; else notify-send -h string:x-dunst-stack-tag:audio '🔉 Volume : Activated'; fi"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle; if wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -q 'MUTED'; then notify-send -h string:x-dunst-stack-tag:mic '  Mic : Cut'; else notify-send -h string:x-dunst-stack-tag:mic '  Mic : Activated'; fi"), { locked = true })

-- Media Controls
hl.bind("Home", hl.dsp.exec_cmd("~/.config/hypr/scripts/start_or_toggle_spotube.sh"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
