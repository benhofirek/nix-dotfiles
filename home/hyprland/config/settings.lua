-- Environment variables
hl.env("HYPRCURSOR_THEME", "rose-pine-hyprcursor")
hl.env("HYPRCURSOR_SIZE", "24")

-- Global Hyprland configuration
hl.config({
    animations = {
        enabled = false,
    },

    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
    },

    general = {
        border_size = 0,
        gaps_in = 0,
        gaps_out = 0,
        layout = "dwindle",
    },

    dwindle = {
        force_split = 0,
        preserve_split = true,
        smart_split = false,
        smart_resizing = true,
        permanent_direction_override = false,
        special_scale_factor = 1.0,
        split_width_multiplier = 1.0,
        use_active_for_splits = true,
        default_split_ratio = 1.0,
        split_bias = 0,
        precise_mouse_move = false,
    },

    cursor = {
        enable_hyprcursor = true,
        no_hardware_cursors = 1,
    },

    input = {
      repeat_rate  = 60,
      repeat_delay = 250,
      sensitivity  = -0.35,
      accel_profile = "adaptive",
    },

    decoration = {
        rounding = 0,

        blur = {
            enabled = false,
        },

        shadow = {
            enabled = false,
        },

        active_opacity = 1.0,
        inactive_opacity = 1.0,
    },
})


hl.window_rule({
  float = true,
  match = {
      class = "^org%.kde%.dolphin$",
  },
})
