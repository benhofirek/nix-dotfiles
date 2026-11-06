-- set leader key
vim.g.mapleader = ' '

-- add gM after j/k jump auto?
-- free: '-' / maybe collision in oil

local keymap = vim.keymap -- for conciseness
local opts = { noremap = true, silent = true }
---------------------
----- General remaps
keymap.set('i', '<C-B>', '<Delete>', { noremap = true }) --for zsh autocompletion
keymap.set('t', '<Esc>', '<C-\\><C-n>')
keymap.set('t', '<C-t>', '<C-\\><C-O>')
keymap.set('n', '<leader>M', '<Plug>MarkdownPreviewToggle')

-- Open url under cursor
keymap.set('n', 'g<CR>', '<cmd>URLOpenUnderCursor<cr>')

-- Paste in insert mode
-- keymap.set('i', '<C-v>', '<C-r>+')

-- Miscalenous
-- Because ctrl+i appears same as tab, we have to remap it to distinguish the two
keymap.set('n', '<char-31>[105;5u', '<C-i>', { noremap = true })
-- keymap.set('i', '<80>kb', '<esc>dT ')
-- keymap.set('i', '<Delete>', '<C-w>')
keymap.set('n', 'L', 'Lzz_jk', { noremap = true, silent = true })
keymap.set('n', 'H', 'Hzz_jk', { noremap = true, silent = true })

-- Move between files
-- vim.api.nvim_create_autocmd({ 'UIEnter' }, {
--   callback = function(event)
--     local is_angular = next(vim.fs.find({ 'angular.json', 'nx.json' }, { upward = true }))
--     local is_svelte = next(vim.fs.find({ 'svelte.config.js', 'svelte.config.ts' }, { upward = true }))
--
--     local function find(file_regex, opts)
--       return function()
--         require('nvim-quick-switcher').find(file_regex, opts)
--       end
--     end
--
--     -- Angular
--     if is_angular then
--       vim.keymap.set('n', 'sk', find '.component.ts', opts)
--       vim.keymap.set('n', 'sj', find '.component.html', opts)
--       vim.keymap.set('n', 'sq', find '.component.scss', opts)
--     end
--   end,
-- })

function open_file_with_extension(extension)
  -- Get the directory of the current buffer
  local current_file = vim.fn.expand '%:p'
  local current_dir = vim.fn.fnamemodify(current_file, ':h')

  -- Find the file with the given extension in the current buffer's directory
  local handle = io.popen('ls ' .. current_dir .. '/*.' .. extension)
  local file = handle:read('*a'):gsub('\n', '') -- Remove newline character
  handle:close()

  if file and file ~= '' then
    -- Open the file
    vim.cmd('edit ' .. file)
  else
    print('No .' .. extension .. ' file found in ' .. current_dir)
  end
end

vim.keymap.set('n', 'sk', ":lua open_file_with_extension('component.ts')<cr>", { silent = true })
vim.keymap.set('n', 'sj', ":lua open_file_with_extension('component.html')<cr>", { silent = true })
vim.keymap.set('n', 'sq', ":lua open_file_with_extension('component.scss')<cr>", { silent = true })

-- unstuck line number
keymap.set('n', 'zb', 'zbkj', { noremap = true, silent = true })
keymap.set('n', 'zt', 'ztjk', { noremap = true, silent = true })

-- visual mode advanced editing
keymap.set('v', '<BS>', '"_d', { noremap = true, silent = true })
keymap.set('v', '"', 'c""<Esc>Pl', { noremap = true, silent = true })
keymap.set('v', "'", "c''<Esc>Pl", { noremap = true, silent = true })

-- Jump list
keymap.set('n', '<C-o>', '<C-o>', { desc = 'Jump list previous', noremap = true, silent = true })

-- Symbols Outline
keymap.set('n', '<leader>a', ':SymbolsOutline<cr>', { desc = 'Toggle symbols outline' })

