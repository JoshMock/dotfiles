-- Hyprland Lua Configuration
-- Equivalent to your template config and all imported files

-- Environment variables
-- From env.conf
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

-- Input configuration
-- From input.conf
hl.config({
    input = {
        kb_layout = "us",
        kb_variant = "",
        kb_model = "",
        kb_options = "",
        kb_rules = "",
        follow_mouse = 1,
        touchpad = {
            natural_scroll = false,
            tap_to_click = false,
            clickfinger_behavior = true,
            disable_while_typing = false,
        },
    },
})

-- Theme configuration
-- From theme.conf
hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 12,
        float_gaps = -1,
        border_size = 1,
        col = {
            active_border = { colors = {"rgba(eeeeeeee)", "rgba(777777ee)"}, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },
        layout = "master",
        allow_tearing = false,
    },
})

hl.config({
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
})

hl.curve("wind", { type = "bezier", points = {{0.05, 0.9}, {0.1, 1.05}} })
hl.curve("winIn", { type = "bezier", points = {{0.1, 1.0}, {0.1, 1.0}} })
hl.curve("winOut", { type = "bezier", points = {{0.3, -0.3}, {0, 1}} })
hl.curve("liner", { type = "bezier", points = {{1, 1}, {1, 1}} })

hl.animation({ leaf = "windows",       enabled = true,  speed = 6,   bezier = "wind" })
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 6,   bezier = "winIn" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 5,   bezier = "winOut" })
hl.animation({ leaf = "windowsMove",   enabled = true,  speed = 5,   bezier = "wind" })
hl.animation({ leaf = "border",        enabled = true,  speed = 1,   bezier = "liner" })
hl.animation({ leaf = "borderangle",   enabled = true,  speed = 30,  bezier = "liner", style = "loop" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 10,  bezier = "default" })
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 5,   bezier = "wind" })

hl.config({
    dwindle = {
        pseudotile = true,
        preserve_split = true,
    },
})

hl.config({
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
    },
})

hl.config({
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

-- Keybinds configuration
-- From keybinds.conf
local terminal = "kitty"
local fileManager = "thunar"
local menu = "wofi --show drun"
local mainMod = "SUPER"

-- Bindings
hl.binds({
    workspace_back_and_forth = true,
})

hl.bind(mainMod .. " + return", hl.dsp.exec_cmd(terminal .. " --session ~/.config/kitty/default-session.conf"))
hl.bind(mainMod .. " + SHIFT + return", hl.dsp.exec_cmd(terminal .. " --session ~/.config/kitty/scratchpad-session.conf --class kitty-scratchpad"))
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("vicinae toggle"))
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("pypr menu"))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("vicinae deeplink vicinae://launch/clipboard/history"))

-- quit app
hl.bind(mainMod .. " + Q", hl.dsp.window.close())

-- exit hyprland
hl.bind(mainMod .. " + M", hl.dsp.exit())

-- workspace layout changes
hl.bind(mainMod .. " + V", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + P", hl.dsp.layout("pseudo"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + G", hl.dsp.window.group("togglegroup"))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + left", hl.dsp.window.group("changegroupactive", "b"))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + right", hl.dsp.window.group("changegroupactive", "f"))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- switch focus to previous window
hl.bind(mainMod .. " + tab", hl.dsp.focus({ current_or_last = true }))

-- Switch workspaces
hl.bind(mainMod .. " + 1", hl.dsp.focus({ workspace = 1 }))
hl.bind(mainMod .. " + 2", hl.dsp.focus({ workspace = 2 }))
hl.bind(mainMod .. " + 3", hl.dsp.focus({ workspace = 3 }))
hl.bind(mainMod .. " + 4", hl.dsp.focus({ workspace = 4 }))
hl.bind(mainMod .. " + 5", hl.dsp.focus({ workspace = 5 }))
hl.bind(mainMod .. " + 6", hl.dsp.focus({ workspace = 6 }))
hl.bind(mainMod .. " + 7", hl.dsp.focus({ workspace = 7 }))
hl.bind(mainMod .. " + 8", hl.dsp.focus({ workspace = 8 }))
hl.bind(mainMod .. " + 9", hl.dsp.focus({ workspace = 9 }))
hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = 10 }))

