--> Looks & Feel

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    general = {
        gaps_in  = 0,
        gaps_out = 0,

        border_size = 1,

        col = {
            active_border   = { colors = {"rgba(cdd6f4ee)"} },
            inactive_border = { colors = {"rgba(3a3a40aa)"} },
        },

        -- col = {
        --     active_border   = { colors = {"rgba(78a099ee)", "rgba(ccffffa0)"}, angle = 45 },
        --     inactive_border = { colors = {"rgba(12320aaa)", "rgba(242424ff)"}, angle = 45 },
        -- },

        -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,

        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        allow_tearing = false,

        layout = "dwindle",
    },

    decoration = {
        rounding       = 0,
        rounding_power = 0,

        -- Change transparency of focused and unfocused windows
        active_opacity   = 0.90,
        inactive_opacity = 0.80,

        blur = {
            enabled   = true,
            size      = 3,
            passes    = 2,
            vibrancy  = 0.1696,
        },
    },

    animations = {
        enabled = false,
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
    dwindle = {
        preserve_split = true, -- You probably want this
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
    master = {
        new_status = "master",
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config({
    scrolling = {
        fullscreen_on_one_column = true,
    },
})


-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })

-- Default springs
hl.curve("easy",           { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

hl.animation({ leaf = "global",        enabled = true,  speed = 0.5, bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 2, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true,  speed = 2, spring = "easy" })
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 2, spring = "easy",         style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 2, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 2, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 2, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 2, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true,  speed = 2, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 2, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 2, bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 2, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 2, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 2, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 2, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 2, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 2, bezier = "quick" })
