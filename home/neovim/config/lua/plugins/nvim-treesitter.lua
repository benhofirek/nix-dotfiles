return    {
	'nvim-treesitter/nvim-treesitter',
	event = { 'BufReadPre', 'BufNewFile' },
  lazy = false,
  branch = 'main',
  build = ':TSUpdate',
	dependencies = {
		'windwp/nvim-ts-autotag',
		-- {
		-- 	'nvim-treesitter/nvim-treesitter-textobjects',
		-- 	lazy = false,
		-- },
	},
  config = function()
    require('nvim-treesitter.config').setup {
      -- enable syntax highlighting
      highlight = {
        enable = true,
      },
      -- enable indentation
      indent = { enable = true },
      -- ensure these language parsers are installed
      ensure_installed = {
        "c_sharp",
        "json",
        "javascript",
        "java",
        "http",
        "typescript",
        "tsx",
        "yaml",
        "html",
        "php",
        "blade",
        "css",
        "prisma",
        "kotlin",
        "markdown",
        "markdown_inline",
        "svelte",
        "graphql",
        "bash",
        "lua",
        "c",
        "vimdoc",
        "query",
        "vim",
        "dockerfile",
        "gitignore",
        "sql",
        "vim",
        "regex",
        "bash",
        "python",
        "go",
        "nix",
      },
      -- enable nvim-ts-context-commentstring plugin for commenting tsx and jsx
      ts_context_commentstring = {
        enable = true,
        enable_autocmd = false,
      },
      -- auto install above language parsers
      auto_install = true,
      mutchup = {
        enable = true,
      },

    }
  end
}


