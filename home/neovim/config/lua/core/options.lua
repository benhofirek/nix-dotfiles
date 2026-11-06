local opt = vim.opt -- for conciseness

-- session options
vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- line numbers
opt.relativenumber = true -- show relative line numbers
opt.number = true -- shows absolute line number on cursor line (when relative number is on)

-- tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true -- expand tab to spaces
opt.smartindent = true

-- line wrapping
opt.wrap = false -- disable line wrapping

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

opt.scrolloff = 0

-- cursor line
-- make current line number highlighted but disable line background highlight
opt.cursorline = true -- highlight the current cursor line
vim.api.nvim_create_autocmd('ColorScheme', {
  command = [[highlight CursorLine guibg='#FFF' ]]
})
-- appearance

-- turn on termguicolors for nightfly colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.signcolumn = 'yes' -- show sign column so that text doesn't shift

-- backspace
opt.backspace = 'indent,eol,start' -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append 'unnamedplus' -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- undo settings opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv 'HOME' .. '/.vim/undodir'
opt.undofile = true

-- managed in plugin
-- opt.hlsearch = false
-- opt.incsearch = true

opt.iskeyword:append '-'

-- for whichkey
-- opt.timeout = true
-- opt.timeoutlen = 500

-- cmd('autocmd BufEnter * set formatoptions-=cro)
-- cmd('autocmd BufEnter * setlocal formatoptions-=cro') opt.path = '.,,**'

opt.sessionoptions = 'curdir,folds,globals,help,tabpages,terminal,winsize'

vim.filetype.add({
  extension = {
    ['http'] = 'http',
  },
})

vim.api.nvim_create_user_command("ToggleTheme", function()
  local themery = require("themery")
  local currentTheme = themery.getCurrentTheme()
  if currentTheme and currentTheme.name == "Doom one" then
    themery.setThemeByName("One light", true)
  else
    themery.setThemeByName("Doom one", true)
  end

  -- prevent Lualine status bar from reappearing
  vim.opt.laststatus = 0
end, {})

-- auto add namespace into csharp files
-- local function add_namespace_on_empty_cs_buffer()
--   local filename = vim.api.nvim_buf_get_name(0)
--   if filename:match('%.cs$') and vim.api.nvim_buf_line_count(0) == 1 and vim.api.nvim_buf_get_lines(0, 0, 1, false)[1] == "" then
--     -- Find the directory containing the .csproj file, searching upwards from the current file's path
--     local csproj_file = vim.fn.findfile("*.csproj", vim.fn.fnamemodify(filename, ":p:h") .. ";")
--     local csproj_dir = csproj_file and vim.fn.fnamemodify(csproj_file, ":h") or vim.fn.getcwd()
--
--     if not csproj_dir or csproj_dir == "" then
--       return  -- No .csproj file found, so we exit early
--     end
--
--     -- Calculate relative path to the file and prepare the namespace
--     local root_path = vim.fn.fnamemodify(csproj_dir, ":p")
--     local relative_path = filename:gsub(root_path, ""):gsub("%.cs$", ""):gsub("/", "."):gsub("^%.", "")
--
--     -- Include the folder containing the .csproj file in the namespace
--     local csproj_folder_name = vim.fn.fnamemodify(csproj_dir, ":t")
--     local namespace = csproj_folder_name .. (relative_path ~= "" and ("." .. relative_path) or "")
--
--     -- Insert the namespace if it is valid
--     if namespace and namespace ~= "" then
--       local namespace_statement = "namespace " .. csproj_file .. ";\n"
--       vim.api.nvim_buf_set_lines(0, 0, 0, false, vim.split(namespace_statement, '\n'))
--     end
--   end
-- end
--
--
-- vim.api.nvim_create_autocmd('BufRead', {
--   pattern = '*.cs',
--   callback = add_namespace_on_empty_cs_buffer,
-- })

vim.diagnostic.config({
  severity_sort = true,
})

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local view_group = augroup("auto_view", { clear = true })
autocmd({ "BufWinLeave", "BufWritePost", "WinLeave" }, {
  desc = "Save view with mkview for real files",
  group = view_group,
  callback = function(args)
    if vim.b[args.buf].view_activated then vim.cmd.mkview { mods = { emsg_silent = true } } end
  end,
})
autocmd("BufWinEnter", {
  desc = "Try to load file view if available and enable view saving for real files",
  group = view_group,
  callback = function(args)
    if not vim.b[args.buf].view_activated then
      local filetype = vim.api.nvim_get_option_value("filetype", { buf = args.buf })
      local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })
      local ignore_filetypes = { "gitcommit", "gitrebase", "svg", "hgcommit" }
      if buftype == "" and filetype and filetype ~= "" and not vim.tbl_contains(ignore_filetypes, filetype) then
        vim.b[args.buf].view_activated = true
        vim.cmd.loadview { mods = { emsg_silent = true } }
      end
    end
  end,
})
