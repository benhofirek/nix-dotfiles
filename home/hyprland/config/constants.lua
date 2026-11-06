local M = {
    -- Free: C, W, X, Y
    command_mod = "SUPER + ALT + CTRL",
}

local function get_hostname()
    local f = io.popen("hostname")
    if f then
        local hostname = f:read("*l")
        f:close()
        if hostname then
            return hostname:gsub("%s+", "")
        end
    end
    return "unknown"
end

local displays = {
  ["laptop"] = {
    -- Built-in screen (right)
    [1] = {
        output = "eDP-1",
        mod = "CTRL",
        mode = "2560x1600@60",
        position = "4000x400",
        scale = 1.333333,
    },
    [2] = {
      -- Huawei (center)
        output = "HDMI-A-3",
        mod = "ALT",
        bus = 16,
        mode = "3840x2560@49.98",
        position = "1600x0",
        scale = 1.6,
    },
    -- Asus portable (left)
    [3] = {
        output = "DP-3",
        mod = "SUPER",
        bus = 15,
        mode = "2560x1600@60",
        position = "0x600",
        scale = 1.6,
    },

    -- [3] = {
    --     output = "DP-3",
    --     mod = "SUPER",
    --     bus = 15,
    --     mode = "2200x1650@38",
    --     position = "0x600",
    --     scale = 1.47,
    -- }
  }
}

local current_host = get_hostname()
M.displays = displays[current_host] or {}

return M

