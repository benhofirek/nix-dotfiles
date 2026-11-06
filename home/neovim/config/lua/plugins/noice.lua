return {
	'folke/noice.nvim',
	event = 'VeryLazy',
	dependencies = {
		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
		'MunifTanjim/nui.nvim',
		-- OPTIONAL:
		--   `nvim-notify` is only needed, if you want to use the notification view.
		--   If not available, we use `mini` as the fallback
		'rcarriga/nvim-notify',
	},
	init = function()
		vim.cmd [[autocmd ColorScheme * hi NoiceCmdlineIcon guifg=darkgreen ]]
		vim.cmd [[autocmd ColorScheme * hi NoiceCmdlinePopupTitle guifg=darkgreen ]]
		vim.cmd [[autocmd ColorScheme * hi NoiceCmdlinePopupBorder guifg=darkgreen ]]
		vim.cmd [[autocmd ColorScheme * hi NoiceCmdlinePopupBorderLua guifg=darkgreen ]]
		vim.cmd [[autocmd ColorScheme * hi NoiceCmdlinePopupBorderHelp guifg=darkgreen ]]
		vim.cmd [[autocmd ColorScheme * hi NoiceCmdlinePopupBorderInput guifg=darkgreen ]]
		vim.cmd [[autocmd ColorScheme * hi NoiceCmdlinePopupBorderFilter guifg=darkgreen ]]
		vim.cmd [[autocmd ColorScheme * hi NoiceCmdlinePopupBorderSearch guifg=darkgreen ]]
		vim.cmd [[autocmd ColorScheme * hi NoiceCmdlinePopupBorderCmdline guifg=darkgreen ]]
		vim.cmd [[autocmd ColorScheme * hi NoiceCmdlinePopupBorderCalculator guifg=darkgreen ]]
	end,
	opts = {
		timeout = 500,
		stages = 'static',
		lsp = {
			-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
			override = {
				['vim.lsp.util.convert_input_to_markdown_lines'] = true,
				['vim.lsp.util.stylize_markdown'] = true,
				['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
			},
			signature = {
				enabled = false,
			},
		},

		-- you can enable a preset for easier configuration
		presets = {
			bottom_search = true, -- use a classic bottom cmdline for search
			command_palette = true, -- position the cmdline and popupmenu together
			long_message_to_split = true, -- long messages will be sent to a split
			inc_rename = false, -- enables an input dialog for inc-rename.nvim
			lsp_doc_border = false, -- add a border to hover docs and signature help
		},
	},
}
