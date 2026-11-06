local constants = require("constants")

-- Bind workspaces to their respective monitors.
for display_number, display in pairs(constants.displays) do
    hl.monitor({
        output = display.output,
        mode = display.mode,
        position = display.position,
        scale = display.scale,
    })

    for i = 0, 9 do
        hl.workspace_rule({
            default = i == 0,
            workspace = tostring(i + display_number * 10),
            monitor = display.output,
        })
    end
end

-- Workspace switching:
-- Display 1: CTRL + 0..9 -> workspaces 10..19
-- Display 2: ALT  + 0..9 -> workspaces 20..29
-- Display 3: SUPER + 0..9 -> workspaces 30..39
--
-- These bindings are defined in keybinds.lua.

