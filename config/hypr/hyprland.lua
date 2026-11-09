require("themes.dark_hypr")

require("configs.keybinds")
require("configs.exec")
require("configs.window_rules")
require("configs.monitors")
require("configs.theme")

-- Environment variables
hl.env("EDITOR", "nvim")
hl.env("XCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "ComixCursors-White")
hl.env("GTK_THEME", "Adwaita-dark")
hl.env("ICON_THEME", "Adwaita")
hl.env("GTK_APPLICATION_PREFER_DARK_THEME", "1")
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("WLR_NO_HARDWARE_CURSORS", "1")


hl.config({
  input = {
    kb_layout = "fr",
    kb_variant = "latin9",
    kb_model = "",
    kb_options = "",
    numlock_by_default = true,
    follow_mouse = 1,
    touchpad = {
      natural_scroll = false,
    },
    sensitivity = 0,
  },
  general = {
    gaps_in = 0,
    gaps_out = 0,
    border_size = 1,
    col = {
      active_border = {
        colors = {
          "rgba(" .. color_accent1 .. ")",
          "rgba(" .. color_accent2 .. ")"
        },
        angle = 45
      },
      inactive_border = "rgba(" ..color_accent2 .. ")",
    },
    resize_on_border = false,
    allow_tearing = true,
    layout = "dwindle",
  },
  misc = {
    force_default_wallpaper = 0,
    disable_hyprland_logo = true,
    disable_splash_rendering = true,
    always_follow_on_dnd = true,
  },
  decoration = {
    rounding = 0,
    active_opacity = 0.93,
    inactive_opacity = 0.7,
    blur = {
      enabled = true,
      size = 3,
      passes = 1,
    },
    shadow = {
      enabled = false,
      range = 4,
      render_power = 3,
      color = "rgba(" .. color_shadow .. ")",
    },
  },
  animations = {
    enabled = true,
    bezier = { "overshot, 0.13, 0.99, 0.29, 1.1" },
    animation = {
      "windows, 1, 4, overshot, slide",
      "border, 1, 10, default",
      "fade, 1, 3, default",
      "workspaces, 1, 6, overshot, slidevert",
    },
  },
  dwindle = {
    preserve_split = true,
  },
  master = {},
  gestures = {},
  plugin = {},
})

hl.workspace_rule({ workspace = "1", monitor = "eDP-1", default = true })
hl.workspace_rule({ workspace = "2", monitor = "eDP-1", persistent = true })
hl.workspace_rule({ workspace = "3", monitor = "eDP-1", persistent = true })
hl.workspace_rule({ workspace = "4", monitor = "eDP-1", persistent = true })
hl.workspace_rule({ workspace = "5", monitor = "eDP-1", persistent = true })
hl.workspace_rule({ workspace = "6", monitor = "HDMI-A-1", persistent = true })
