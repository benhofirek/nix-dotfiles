local constants = require("constants")

local command_mod = constants.command_mod
local displays = constants.displays

-- Helpers

local function bind(key, action, flags)
    hl.bind(key, action, flags)
end

local function bind_command(key, action, flags)
    bind(command_mod .. " + " .. key, action, flags)
end

local function exec(cmd)
    return hl.dsp.exec_cmd(cmd)
end

local function focus_direction(direction)
    return hl.dsp.focus({ direction = direction })
end

local function repeat_bind(key, action)
    bind(key, action, {
        repeating = true,
        locked = true,
    })
end

local function repeat_command(key, action)
    bind_command(key, action, {
        repeating = true,
        locked = true,
    })
end

local function ddc_brightness_up(bus)
    return exec(
        "ddcutil --bus " .. bus .. " setvcp 10 + 1"
    )
end

local function ddc_brightness_down(bus)
    return exec(
        "ddcutil --bus " .. bus .. " setvcp 10 - 1"
    )
end

-- Application launchers

bind_command("0", exec("fuzzel"))
bind_command("2", exec("kitty"))
bind_command("3", exec("google-chrome"))
bind_command("4", exec("kitty -e superfile"))
bind_command("R", exec("slack"))
bind_command("S", exec("firefox"))
bind_command("T", exec("beekeeper-studio"))
bind_command("U", exec("podman-desktop"))

-- Windows and focus

bind_command("1", hl.dsp.window.close())
bind_command("5", focus_direction("l"))
bind_command("6", focus_direction("r"))
bind_command("7", focus_direction("u"))
bind_command("8", focus_direction("d"))

-- NightShift

bind_command(
    "9",
    exec(
        "busctl --user -- call rs.wl-gammarelay / " ..
        "rs.wl.gammarelay UpdateTemperature n -100"
    )
)

bind_command(
    "A",
    exec(
        "busctl --user -- call rs.wl-gammarelay / " ..
        "rs.wl.gammarelay UpdateTemperature n +100"
    )
)

-- Scripts
local info = debug.getinfo(1, "S").source:sub(2)  -- path of this file
local dir  = info:match("(.*/)") or "./"
local scripts = dir .. "scripts"

bind_command("B", exec(scripts .. "/display-toggle.sh"))
bind_command("V", exec("systemctl suspend"))
bind_command("N", exec("systemctl reboot"))

-- Utilities

bind_command("D", exec("hyprshot -m region"))
bind_command("E", exec("playerctl play-pause"))
bind_command("Q", exec(scripts .. "/bluetooth-toggle.sh"))
bind_command("Z", exec(scripts .. "/wifi-toggle.py"))

-- Volume

repeat_bind(
    "XF86AudioRaiseVolume",
    exec("wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+")
)

repeat_bind(
    "XF86AudioLowerVolume",
    exec("wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-")
)

-- Laptop brightness

repeat_bind(
    "XF86MonBrightnessUp",
    exec(scripts .. "/brightness.sh up")
)

repeat_bind(
    "XF86MonBrightnessDown",
    exec(scripts .. "/brightness.sh down")
)

-- External monitor brightness

local function setup_ddc_brightness(display_number, up_key, down_key)
    local bus = displays[display_number].bus

    repeat_command(up_key, ddc_brightness_up(bus))
    repeat_command(down_key, ddc_brightness_down(bus))
end

setup_ddc_brightness(2, "G", "F")
setup_ddc_brightness(3, "I", "H")
-- setup_ddc_brightness(4, "P", "O")


-- Workspace switching and window movement

-- Move focus to monitor
hl.bind(command_mod .. " + " .. "J", hl.dsp.focus({ monitor = displays[1].output }))
hl.bind(command_mod .. " + " .. "K", hl.dsp.focus({ monitor = displays[2].output }))
hl.bind(command_mod .. " + " .. "L", hl.dsp.focus({ monitor = displays[3].output }))

local function workspace_for_key(display_number, key)
    return display_number * 10 + key
end

for display_number, display in ipairs(displays) do

    for key = 0, 9 do
        local target = workspace_for_key(display_number, key)
        local key_string = tostring(key)

        -- Switch workspace
        hl.bind(
            display.mod .. " + " .. key_string,
            hl.dsp.focus({ workspace = target })
        )

        -- Move active window to workspace
        hl.bind(
            display.mod .. " + SHIFT + " .. key_string,
            hl.dsp.window.move({ workspace = target })
        )
    end
end