-- navigate between windows shortcut
keymap.set('n', '<C-h>', ':TmuxNavigateLeft<cr>', { desc = 'Switch to left window', silent = true })
keymap.set('n', '<C-j>', ':TmuxNavigateDown<cr>', { desc = 'Switch to bottom window', silent = true })
keymap.set('n', '<C-k>', ':TmuxNavigateUp<cr>', { desc = 'Switch to top window', silent = true })
keymap.set('n', '<C-t>', ':TmuxNavigateRight<cr>', { desc = 'Switch to right window', silent = true })

-- Gitsigns jumping over changes
keymap.set('n', '<C-n>', '<cmd>Gitsigns next_hunk<cr>', opts)
keymap.set('n', '<C-p>', '<cmd>Gitsigns prev_hunk<cr>', opts)

-- Telescope
keymap.set('n', '<leader>u', '<cmd>Telescope find_files<cr>', opts)
keymap.set('n', '<leader>e', ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", opts)
keymap.set('n', '<leader>o', '<cmd>Telescope buffers<cr>', opts)
keymap.set(
  'n',
  '<leader>.',
  [[:lua require'telescope.builtin'.grep_string({search = vim.fn.expand('<cword>')})<CR>]],
  { desc = 'Find string under cursor in cwd', noremap = true, silent = true }
)
keymap.set('n', '<leader>,', function()
  local dir = vim.fn.expand '%:p:h'
  vim.cmd 'tabnew' -- open in new tab
  require('oil').open(dir)
end, { desc = "Open Oil in buffer's directory in new tab" })
keymap.set(
  'n',
  '<BS>',
  [[:lua require'telescope.builtin'.diagnostics({ sort_by = "severity", severity_limit = vim.diagnostic.severity.WARN })<CR>]],
  { desc = '', noremap = true, silent = true }
)

-- Window management
keymap.set('n', '<leader>v', '<C-w>v')
keymap.set('n', '<leader>q', '<C-w>q')
keymap.set('n', '<leader>z', "<Cmd>lua require('maximize').toggle()<CR>", { desc = 'toggle window zoom' })
keymap.set('n', '<leader>h', '<C-w>s', { desc = 'split window horizontally' })
keymap.set('n', '<leader>=', '<C-w>=', { desc = 'make splits equal width' })

-- Tab management
keymap.set('n', '<Delete>', function()
  vim.cmd 'tabc'
end, opts)

-- Undotree
-- keymap.set("n", "<leader>p", vim.cmd.UndotreeToggle)

-- Nvim tree (file explorer)
keymap.set('n', '<Escape>', '<cmd>NvimTreeFindFileToggle<CR><cmd>norm zz<cr>', { desc = 'Toggle file explorer on current file' }) -- toggle file explorer on current file

-- hlslens
local kopts = { noremap = true, silent = true }
keymap.set('n', 'n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], kopts)
keymap.set('n', 'N', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], kopts)
keymap.set('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
keymap.set('n', '\\', [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)

-- clear search highlights
keymap.set('n', '<leader>c', function()
  vim.cmd 'nohl'
  vim.cmd 'NoiceDismiss'
end, { desc = 'Clear screen' })
-- delete single character without copying into register
keymap.set('n', 'x', '"_x')

-- LSP
keymap.set('n', 't', '<cmd>lua vim.lsp.buf.definition()<CR>')
keymap.set('n', 'T', '<cmd>lua vim.lsp.buf.implementation()<CR>')
keymap.set('n', '<Tab>', '<cmd>tab split | lua vim.lsp.buf.definition()<CR>', opts)
keymap.set('n', 'sh', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
keymap.set('n', 'sd', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
keymap.set('n', 'si', function()
  local filetype = vim.bo.filetype

  if filetype == 'typescript' or filetype == 'typescriptreact' or filetype == 'javascript' or filetype == 'javascriptreact' then
    vim.cmd 'TSToolsAddMissingImports'
    vim.cmd 'TSToolsRemoveUnusedImports'
  elseif filetype == 'java' then
    local jdtls_ok, jdtls = pcall(require, 'jdtls')
    if jdtls_ok and jdtls.organize_imports then
      jdtls.organize_imports()
    else
      vim.notify('jdtls.organize_imports not available. Is jdtls attached?', vim.log.levels.WARN)
    end
  else
    print('No specific import handler for filetype: ' .. filetype)
  end
end, opts)
keymap.set('n', 'su', function()
  require("conform").format({
    async = true,
    lsp_format = "fallback",
    timeout_ms = 1000,
  })
end, opts)

function goto_next_diagnostic()
  local severities = {
    vim.diagnostic.severity.ERROR,
    vim.diagnostic.severity.WARN,
    vim.diagnostic.severity.INFO,
    vim.diagnostic.severity.HINT,
  }

  for _, severity in ipairs(severities) do
    local diagnostics = vim.diagnostic.get(0, { severity = { min = severity } })
    if #diagnostics > 0 then
      vim.diagnostic.goto_next { severity = { min = severity } }
      return
    end
  end
end
keymap.set('n', 'se', goto_next_diagnostic, opts)

keymap.set('n', '<leader>j', "<cmd>lua require('fzf-lua').lsp_references() <cr>", { desc = 'Find References' })
keymap.set('n', '<leader>k', "<cmd>lua require('fzf-lua').lsp_live_workspace_symbols() <cr>", { desc = 'Workspace Symbols (Live Search)' })
keymap.set('n', 'so', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
keymap.set('n', 'sa', "<cmd>lua require('actions-preview').code_actions()<cr>", opts)

-- New file
keymap.set('n', '<leader>n', "<cmd>NewFileHere<cr>", { desc = 'Create new file' })

-- Trouble (fixlist)
keymap.set('n', '<leader>t', '<cmd>Trouble diagnostics toggle<cr>')
-- Tests
-- keymap.set('n', '<leader>tf', "<cmd>wa|lua require('neotest').run.run(vim.fn.expand('%'))<cr>", { desc = 'Run file' })
-- keymap.set('n', '<leader>ta', "<cmd>wa|lua require('neotest').run.run(vim.loop.cwd())<cr>", { desc = 'Run all test files' })
-- keymap.set('n', '<leader>tu', "<cmd>wa|lua require('neotest').run.run()<cr>", { desc = 'Run Nearest' })
-- keymap.set('n', '<leader>ts', "<cmd>wa|lua require('neotest').summary.toggle()<cr>", { desc = 'Toggle Summary' })
-- keymap.set('n', '<leader>to', "<cmd>wa|lua require('neotest').output.open({ enter = true, auto_close = true })<cr>", { desc = 'Show Output' })
-- keymap.set('n', '<leader>tp', "<cmd>wa|lua require('neotest').output_panel.toggle()<cr>", { desc = 'Toggle Output Panel' })
-- keymap.set('n', '<leader>tx', "<cmd>wa|lua require('neotest').run.stop()<cr>", { desc = 'Stop' })
-- keymap.set('n', '<leader>tD', "<cmd>wa|lua require('neotest').run.run_last({strategy = 'dap'})<cr>", { desc = 'Debug Last' })
-- keymap.set('n', '<leader>te', "<cmd>wa|lua require('neotest').run.attach()<cr>", { desc = 'Attach' })
-- keymap.set('n', '<leader>tl', "<cmd>wa|lua require('neotest').run.run_last()<cr>", { desc = 'Last' })
-- keymap.set('n', '<leader>td', "<cmd>wa|lua require('neotest').run.run({strategy = 'dap'})<cr>", { desc = 'Debug Nearest' })

-- For Playwright
-- keymap.set('n', '<leader>ta', "<cmd>wa|lua require('neotest').run.run(vim.fn.expand('%'))<cr>", { desc = 'Run file' })
-- keymap.set('n', '<leader>tw', "<cmd>wa|lua require('neotest').run.run(vim.loop.cwd())<cr>", { desc = 'Run all test files' })
-- keymap.set('n', '<leader>tu', "<cmd>wa|lua require('neotest').run.run()<cr>", { desc = 'Run Nearest' })
-- keymap.set('n', '<leader>ts', "<cmd>wa|lua require('neotest').summary.toggle()<cr>", { desc = 'Toggle Summary' })
-- keymap.set('n', '<leader>to', "<cmd>wa|lua require('neotest').output.open({ enter = false, auto_close = true })<cr>", { desc = 'Show Output' })
-- keymap.set('n', '<leader>tp', "<cmd>wa|lua require('neotest').output_panel.toggle()<cr>", { desc = 'Toggle Output Panel' })
-- keymap.set('n', '<leader>tx', "<cmd>wa|lua require('neotest').run.stop()<cr>", { desc = 'Stop' })
-- keymap.set('n', '<leader>te', "<cmd>wa|lua require('neotest').run.attach()<cr>", { desc = 'Attach' })
-- keymap.set('n', '<leader>tl', "<cmd>wa|lua require('neotest').run.run_last()<cr>", { desc = 'Last' })
-- keymap.set('n', '<leader>t.', '<cmd>NeotestPlaywrightPreset<cr>')
-- keymap.set('n', '<leader>t,', '<cmd>NeotestPlaywrightProject<cr>')

-- -- Tab management
keymap.set('n', '1<space>', '1gt')
keymap.set('n', '2<space>', '2gt')
keymap.set('n', '3<space>', '3gt')
keymap.set('n', '4<space>', '4gt')
keymap.set('n', '5<space>', '5gt')
keymap.set('n', '6<space>', '6gt')
keymap.set('n', '7<space>', '7gt')
keymap.set('n', '8<space>', '8gt')
keymap.set('n', '9<space>', '9gt')
keymap.set('n', '10<space>', '10gt')
keymap.set('n', '11<space>', '11gt')
keymap.set('n', '12<space>', '12gt')

---------------------------------------------------------------------------------
-- General keys

-- THE PRIMEAGEN@

keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

keymap.set('n', '<C-d>', '10gjzz0')
keymap.set('n', '<C-u>', '10gkzz0')
keymap.set('n', '<C-f>', '20gjzz0')
keymap.set('n', '<C-b>', '20gkzz0')
keymap.set('n', 'n', 'nzzzv')
keymap.set('n', 'N', 'Nzzzv')

-----------------------------------------------------------------------------------
--- Line numbers at the end of the line

-- local api = vim.api
-- local ns_id = api.nvim_create_namespace("relative_end_line_numbers_italic")
--
-- function place_relative_numbers()
--   api.nvim_buf_clear_namespace(0, ns_id, 0, -1)
--
--   local cursor_line = api.nvim_win_get_cursor(0)[1]
--   local lines = api.nvim_buf_get_lines(0, 0, -1, false)
--
--   for i, line in ipairs(lines) do
--     -- skip cursor line and empty lines
--     if i ~= cursor_line and line:match("%S") then
--       local col = #line
--       local rel_num = math.abs(i - cursor_line)
--       local virt_text = { { tostring(rel_num), "LineNr" } }
--       api.nvim_buf_set_extmark(0, ns_id, i - 1, col, {
--         virt_text = virt_text,
--         virt_text_pos = "eol",
--         hl_mode = "combine",
--       })
--     end
--   end
-- end
--
-- vim.cmd [[
--   augroup RelativeEndLineNumbersItalic
--     autocmd!
--     autocmd CursorMoved,CursorMovedI * lua place_relative_numbers()
--     autocmd BufEnter,BufWritePost * lua place_relative_numbers()
--   augroup END
-- ]]