-- Move active window to a workspace
hl.bind(mainMod .. " + SHIFT + 1", hl.dsp.window.move({ workspace = 1 }))
hl.bind(mainMod .. " + SHIFT + 2", hl.dsp.window.move({ workspace = 2 }))
hl.bind(mainMod .. " + SHIFT + 3", hl.dsp.window.move({ workspace = 3 }))
hl.bind(mainMod .. " + SHIFT + 4", hl.dsp.window.move({ workspace = 4 }))
hl.bind(mainMod .. " + SHIFT + 5", hl.dsp.window.move({ workspace = 5 }))
hl.bind(mainMod .. " + SHIFT + 6", hl.dsp.window.move({ workspace = 6 }))
hl.bind(mainMod .. " + SHIFT + 7", hl.dsp.window.move({ workspace = 7 }))
hl.bind(mainMod .. " + SHIFT + 8", hl.dsp.window.move({ workspace = 8 }))
hl.bind(mainMod .. " + SHIFT + 9", hl.dsp.window.move({ workspace = 9 }))
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

-- Move active window into adjacent window group
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.group("movewindoworgroup", "r"))
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.group("movewindoworgroup", "l"))

-- Move current workspace to another monitor
hl.bind(mainMod .. " + SHIFT + comma", hl.dsp.workspace.move({ monitor = -1 }))
hl.bind(mainMod .. " + SHIFT + period", hl.dsp.workspace.move({ monitor = 1 }))

-- resize mode
hl.bind(mainMod .. " + R", hl.dsp.submap("resize"))
hl.submap("resize")
hl.binde("", "right", hl.dsp.window.resize({ x = 10, y = 0 }))
hl.binde("", "left", hl.dsp.window.resize({ x = -10, y = 0 }))
hl.binde("", "up", hl.dsp.window.resize({ x = 0, y = -10 }))
hl.binde("", "down", hl.dsp.window.resize({ x = 0, y = 10 }))
hl.bind("", "escape", hl.dsp.submap("reset"))
hl.submap("reset")

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
hl.bindl("", "switch:Lid Switch:off", hl.dsp.exec_cmd("~/.local/bin/hypr-clamshell close"))
hl.bindl("", "switch:Lid Switch:on", hl.dsp.exec_cmd("~/.local/bin/hypr-clamshell open"))

