--> Windowing / Workspace

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule

for i = 1, 5 do
    hl.workspace_rule({ workspace = tostring(i), persistent = true })
end

hl.window_rule({
    name = "Luna",
    match = { title = "Luna Engine"},

    float = true
})

hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})

hl.window_rule({
    name  = "Zen",
    match = { class = "app.zen_browser.zen" },
    workspace = "2 silent"
})

hl.window_rule({
    name  = "Sober",
    match = { class = "org.vinegarhq.Sober" },
    workspace = "3 silent",
    opacity = 1
})

hl.window_rule({
    name  = "blender",
    match = { class = "blender" },
    workspace = "3 silent",
    size = { 800, 600 },
    opacity = 1
})

hl.window_rule({
    name  = "Minecraft",
    match = { class = "Minecraft*" },
    workspace = "3 silent",
    opacity = 1
})

hl.window_rule({
    name  = "Discord",
    match = { class = "vesktop" },
    workspace = "4 silent"
})

hl.window_rule({
    name  = "Spotify",
    match = { class = "spotify" },
    workspace = "5 silent"
})
