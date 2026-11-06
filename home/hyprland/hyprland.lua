-- Get the directory where the config is located (./config)
local current_dir = debug.getinfo(1, "S").source:match("@(.*/)")
if current_dir then
    package.path = current_dir .. "config/?.lua;" .. package.path
end

require("constants")
require("settings")
require("monitors")
require("keybindings")
require("autostart")
