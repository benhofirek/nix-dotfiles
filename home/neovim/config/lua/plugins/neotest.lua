return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'Issafalcon/neotest-dotnet',
    'thenbe/neotest-playwright',
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    require('neotest').setup {
      icons = {
        expanded = '',
        child_prefix = '',
        child_indent = '',
        final_child_prefix = '',
        non_collapsible = '',
        collapsed = '',
        passed = '',
        running = '',
        failed = '',
        unknown = '',
      },
     summary = {
      animated = true,
      count = true,
      enabled = true,
      expand_errors = true,
      follow = true,
      mappings = {
        attach = "a",
        clear_marked = "M",
        clear_target = "T",
        debug = "d",
        debug_marked = "D",
        expand = { "<CR>", "<2-LeftMouse>", "o" },
        expand_all = "e",
        help = "?",
        jumpto = "i",
        mark = "m",
        next_failed = "J",
        output = "w",
        prev_failed = "K",
        run = "r",
        run_marked = "R",
        stop = "u",
        target = "t",
        -- watch = "w"
      },
      open = "botright vsplit | vertical resize 50"
    },
      adapters = {
        require 'neotest-dotnet',
        require('neotest-playwright').adapter {
          options = {
            persist_project_selection = true,
            enable_dynamic_test_discovery = true,
            preset = "headed",
            experimental = {
              telescope = {
                -- If true, a telescope picker will be used for `:NeotestPlaywrightProject`.
                -- Otherwise, `vim.ui.select` is used.
                -- In normal mode, `<Tab>` toggles the project under the cursor.
                -- `<CR>` (enter key) applies the selection.
                enabled = true,
                opts = {},
              },
            },
          },
        },
      },
      consumers = {
        playwright = require('neotest-playwright.consumers').consumers,
      },
    }
  end,
}
