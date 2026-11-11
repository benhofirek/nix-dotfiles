return {
  {
    'Mofiqul/vscode.nvim',
    name = 'vscode',
    priority = 1000,
    config = function()
      require('vscode').load()
    end,
  },
  {
    'navarasu/onedark.nvim',
    name = 'onedark',
    priority = 1000,
    config = function()
      require('onedark').setup {
        style = 'light', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
      }
    end,
  },
  -- {
  --     'cranberry-clockworks/coal.nvim',
  --     config = function()
  --         require('coal').setup()
  --     end
  -- },
  -- {
  --     "neanias/everforest-nvim",
  --     priority = 1000,
  --     config = function()
  --         require("everforest").setup {
  --             background = "hard"
  --         }
  --     end,
  --     init = function()
  --         vim.cmd("colorscheme everforest")
  --     end
  -- },
  --  {
  --   'sainnhe/sonokai',
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     -- Optionally configure and load the colorscheme
  --     -- directly inside the plugin declaration.
  --     vim.g.sonokai_enable_italic = true
  --     vim.g.sonokai_style = 'maia'
  --     vim.cmd.colorscheme('sonokai')
  --   end
  -- },
  -- {
  --   'savq/melange-nvim',
  --   lazy = false,
  --   priority = 1000,
  --   opts = {
  --
  --   },
  --   config = function()
  --     vim.cmd.colorscheme('melange')
  --   end
  -- },
  -- {
  --   'sainnhe/gruvbox-material',
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     -- Optionally configure and load the colorscheme
  --     -- directly inside the plugin declaration.
  --     vim.g.gruvbox_material_enable_italic = true
  --     vim.g.gruvbox_material_background = 'medium'
  --     vim.g.gruvbox_material_foreground = 'material'
  --     vim.cmd.colorscheme('gruvbox-material')
  --   end
  -- },
  {
    'NTBBloodbath/doom-one.nvim',
    priority = 1000,
    setup = function()
      -- Add color to cursor
      vim.g.doom_one_cursor_coloring = false
      -- Set :terminal colors
      vim.g.doom_one_terminal_colors = true
      -- Enable italic comments
      vim.g.doom_one_italic_comments = false
      -- Enable TS support
      vim.g.doom_one_enable_treesitter = true
      -- Color whole diagnostic text or only underline
      vim.g.doom_one_diagnostics_text_color = false
      -- Enable transparent background
      vim.g.doom_one_transparent_background = false

      -- Pumblend transparency
      vim.g.doom_one_pumblend_enable = false
      vim.g.doom_one_pumblend_transparency = 20

      -- Plugins integration
      vim.g.doom_one_plugin_neorg = true
      vim.g.doom_one_plugin_barbar = false
      vim.g.doom_one_plugin_telescope = false
      vim.g.doom_one_plugin_neogit = true
      vim.g.doom_one_plugin_nvim_tree = true
      vim.g.doom_one_plugin_dashboard = true
      vim.g.doom_one_plugin_startify = true
      vim.g.doom_one_plugin_whichkey = true
      vim.g.doom_one_plugin_indent_blankline = true
      vim.g.doom_one_plugin_vim_illuminate = true
      vim.g.doom_one_plugin_lspsaga = false
    end,
  },
  {
    'zaldih/themery.nvim',
    lazy = false,
    config = function()
      require('themery').setup {
        themes = {
          {
            name = 'Doom one',
            colorscheme = 'doom-one',
            before = [[ vim.opt.background = "dark" ]],
          },
          {
            name = 'One light',
            colorscheme = 'onedark',
            before = [[ vim.opt.background = "light" ]],
          },
        },
      }
    end,
  },
  -- auto restore session
  {
    'rmagatti/auto-session',
    lazy = false,

    opts = {
      suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
      session_lens = {
        mappings = {},
      },
    },
  },
  -- Nice code screenshot
  {
    'mistricky/codesnap.nvim',
    build = 'make',
    opts = {
      has_line_number = true,
      bg_padding = 0,
      has_breadcrumbs = true,
      watermark = 'Ben Hofirek',
    },
  },

  -- Html tags support
  -- {
  --   'windwp/nvim-ts-autotag',
  --   config = function()
  --     require('nvim-ts-autotag').setup {
  --       opts = {
  --         -- Defaults
  --         enable_close = true, -- Auto close tags
  --         enable_rename = true, -- Auto rename pairs of tags
  --         enable_close_on_slash = true, -- Auto close on trailing </
  --       },
  --     }
  --   end,
  -- },

  -- Lorem Ipsum
  {
    'derektata/lorem.nvim',
    config = function()
      require('lorem').opts {
        sentenceLength = 'medium',
        comma_chance = 0.2,
        max_commas_per_sentence = 2,
      }
    end,
  },

  -- Cmp
  { 'hrsh7th/cmp-buffer' }, -- buffer completions
  { 'hrsh7th/cmp-path' }, -- path completions
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-cmdline' },
  { 'hrsh7th/cmp-nvim-lua' },

  -- Snippets
  {
    'L3MON4D3/LuaSnip',
    dependencies = {
      'rafamadriz/friendly-snippets',
      'robole/vscode-markdown-snippets',
      'J0rgeSerran0/vscode-csharp-snippets',
      'fivethree-team/vscode-svelte-snippets',
      -- 'xabikos/vscode-react',
      -- "mlaursen/vim-react-snippets",
      'thomanq/math-snippets',
    },
    opts = function()
      require('luasnip.loaders.from_vscode').lazy_load()
    end,
  }, --snippet engine
  { 'saadparwaiz1/cmp_luasnip' }, -- snippet completions

  -- LSP
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {
        'SmiteshP/nvim-navbuddy',
        dependencies = {
          'SmiteshP/nvim-navic',
          'MunifTanjim/nui.nvim',
        },
      },
    },
  },

  { 'RRethy/vim-illuminate' },
  { 'onsails/lspkind.nvim' },

  {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    opts = {},
  },

  -- lsp overloads
  { 'Issafalcon/lsp-overloads.nvim' },

  -- fzf
  {
    'ibhagwan/fzf-lua',
    -- optional for icon support
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    -- or if using mini.icons/mini.nvim
    -- dependencies = { "nvim-mini/mini.icons" },
    opts = {},
  },

  -- inline hints
  {
    'MysticalDevil/inlay-hints.nvim',
    event = 'LspAttach',
    dependencies = { 'neovim/nvim-lspconfig' },
    config = function()
      require('inlay-hints').setup()
    end,
  },

  -- golang setup
  {
    'ray-x/go.nvim',
    dependencies = { -- optional packages
      'ray-x/guihua.lua',
      'neovim/nvim-lspconfig',
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {
      -- lsp_keymaps = false,
      -- other options
    },
    config = function(lp, opts)
      require('go').setup(opts)
      -- local format_sync_grp = vim.api.nvim_create_augroup('GoFormat', {})
      -- vim.api.nvim_create_autocmd('BufWritePre', {
      --   pattern = '*.go',
      --   callback = function()
      --     require('go.format').goimports()
      --   end,
      --   group = format_sync_grp,
      -- })
    end,
    event = { 'CmdlineEnter' },
    ft = { 'go', 'gomod' },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },

  -- {
  --     'ray-x/lsp_signature.nvim',
  --     opts = {
  --         hint_enable = false,
  --     },
  --     config = function(_, opts)
  --         require('lsp_signature').setup(opts)
  --     end,
  -- },
  {
    'mbbill/undotree',
  },
  {
    'NvChad/nvim-colorizer.lua',
    event = { 'BufReadPre', 'BufNewFile' },
    config = true,
  },
  {
    'unblevable/quick-scope',
    config = function()
      vim.api.nvim_create_autocmd('ColorScheme', {
        pattern = '*',
        callback = function()
          local background = vim.api.nvim_get_option 'background'
          if background == 'dark' then
            vim.api.nvim_set_hl(0, 'QuickScopePrimary', { fg = '#d3d3d3', bold = true, underline = true })
            vim.api.nvim_set_hl(0, 'QuickScopeSecondary', { fg = '#d3d3d3', bold = true, italic = true, underline = true })
          else
            vim.api.nvim_set_hl(0, 'QuickScopePrimary', { fg = '#000000', bold = true, underline = true })
            vim.api.nvim_set_hl(0, 'QuickScopeSecondary', { fg = '#000000', bold = true, italic = true, underline = true })
          end
        end,
      })
    end,
  },
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {},
  },
  'nvim-lua/plenary.nvim', -- lua functions that many plugins use
  'inkarkat/vim-ReplaceWithRegister', -- replace with register contents using motion (gr + motion)
  'declancm/maximize.nvim',
  'christoomey/vim-tmux-navigator',
  'prabirshrestha/asyncomplete.vim',
  {
    'aznhe21/actions-preview.nvim',
    opts = {
      telescope = {
        sorting_strategy = 'ascending',
        layout_strategy = 'vertical',
        layout_config = {
          width = 0.8,
          height = 0.4,
          prompt_position = 'top',
          preview_cutoff = 20,
          preview_height = function(_, _, max_lines)
            return max_lines - 15
          end,
        },
      },
    },
  },
  'Hoffs/omnisharp-extended-lsp.nvim',
  'ryanoasis/vim-devicons',
  {
    'vimpostor/vim-tpipeline',
    config = function()
      vim.g.tpipeline_focuslost = 0
    end,
  },
  -- {
  --   'AckslD/muren.nvim',
  --   config = true,
  -- },
  -- {
  --   'windwp/nvim-autopairs',
  --   event = 'InsertEnter',
  --   config = true,
  -- },
  {
    'kyazdani42/nvim-tree.lua',
    dependencies = {
      {
        'b0o/nvim-tree-preview.lua',
        dependencies = {
          'nvim-lua/plenary.nvim',
        },
      },
    },
  },
  { 'Everduin94/nvim-quick-switcher' },
  {
    'sontungexpt/url-open',
    event = 'VeryLazy',
    cmd = 'URLOpenUnderCursor',
    config = function()
      local status_ok, url_open = pcall(require, 'url-open')
      if not status_ok then
        return
      end
      url_open.setup {}
    end,
  },
  -- blade
  {
    'tjdevries/php.nvim',
    config = function()
      require('php').setup {}
    end,
  },

  -- fold enhancement
  {
    'chrisgrieser/nvim-origami',
    event = 'VeryLazy',
    opts = {},
    -- recommended: disable vim's auto-folding
    init = function()
      vim.opt.foldlevel = 99
      vim.opt.foldlevelstart = 99
    end,
  },

  -- hop
  {
    'smoka7/hop.nvim',
    version = '*',
    opts = {
      -- this is the natural order (best to worst for custom steno layout), but plugin expect otherwise
      -- keys = 'blwprstdfaeouihgkmqcvynxjz'
      keys = 'bwrtfeuhkqvnjzxycmgioadspl',
      -- keys = 'zjxnyvcqmkghiuoeafdtsrpwlb'
    },
  },

  -- mini
  -- {
  --   'nvim-mini/mini.ai',
  --   version = '*',
  --   init = function()
  --     require('mini.ai').setup()
  --   end
  -- },

  -- surround (better than mini's surround)
  {
    'kylechui/nvim-surround',
    version = '^4.0.0', -- Use for stability; omit to use `main` branch for the latest features
    event = 'VeryLazy',
  },

  -- todos
  {
    'vimichael/floatingtodo.nvim',
    config = function()
      require('floatingtodo').setup {
        target_file = '~/.local/share/nvim/todo.md',
        border = 'rounded', -- single, rounded, etc.
        width = 1, -- width of window in % of screen size
        height = 0.95, -- height of window in % of screen size
        position = 'center', -- topleft, topright, bottomleft, bottomright
      }
    end,
  },

  -- autoreload file on external change
  {
    'ccntrq/autoreload.nvim',
    opts = {
        autoread = true,
        events = { 'BufEnter', 'FocusGained' },
        timer = {
          enabled = true,
          interval_ms = 3000,
          start_delay_ms = 0,
        },
        notify = {
          on_conflict = true,
          on_reload = false,
        },
      },
  },
}