-- media controls
hl.bindel("", "XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"))
hl.bindel("", "XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"))
hl.bindl("", "XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bindl("", "XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bindl("", "XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bindl("", "XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bindl("", "XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))

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

-- Window rules
-- From application_defaults.conf
hl.window_rule({
    name = "firefox-work",
    match = { class = "firefox-developer-edition" },
    workspace = "1"
})

hl.window_rule({
    name = "kitty",
    match = { class = "kitty" },
    workspace = "2 silent"
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
    group = "set"
})

hl.window_rule({
    name = "firefox-personal",
    match = { class = "firefox-personal" },
    workspace = "4 silent"
})

hl.window_rule({
    name = "zoom",
    match = { tag = "zoom" },
    workspace = "5 silent",
    idle_inhibit = "focus",
    tag = "+media"
})

hl.window_rule({
    name = "zoom-float",
    match = { tag = "zoom" },
    match = { title = "menu window" },
    float = "on"
})

hl.window_rule({
    name = "zoom-float-button",
    match = { title = "annotate_toolbar" },
    match = { tag = "zoom" },
    float = "on"
})

hl.window_rule({
    name = "vlc",
    match = { class = "vlc" },
    workspace = "5 silent",
    tag = "+media"
})

hl.window_rule({
    name = "vlc-menu",
    match = { class = "^(vlc)$" },
    match = { float = "on" },
    no_blur = "on",
    no_dim = "on",
    opaque = "on"
})

hl.window_rule({
    name = "cava",
    match = { class = "cava" },
    workspace = "5 silent",
    float = "on",
    opacity = "0.3 0.3"
})

hl.window_rule({
    name = "mopidy",
    match = { class = "firefox-mopidy-iris" },
    workspace = "6 silent"
})

hl.window_rule({
    name = "obs",
    match = { class = "com.obsproject.Studio" },
    workspace = "7 silent"
})

hl.window_rule({
    name = "prompt",
    match = { tag = "prompt" },
    stay_focused = "on",
    float = "on",
    size = "<60% <60%"
})

hl.window_rule({
    name = "1password-prompt",
    match = { class = "1password" },
    match = { float = 1 },
    tag = "prompt",
    size = "400 400"
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
    match = { class = "^(zoom)$" },
    match = { float = "on" },
    no_blur = "on",
    no_dim = "on",
    opaque = "on",
    move = "onscreen"
})

hl.window_rule({
    name = "zoom-menus",
    match = { class = "^(zoom)$" },
    match = { title = "^(menu window|popup window|as_toolbar|cpt_frame_window)$" },
    no_blur = "on",
    no_dim = "on",
    opaque = "on",
    move = "onscreen"
})

hl.window_rule({
    name = "modal",
    match = { tag = "modal" },
    float = "on",
    size = "<60% <60%",
    center = "on"
})

hl.window_rule({ tag = "+modal", match = { class = "org.pulseaudio.pavucontrol" } })
hl.window_rule({ tag = "+modal", match = { class = "com.saivert.pwvucontrol" } })
hl.window_rule({ tag = "+modal", match = { class = "blueman-manager" } })

hl.window_rule({
    name = "menu",
    match = { tag = "menu" },
    no_blur = "on",
    no_dim = "on",
    opaque = "on"
})

hl.window_rule({
    name = "media",
    match = { tag = "media" },
    no_blur = "on",
    no_dim = "on",
    opaque = "on"
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
    match = { float = "on" },
    no_blur = "on",
    no_dim = "on",
    opaque = "on"
})

hl.window_rule({
    name = "fullscreen",
    match = { fullscreen = "on" },
    no_blur = "on",
    no_dim = "on",
    opaque = "on"
})

hl.window_rule({
    name = "pip",
    match = { title = "Picture-in-Picture" },
    no_blur = "on",
    no_dim = "on",
    opaque = "on",
    float = "on",
    pin = "on"
})

-- Startup applications
-- From startup.conf
hl.execOnce("hypridle")
hl.execOnce("pypr")
hl.execOnce("swaync")
hl.execOnce("vicinae server")
hl.execOnce("awww-daemon")
hl.exec("/home/joshmock/.local/bin/shuffle-wallpaper")
hl.execOnce("/usr/lib/polkit-kde-authentication-agent-1")
hl.execOnce("/usr/lib/pam_kwallet_init")
hl.execOnce("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
hl.exec("bluetoothctl connect DC:92:3B:B5:C0:9F") -- mouse
hl.exec("bluetoothctl connect 80:99:E7:54:A8:76") -- headphones
hl.execOnce("dex -a -s /etc/xdg/autostart/:~/.config/autostart/")

-- Ecosystem settings
-- From startup.conf
hl.config({
    ecosystem = {
        no_update_news = true,
        no_donation_nag = true,
        enforce_permissions = true,
    },
})

-- Permissions
-- From permissions.conf
hl.permission({
    path = "/usr/bin/hyprlock",
    permission = "screencopy",
    allow = true
})

hl.permission({
    path = "/usr/lib/xdg-desktop-portal-hyprland",
    permission = "screencopy",
    allow = true
})

-- Note: NVIDIA configuration is conditionally loaded in the original config
-- In a Lua config, you would need to implement the hardware detection
-- For now, we'll leave it out but note that this would be added conditionally in a full implementation