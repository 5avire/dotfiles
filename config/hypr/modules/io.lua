--> Monitors

hl.monitor({
    output   = "",
    mode     = "1920x1080@60",
    position = "auto",
    scale    = "1",
})

--> Inputs

hl.config({
    input = {
        kb_layout  = "us",
        kb_variant = "",
        kb_model   = "",
        kb_options = "caps:escape",
        kb_rules   = "",

        follow_mouse = 1,

        repeat_rate = 35,
        repeat_delay = 200,

        sensitivity = 0,

        touchpad = {
            natural_scroll = false,
        },
    },
})

-- hl.device({
--     name        = "epic-mouse-v1",
--     sensitivity = 0,
-- })

--> Input Remaps

-- Alt + hjkl for arrow keys
-- hl.bind("ALT + H", hl.dsp.send_shortcut({ mods = "", key = "left" }))
-- hl.bind("ALT + J", hl.dsp.send_shortcut({ mods = "", key = "down" }))
-- hl.bind("ALT + K", hl.dsp.send_shortcut({ mods = "", key = "up" }))
-- hl.bind("ALT + L", hl.dsp.send_shortcut({ mods = "", key = "right" }))
--
-- -- Shift + Alt + hjkl to send Shift + Arrow keys (for selection, etc.)
-- hl.bind("ALT + SHIFT + H", hl.dsp.send_shortcut({ mods = "SHIFT", key = "left" }))
-- hl.bind("ALT + SHIFT + J", hl.dsp.send_shortcut({ mods = "SHIFT", key = "down" }))
-- hl.bind("ALT + SHIFT + K", hl.dsp.send_shortcut({ mods = "SHIFT", key = "up" }))
-- hl.bind("ALT + SHIFT + L", hl.dsp.send_shortcut({ mods = "SHIFT", key = "right" }))
