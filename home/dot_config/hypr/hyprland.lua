-- Environment variables
hl.env("XCURSOR_SIZE", "24")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("GDK_BACKEND", "wayland")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "2")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("WLR_NO_HARDWARE_CURSORS", "1")
hl.env("MOZ_DISABLE_RDD_SANDBOX", "1")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("MOZ_DBUS_REMOTE", "1")
hl.env("OZONE_PLATFORM", "wayland")
hl.env("GTK_THEME", "Adwaita:dark")
hl.env("GTK2_RC_FILES", "/usr/share/themes/Adwaita-dark/gtk-2.0/gtkrc")
hl.env("QT_STYLE_OVERRIDE", "Adwaita-Dark")
hl.env("PINENTRY_USER_DATA", "pinentry-qt")

hl.config({
  ecosystem = {
    no_update_news = true,
    no_donation_nag = true,
    enforce_permissions = true,
  },

  input = {
    touchpad = {
      natural_scroll = true,
      tap_to_click = false,
      clickfinger_behavior = true,
      disable_while_typing = false,
    },
  },

  general = {
    gaps_in = 5,
    gaps_out = 12,
    float_gaps = -1,
    border_size = 1,
    col = {
      active_border = { colors = { "rgba(eeeeeeee)", "rgba(777777ee)" }, angle = 45 },
      inactive_border = "rgba(595959aa)",
    },
    layout = "dwindle",
  },

  decoration = {
    rounding = 5,
    blur = {
      enabled = true,
      size = 6,
      passes = 1,
      xray = true,
    },
    active_opacity = 1.0,
    inactive_opacity = 0.6,
    fullscreen_opacity = 1.0,
    dim_inactive = true,
    dim_special = 0.6,
    shadow = {
      enabled = true,
      range = 15,
      render_power = 5,
      color = "0x66000000",
    },
  },

  misc = {
    force_default_wallpaper = 0,
    disable_hyprland_logo = true,
    disable_splash_rendering = true,
  },

  group = {
    groupbar = {
      height = 18,
      font_size = 12,
      priority = 5,
      text_color = "rgb(EEEEEE)",
      col = {
        active = "rgb(777777)",
        inactive = "rgb(343434)",
      },
      gradients = true,
    },
  },
})

hl.monitor({ output = "eDP-1", position = "2560x0", mode = "preferred", scale = 1, bitdepth = 10 })
hl.monitor({ output = "DP-2", disabled = true })
hl.monitor({ output = "DP-3", position = "0x0", mode = "2560x1440", scale = 1, bitdepth = 10 })
hl.monitor({ output = "DP-4", disabled = true })

hl.curve("wind", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })
hl.curve("winIn", { type = "bezier", points = { { 0.1, 1.0 }, { 0.1, 1.0 } } })
hl.curve("winOut", { type = "bezier", points = { { 0.3, -0.3 }, { 0, 1 } } })
hl.curve("liner", { type = "bezier", points = { { 1, 1 }, { 1, 1 } } })
hl.animation({ leaf = "windows", enabled = true, speed = 6, bezier = "wind" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 6, bezier = "winIn" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 5, bezier = "winOut" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 5, bezier = "wind" })
hl.animation({ leaf = "border", enabled = true, speed = 1, bezier = "liner" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 30, bezier = "liner", style = "loop" })
hl.animation({ leaf = "fade", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "wind" })

local mainMod = "SUPER"
-- hl.binds({
--   workspace_back_and_forth = true,
-- })

hl.bind(mainMod .. " + return", hl.dsp.exec_cmd("kitty --session ~/.config/kitty/default-session.conf"))
hl.bind(
  mainMod .. " + SHIFT + return",
  hl.dsp.exec_cmd("kitty --session ~/.config/kitty/scratchpad-session.conf --class kitty-scratchpad")
)
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("thunar"))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("vicinae toggle"))
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("pypr menu"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("kitten quick-access-terminal --detach"))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("vicinae deeplink vicinae://launch/clipboard/history"))

-- quit app
hl.bind(mainMod .. " + Q", hl.dsp.window.close())

-- exit hyprland
hl.bind(mainMod .. " + M", hl.dsp.exit())

-- workspace layout changes
hl.bind(mainMod .. " + V", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + P", hl.dsp.layout("pseudo"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + G", hl.dsp.group.toggle())

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + tab", hl.dsp.group.prev())
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- switch focus to previous window
hl.bind(mainMod .. " + tab", hl.dsp.focus({ last = true }))

for i = 0, 10 do
  local key = i % 10 -- 10 maps to key 0
  -- Switch workspaces
  hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
  -- Move active window to a workspace
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Move active window into adjacent window group
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ into_or_create_group = "r" }))
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.move({ into_or_create_group = "l" }))

-- Move current workspace to another monitor
hl.bind(mainMod .. " + SHIFT + comma", hl.dsp.workspace.move({ monitor = 1 }))
hl.bind(mainMod .. " + SHIFT + period", hl.dsp.workspace.move({ monitor = -1 }))

