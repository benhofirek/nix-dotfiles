return {
	'nvim-telescope/telescope.nvim',
	priority = 100,
	branch = 'master',
	dependencies = {
		'nvim-lua/plenary.nvim',
		{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
		'nvim-tree/nvim-web-devicons',
		{
			'nvim-telescope/telescope-live-grep-args.nvim',
			version = '^1.0.0',
		},
	},
	init = function()
		vim.cmd([[autocmd ColorScheme * hi TelescopeSelection guifg=#98be65 guibg=transparent ]])
	end,
	config = function()
		local telescope = require("telescope")
		local fzf = require('fzf_lib')
		local actions = require("telescope.actions")
		local trouble = require("trouble.providers.telescope")
		local actions = require('telescope.actions')
		local action_state = require('telescope.actions.state')

		telescope.load_extension("fzf")
		telescope.load_extension("live_grep_args")

		telescope.setup {
			defaults = {
				layout_strategy = "vertical",
				sorting_strategy = "ascending",
				layout_config = {
					height = vim.o.lines, -- maximally available lines
          preview_cutoff = 0,
					width = vim.o.columns, -- maximally available columns
					prompt_position = "top",
					preview_height = 0.45,
				},
				file_ignore_patterns = {
          "node_modules",
          ".pnpm-store",
          ".jj",
          "tmp",
          "bin",
          "obj",
          ".venv",
          ".next",
          "dist",
          "build",
          "__pycache__",
          ".cache",
          ".git",
          ".DS_Store",
          "target",
          "coverage",
          "logs",
          "*.log",
          "venv",
          ".idea",
          ".vscode",
					-- "**/*.test.ts",
					-- "**/*.spec.ts"
				},

				path_display = { shorten = 16 },
				mappings = {
					i = {
						["<CR>"] = "select_default",
						["<Tab>"] = "select_tab",
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-q>"] = function(prompt_bufnr)
              actions.smart_send_to_qflist(prompt_bufnr)
              vim.cmd("tab copen")
            end,
						["<C-h>"] = actions.move_selection_previous +
						actions.move_selection_previous +
						actions.move_selection_previous +
						actions.move_selection_previous +
						actions.move_selection_previous,
						["<C-t>"] = actions.move_selection_next +
						actions.move_selection_next +
						actions.move_selection_next +
						actions.move_selection_next +
						actions.move_selection_next,
					},
					n = {
					},
				},
			},
			pickers = {
				find_files = {
          find_command = {
            'rg',
            '--files',
            '--hidden',
            '-g', '!.git/',
            '-g', '!.env',
          }
				},
				buffers = {
					show_all_buffers = true,
					sort_lastused = true
				},
				git_status = {
					git_icons = {
						added = " ",
						changed = " ",
						copied = " ",
						deleted = " ",
						renamed = "➡",
						unmerged = " ",
						untracked = " ",
					},
					previewer = false,
					theme = "dropdown"
				}
			},
			extensions = {
				-- smart_open = {
				--     cwd_only = true,
				--     show_scores = true,
				--     ignore_patterns = {"*.git/*", "*/tmp/*"},
				--     match_algorithm = "fzy",
				--     disable_devicons = false,
				--     open_buffer_indicators = {previous = "👀", others = "🙈"},
				-- },
				fzf = {
					fuzzy = true,                    -- false will only do exact matching
					override_generic_sorter = true,  -- override the generic sorter
					override_file_sorter = true,     -- override the file sorter
					case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
				}
			},

		}
	end
}
