local HEIGHT_RATIO = 0.9
local WIDTH_RATIO = 0.9

local function on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set("n", "<Tab>", api.node.open.tab, opts("Open: New Tab"))

  -- local preview = require('nvim-tree-preview')
  -- vim.keymap.set('n', 'p', preview.watch, opts 'Preview (Watch)')
  -- vim.keymap.set('n', 'q', preview.unwatch, opts 'Close Preview/Unwatch')
  -- vim.keymap.set('n', '<C-d>', function() return preview.scroll(4) end, opts 'Scroll Down')
  -- vim.keymap.set('n', '<C-u>', function() return preview.scroll(-4) end, opts 'Scroll Up')

  -- don't open file twice
  local ok, api = pcall(require, "nvim-tree.api")
  assert(ok, "api module is not found")
  vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open: current tab"))
end

-- configure nvim-tree
return {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    init = function() 
      -- recommended settings from nvim-tree documentation
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      -- automatically open file after creation
      local api = require("nvim-tree.api")
      api.events.subscribe(api.events.Event.FileCreated, function(file)
        vim.cmd("edit " .. vim.fn.fnameescape(file.fname))
      end)

      -- change color for arrows in tree to light blue
      vim.cmd([[ highlight NvimTreeIndentMarker guifg=#3FC5FF ]])
    end,
    opts = {
      on_attach = on_attach,
	    view = {
        -- width = 40,
		    float = {
		        enable = true,
		        open_win_config = function()
		            local screen_w = vim.opt.columns:get()
		            local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
		            local window_w = screen_w * WIDTH_RATIO
		            local window_h = screen_h * HEIGHT_RATIO
		            local window_w_int = math.floor(window_w)
		            local window_h_int = math.floor(window_h)
		            local center_x = (screen_w - window_w) / 2
		            local center_y = ((vim.opt.lines:get() - window_h) / 2)
		            - vim.opt.cmdheight:get()
		            return {
		                border = "rounded",
		                relative = "editor",
		                row = center_y,
		                col = center_x,
		                width = window_w_int,
		                height = window_h_int,
		            }
		        end,
		    },
		    width = function()
		        return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
		    end,
	    },
	    -- change folder arrow icons
	    renderer = {
		    indent_markers = {
			    enable = true,
		    },
		    icons = {
			    glyphs = {
				    folder = {
					    -- arrow_closed = "", -- arrow when folder is closed
					    -- arrow_open = "", -- arrow when folder is open
				    },
			    },
		    },
	    },
	    -- disable window_picker for
	    -- explorer to work well with
	    -- window splits
	    actions = {
		    open_file = {
			    window_picker = {
				    enable = false,
			    },
		    },
	    },
	    filters = {
		    custom = { },
	    },
	    git = {
		    ignore = false,
	    },
	    -- update_focused_file = {
		   --  enable = true,
	    -- },
    live_filter = {
      always_show_folders = true,
    },
  }
}