-- resize mode
hl.bind(mainMod .. " + R", hl.dsp.submap("resize"))
hl.define_submap("resize", function()
  -- Set repeating binds for resizing the active window.
  hl.bind("right", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
  hl.bind("left", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
  hl.bind("up", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })
  hl.bind("down", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })

  -- Use `reset` to go back to the global submap
  hl.bind("catchall", hl.dsp.submap("reset"))
end)

-- Scroll through existing workspaces
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- clear notifications
hl.bind("CTRL + SPACE", hl.dsp.exec_cmd("swaync-client --hide-latest"))
hl.bind("CTRL + SHIFT + SPACE", hl.dsp.exec_cmd("swaync-client --toggle-panel"))

-- bind to lid open/close events
local lid = "Lid Switch"
hl.bind("switch:off:" .. lid, hl.dsp.exec_cmd("~/.local/bin/hypr-clamshell close"))
hl.bind("switch:on:" .. lid, hl.dsp.exec_cmd("~/.local/bin/hypr-clamshell open"))

-- media controls
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })

-- tasks scratchpad
hl.bind(mainMod .. " + minus", hl.dsp.exec_cmd("pypr toggle tasks"))

-- ZSA Moonlander hyper/meh
local hyper = "CTRL + SHIFT + ALT + SUPER"
local meh = "CTRL + SHIFT + ALT"
hl.bind(meh .. " + 1", hl.dsp.exec_cmd("1password --quick-access"))
hl.bind(hyper .. " + m", hl.dsp.exec_cmd("add-to-mopidy"))
hl.bind(meh .. " + T", hl.dsp.exec_cmd("rofi-tidal"))
hl.bind(meh .. " + V", hl.dsp.exec_cmd("pypr toggle volume"))
hl.bind(meh .. " + R", hl.dsp.exec_cmd("pypr toggle system"))

hl.workspace_rule({ workspace = "1", monitor = "DP-3", default = true })
hl.workspace_rule({ workspace = "2", monitor = "DP-3" })
hl.workspace_rule({ workspace = "3", monitor = "DP-3" })
hl.workspace_rule({ workspace = "4", monitor = "DP-3" })
hl.workspace_rule({ workspace = "5", monitor = "DP-3" })
hl.workspace_rule({ workspace = "6", monitor = "eDP-1" })

hl.window_rule({
  name = "firefox-work",
  match = { class = "firefox-developer-edition" },
  workspace = "1",
})

hl.window_rule({
  name = "kitty",
  match = { class = "kitty" },
  workspace = "2 silent",
})

hl.window_rule({
  name = "kitty-btop",
  match = { class = "kitty-btop" },
  float = true,
})

hl.window_rule({
  name = "kitty-scratchpad",
  match = { class = "kitty-scratchpad" },
  float = true,
})

hl.window_rule({ tag = "+chat", match = { class = "^(Slack)$" } })
hl.window_rule({ tag = "+chat", match = { class = "^(slack)$" } })
hl.window_rule({ tag = "+chat", match = { class = "^(Element)$" } })
hl.window_rule({ tag = "+chat", match = { class = "^(discord)$" } })
hl.window_rule({ tag = "+chat", match = { title = "Discord" } })

hl.window_rule({
  name = "chat-apps",
  match = { tag = "chat" },
  workspace = "3 silent",
  group = "set",
})

hl.window_rule({
  name = "firefox-personal",
  match = { class = "firefox-personal" },
  workspace = "4 silent",
})

hl.window_rule({
  name = "zoom",
  match = { tag = "zoom" },
  workspace = "5 silent",
  idle_inhibit = "focus",
  tag = "+media",
})

hl.window_rule({
  name = "zoom-float",
  match = {
    title = "menu window",
    tag = "zoom",
  },
  float = true,
})

hl.window_rule({
  name = "zoom-float-button",
  match = {
    title = "annotate_toolbar",
    tag = "zoom",
  },
  float = true,
})

hl.window_rule({
  name = "vlc",
  match = { class = "vlc" },
  workspace = "5 silent",
  tag = "+media",
})

hl.window_rule({
  name = "vlc-menu",
  match = {
    class = "^(vlc)$",
    float = true,
  },
  no_blur = true,
  no_dim = true,
  opaque = true,
})

hl.window_rule({
  name = "cava",
  match = { class = "cava" },
  workspace = "5 silent",
  float = true,
  opacity = "0.3 0.3",
})

hl.window_rule({
  name = "mopidy",
  match = { class = "firefox-mopidy-iris" },
  workspace = "6 silent",
})

hl.window_rule({
  name = "obs",
  match = { class = "com.obsproject.Studio" },
  workspace = "7 silent",
})

hl.window_rule({
  name = "prompt",
  match = { tag = "prompt" },
  stay_focused = true,
  float = true,
  size = "<60% <60%",
})

hl.window_rule({
  name = "1password-prompt",
  match = { class = "1password", float = 1 },
  tag = "prompt",
  size = "400 400",
})

hl.window_rule({ tag = "+prompt", match = { class = ".*polkit.*" } })
hl.window_rule({ tag = "+prompt", match = { class = "Pinentry-gtk" } })
hl.window_rule({ tag = "+prompt", match = { class = "nm-applet" } })
hl.window_rule({ tag = "-prompt", match = { title = "as_toolbar" } })
hl.window_rule({ tag = "-prompt", match = { title = ".*Discord.*" } })

hl.window_rule({ tag = "+zoom", match = { class = "Zoom Workplace" } })
hl.window_rule({ tag = "+zoom", match = { class = ".*zoom.*" } })
hl.window_rule({ tag = "+zoom", match = { title = "zoom_linux_float_video_window" } })
hl.window_rule({ tag = "+zoom", match = { title = "cpt_frame_xcb_window" } })
hl.window_rule({ tag = "+zoom", match = { title = ".*app\\.zoom\\.us.*" } })

hl.window_rule({
  name = "zoom-popups",
  match = {
    class = "^(zoom)$",
    float = true,
  },
  no_blur = true,
  no_dim = true,
  opaque = true,
})

hl.window_rule({
  name = "zoom-menus",
  match = {
    class = "^(zoom)$",
    title = "^(menu window|popup window|as_toolbar|cpt_frame_window)$",
  },
  no_blur = true,
  no_dim = true,
  opaque = true,
  -- move = "onscreen",
})

hl.window_rule({
  name = "modal",
  match = { tag = "modal" },
  float = true,
  size = "<60% <60%",
  center = true,
})

hl.window_rule({ tag = "+modal", match = { class = "org.pulseaudio.pavucontrol" } })
hl.window_rule({ tag = "+modal", match = { class = "com.saivert.pwvucontrol" } })
hl.window_rule({ tag = "+modal", match = { class = "blueman-manager" } })

hl.window_rule({
  name = "menu",
  match = { tag = "menu" },
  no_blur = true,
  no_dim = true,
  opaque = true,
})

hl.window_rule({
  name = "media",
  match = { tag = "media" },
  no_blur = true,
  no_dim = true,
  opaque = true,
})

hl.window_rule({ tag = "+media", match = { title = ".*meeting.*" } })
hl.window_rule({ tag = "+media", match = { title = ".*playing.*", class = ".*firefox.*" } })
hl.window_rule({ tag = "+media", match = { title = ".*YouTube.*" } })
hl.window_rule({ tag = "+media", match = { title = ".*All Hands.*" } })
hl.window_rule({ tag = "+media", match = { title = ".*Devtools.*" } })
hl.window_rule({ tag = "+media", match = { content = 2 } })
hl.window_rule({ tag = "-media", match = { title = "^(zoom_linux_float_video_window)$" } })
hl.window_rule({ tag = "-media", match = { title = "^(as_toolbar)$" } })

hl.window_rule({
  name = "floating",
  match = { float = true },
  no_blur = true,
  no_dim = true,
  opaque = true,
})

hl.window_rule({
  name = "scratchpad",
  match = { workspace = "special:*" },
  border_color = { colors = { "rgba(eeeeeeee)", "rgba(777777ee)" }, angle = 45 },
  border_size = 3,
})

hl.window_rule({
  name = "fullscreen",
  match = { fullscreen = true },
  no_blur = true,
  no_dim = true,
  opaque = true,
})

hl.window_rule({
  name = "pip",
  match = { title = "Picture-in-Picture" },
  no_blur = true,
  no_dim = true,
  opaque = true,
  float = true,
  pin = true,
})

-- Startup applications
hl.on("hyprland.start", function()
  hl.exec_cmd("hypridle")
  hl.exec_cmd("nm-applet")
  hl.exec_cmd("pypr")
  hl.exec_cmd("swaync")
  hl.exec_cmd("vicinae server")
  hl.exec_cmd("awww-daemon")
  hl.exec_cmd("/home/joshmock/.local/bin/shuffle-wallpaper")
  hl.exec_cmd("dbus-update-activation-environment --systemd --all")
  hl.exec_cmd("dex -a -s /etc/xdg/autostart/:~/.config/autostart/")
  hl.exec_cmd("~/.local/bin/hypr-monitor-event")
end)

-- Update bar monitor on plug/unplug events
hl.on("monitor.added", function()
  hl.exec_cmd("~/.local/bin/hypr-monitor-event")
end)
hl.on("monitor.removed", function()
  hl.exec_cmd("~/.local/bin/hypr-monitor-event")
end)

-- screencopy permissions: apps that need to screencap
local screencopiers = {
  "/bin/hyprlock",
  "/usr/bin/hyprlock",
  "/usr/lib/xdg-desktop-portal-hyprland",
  "/bin/grim",
  "/usr/bin/grim",
}
for _, value in ipairs(screencopiers) do
  hl.permission({
    binary = value,
    type = "screencopy",
    mode = "allow",
  })
end

hl.window_rule({
  -- Ignore maximize requests from all apps
  name = "suppress-maximize-events",
  match = { class = ".*" },

  suppress_event = "maximize",
})

hl.window_rule({
  -- Fix some dragging issues with XWayland
  name = "fix-xwayland-drags",
  match = {
    class = "^$",
    title = "^$",
    xwayland = true,
    float = true,
    fullscreen = false,
    pin = false,
  },

  no_focus = true,
})
